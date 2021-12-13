//
//  WebViewURLViewController.m
//  tableview嵌套webview
//
//  Created by WOSHIPM on 16/7/2.
//  Copyright © 2016年 WOSHIPM. All rights reserved.
//

#import "WebViewURLViewController.h"
#import "IMYWebView.h"
#import "WechatManager.h"

#import "IdentifyViewController.h"
#import "AMBaseUserHomepageViewController.h"
#import "VideoPlayerViewController.h"
#import "GoodsPartViewController.h"
#import "AuctionItemDetailViewController.h"
#import "AuctionSpecialDetailViewController.h"

@interface WebViewURLViewController ()<IMYWebViewDataSource>
@property(nonatomic, weak) IBOutlet IMYWebView *webView;
@property (nonatomic ,copy) NSString *urlString;
@property (nonatomic ,copy) NSString *naviTitle;
@end

@implementation WebViewURLViewController {
    BOOL _hadLogin;
}

- (instancetype)initWithUrlString:(NSString *_Nullable)urlString {
	if (self = [super init]) {
		self.urlString = urlString;
	}return self;
}

- (instancetype)initWithUrlString:(NSString *_Nullable)urlString withTitle:(NSString *_Nullable)naviTitle {
    if (self = [super init]) {
        self.urlString = urlString;
        self.navigationBarTitle = naviTitle;
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    
    self.webView.backgroundColor = Color_Whiter;
    self.webView.dataSource = self;
    self.webView.scrollView.bounces = YES;
    if (self.needSafeAreaBottomHeight) {
        self.webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, -SafeAreaBottomHeight, 0);
    }
    
    if ([_urlString hasPrefix:@"http://"] || [_urlString hasPrefix:@"https://"]) {
        NSURL *url = [NSURL URLWithString:_urlString];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    }else {
        [self loadHtmlContent:_urlString];
    }
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:![ToolUtil isEqualToNonNull:self.navigationBarTitle] animated:YES];
	if ([ToolUtil isEqualToNonNull:self.navigationBarTitle]) {
		[self.navigationItem setTitle:_navigationBarTitle];
	}
    
    if (self.isShare) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareResp:) name:WXShareResult object:nil];
    }
}

- (void)clickToReload:(id)sender {
    [self.webView callHandler:@"refreshPage" data:[@{@"needReload":@"true"} yy_modelToJSONString] completionHandler:^(id  _Nonnull responseData) {
        NSLog(@"refreshPage - %@",responseData);
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.isShare) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:WXShareResult object:nil];
    }
}

- (void)shareResp:(NSNotification *)noti {
    NSDictionary *dict = [noti.object yy_modelToJSONObject];
    if ([dict[@"isFinish"] boolValue]) {
        [SVProgressHUD showSuccess:@"分享完成" completion:nil];
    }else {
        [SVProgressHUD showError:[NSString stringWithFormat:@"分享失败，%@",dict[@"errorStr"]] completion:nil];
    }
}

#pragma mark - 保存图片
// 保存图片错误提示方法
- (void)image:(UIImage *)image didFinshSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *mes = nil;
    if (error != nil) {
        mes = @"保存图片失败";
    } else {
        mes = @"保存图片成功";
    }
    SingleAMAlertView *alert = [SingleAMAlertView shareInstance];
    alert.title = mes;
    [alert show];
}

#pragma mark - IMYWebViewDataSource
- (void)webView:(IMYWebView *)webView didSelectedJSForArtistAuth:(id)sender {
    [self.navigationController pushViewController:[[IdentifyViewController alloc] init] animated:YES];
}

- (void)webView:(IMYWebView *)webView didSelectedJSForLogin:(id)sender {
    @weakify(self);
    [self jumpToLoginWithBlock:^(id  _Nullable data) {
        @strongify(self);
        [self clickToReload:nil];
    }];
}

- (void)webView:(IMYWebView *)webView didSelectedJSForSaveImage:(id)imageData {
    if (imageData) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
        UIAlertAction *save = [UIAlertAction actionWithTitle:@"保存" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            NSURL *baseImageUrl = [NSURL URLWithString:imageData];
            NSData *imageData = [NSData dataWithContentsOfURL:baseImageUrl];
            UIImage *image = [UIImage imageWithData:imageData];
            if (image) {
                UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinshSavingWithError:contextInfo:), NULL);
            }
        }];
        [alert addAction:cancel];
        [alert addAction:save];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)webView:(IMYWebView *)webView didSelectedJSForShare:(NSInteger)shareType data:(id _Nullable)data {
    NSDictionary *datas = (NSDictionary *)data;
    if (datas && datas.count) {
        NSDictionary *params = @{@"title":datas[@"title"],
                                 @"des":datas[@"subtitle"],
                                 @"img":datas[@"icon"],
                                 @"url":[ToolUtil isEqualToNonNullKong:[NSString stringWithFormat:@"%@%@",AMSharePrefix,datas[@"url"]]]
        };
        [[WechatManager shareManager] wxSendReqWithScene:shareType?AMShareViewItemStyleWXFriend:AMShareViewItemStyleWX withParams:params];
    }else {
        [SVProgressHUD showError:@"数据错误，请联系客服或重试"];
    }
}

- (void)webView:(IMYWebView *)webView didSelectedJSForArtistPage:(id)data {
    if (![UserInfoManager shareManager].isLogin) {
        @weakify(self);
        [self jumpToLoginWithBlock:^(id  _Nullable data) {
            @strongify(self);
            [self clickToReload:nil];
        }];
        return;
    }
    NSDictionary *datas = (NSDictionary *)data;
    if (datas && datas.count) {
        AMBaseUserHomepageViewController * vc = [[AMBaseUserHomepageViewController alloc] init];
        vc.artuid = [ToolUtil isEqualToNonNull:[datas objectForKey:@"data"] replace:@"0"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)webView:(IMYWebView *)webView didSelectedJSForVideoPage:(id)data {
    NSDictionary *datas = (NSDictionary *)data;
    if (datas && datas.count) {
        VideoPlayerViewController *videoDetail = [[VideoPlayerViewController alloc] initWithVideoID:[ToolUtil isEqualToNonNull:[datas objectForKey:@"data"] replace:@"0"]];
        [self.navigationController pushViewController:videoDetail animated:YES];
    }
}

- (void)webView:(IMYWebView *)webView didSelectedJSForProductPage:(id)data {
    NSDictionary *datas = (NSDictionary *)data;
    if (datas && datas.count) {
        GoodsPartViewController *detailVC = [[GoodsPartViewController alloc] init];
        detailVC.goodsID = [ToolUtil isEqualToNonNull:[datas objectForKey:@"data"] replace:@"0"];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

- (void)webView:(IMYWebView *)webView didSelectedJSForAuctionFieldPage:(id)data {
    NSDictionary *datas = (NSDictionary *)data;
    if (datas && datas.count) {
        AuctionSpecialDetailViewController *detailVC = [[AuctionSpecialDetailViewController alloc] init];
        detailVC.auctionFieldId = [ToolUtil isEqualToNonNull:[datas objectForKey:@"data"] replace:@"0"];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

- (void)webView:(IMYWebView *)webView didSelectedJSForAuctionGoodsPage:(id _Nullable)data {
    NSDictionary *datas = (NSDictionary *)data;
    if (datas && datas.count) {
        AuctionItemDetailViewController *detailVC = [[AuctionItemDetailViewController alloc] init];
        detailVC.auctionGoodId = [ToolUtil isEqualToNonNull:[datas objectForKey:@"data"] replace:@"0"];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}


#pragma mark -
- (void)loadHtmlContent:(NSString *_Nullable)content {
	[self.webView loadHTMLString:[ToolUtil html5StringWithContent:content withTitle:nil] baseURL:nil];
}

#pragma mark -
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) return nil;

    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) return nil;
    return dic;
}
- (NSDictionary*)returnDictionaryWithDataPath:(NSData*)data {
    NSString *receiveStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSData * datas = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingMutableLeaves error:nil];
    return jsonDict;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
