//
//  WTCContentViewController.m
//  ESTicket
//
//  Created by Homosum on 2017/12/18.
//  Copyright © 2017年 九辰_王添诚. All rights reserved.
//

#import "WTCContentViewController.h"
#import "CheckstandViewController.h"
#import "OfficialRecommendViewController.h"
#import "ESShareView.h"
#import "dsbridge.h"
#import "ShopProductShareView.h"

@interface WTCContentViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) DWKWebView*kwebView;

//刷新控件
@property (nonatomic, strong) UIView*refreshView;
//商品分享
@property (nonatomic, strong) ShopProductShareView *productShareView;

@end

@implementation WTCContentViewController

#pragma mark - lify cycel
- (void)viewDidLoad {
	[super viewDidLoad];
	if (!QM_IS_STR_NIL(self.url)) {
		NSDate *datenow = [NSDate date];
		NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)([datenow timeIntervalSince1970]*1000)];
		[self.url stringByAppendingFormat:@"?_t=%@",timeSp];
		[self loadRequstWithURLString:self.url];
	}
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	if (self.contentType == WTCContentTypeDefault) {
		self.tabBarController.tabBar.hidden = NO;
		self.navigationController.navigationBarHidden = YES;
		
	}else if(self.contentType == WTCContentTypeNav){
		self.tabBarController.tabBar.hidden = YES;
		self.navigationController.navigationBarHidden = NO;
	}else{
		self.tabBarController.tabBar.hidden = YES;
		self.navigationController.navigationBarHidden = YES;
	}
}

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	if (self.contentType == WTCContentTypeDefault) {
		self.tabBarController.tabBar.hidden = NO;
		[self.navigationController setNavigationBarHidden:YES];
	}else if(self.contentType == WTCContentTypeNav){
		self.tabBarController.tabBar.hidden = YES;
		self.navigationController.navigationBarHidden = NO;
	}
	
	[self.kwebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
	[self.kwebView addJavascriptObject:self namespace:@"gallop"];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDidBecomeHidden:) name:UIWindowDidBecomeHiddenNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	self.navigationController.navigationBarHidden = NO;
	if (self.contentType == WTCContentTypeDefault) {
		self.tabBarController.tabBar.hidden = NO;
		[self.navigationController setNavigationBarHidden:YES];
	}
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[self.kwebView removeObserver:self forKeyPath:@"title" context:nil];
	[self.kwebView removeJavascriptObject:@"gallop"];
}

-(void)loadRequstWithURLString:(NSString *)url
{
	[self.kwebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:0 timeoutInterval:15.0]];
}

-(void)loadView{
	[super loadView];
	self.view.backgroundColor = [UIColor whiteColor];
	[self initWithSubView];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidLogin:) name:kESDidLoginNotification object:nil];
	
	self.fd_prefersNavigationBarHidden = YES;
	self.fd_interactivePopDisabled = NO;
}

- (void)initWithSubView{
	[self.view addSubview:self.kwebView];
	
	UIView*redView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, IphoneBarHeight)];
	redView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:redView];
	self.view.backgroundColor = DefaultBackgroundColor;
	
	[self.view addSubview:self.refreshView];
}

#pragma mark - action
//刷新
- (void)refresh {
	[self loadRequstWithURLString:self.url];
}

#pragma mark - kvo
// 根据监听 实时修改title
- (void)observeValueForKeyPath:(NSString *)keyPath
					  ofObject:(id)object
						change:(NSDictionary<NSString *,id> *)change
					   context:(void *)context
{
	if ([keyPath isEqualToString:@"title"]) {
		if (object == self.kwebView)
			{
			self.title = self.kwebView.title;
			}
		else {
			[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
		}
	}
}

-(void)windowDidBecomeHidden:(NSNotification *)noti{
	[[UIApplication sharedApplication] setStatusBarHidden:false animated:false];
}

- (void)appDidLogin:(NSNotification *)notification{
	if ([[[notification userInfo] objectForKey:@"toDo"] isEqualToString:@"login"]) {
		dispatch_main_async_safe(^{
			[self loadRequstWithURLString:self.url];
		});
	}
	if ([[[notification userInfo] objectForKey:@"toDo"] isEqualToString:@"register"]) {
		dispatch_main_async_safe(^{
			[self loadRequstWithURLString:self.url];
		});
	}
}

#pragma mark - webview delegate
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
	[self loadRequstWithURLString:self.url];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
	
	// 页面开始加载时调用
	[ES_LPUnitily addHUDToCurrentViewWithString:@"加载中..."];
	WTCLog(@"%@",[webView.URL absoluteString]);
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
	
	WTCLog(@"%@",[webView.URL absoluteString]);
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
	// 接收到服务器跳转请求之后调用
	WTCLog(@"%@",[webView.URL absoluteString]);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
	[ES_LPUnitily removeHUDToCurrentView];
	self.refreshView.hidden = YES;
	
	WTCLog(@"%@",[webView.URL absoluteString]);
	
	self.title = webView.title;
	
	//禁止长按弹出框
	[webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];
	
	//禁止捏合
	NSString *injectionJSString = @"var script = document.createElement('meta');"
	"script.name = 'viewport';"
	"script.content=\"width=device-width, user-scalable=no\";"
	"document.getElementsByTagName('head')[0].appendChild(script);";
	[webView evaluateJavaScript:injectionJSString completionHandler:nil];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
	[self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
	[ES_LPUnitily removeHUDToCurrentView];
	self.refreshView.hidden = NO;
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
	if (error.code==-999) {
		return;
	}
	[ES_LPUnitily removeHUDToCurrentView];
	self.refreshView.hidden = NO;
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
	decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
	decisionHandler (WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler{
	if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
		if (challenge.previousFailureCount == 0) {
			NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
			completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
		}else {
			// 验证失败，取消本次验证
			completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
		}
	}else {
		completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - 商品分享
- (void)shareWithModel:(ProductShareModel *)model {
	[self.productShareView productShareWithModel:model];
}

#pragma mark - 开放接口
- (NSString *)goNative:(NSNumber *)type
{
	OfficialRecommendViewController *vc = [OfficialRecommendViewController new];
	if (type.intValue == 1) {
		vc.type = 0;
	} else {
		vc.type = 2;
	}
	
	vc.hidesBottomBarWhenPushed = YES;
	[self.navigationController pushViewController:vc animated:YES];
	return @"iOS";
}

//获取平台信息
- (NSString *)getPlatform:(NSString *)msg {
	return @"iOS";
}

//打开内嵌浏览器跳转加载url
- (NSString *)openWebView:(NSString *)jsonStr{
	NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
	NSError *error;
	NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData
														 options:NSJSONReadingMutableContainers
														   error:&error];
	WTCContentViewController *vc = [[WTCContentViewController alloc] init];
	vc.url = dict[@"url"];
	if ([dict[@"showNavTitle"] isEqualToString:@"ture"]) {
		vc.contentType = WTCContentTypeNav;
	} else {
		vc.contentType = WTCContentTypeOther;
	}
	vc.hidesBottomBarWhenPushed = YES;
	[self.navigationController pushViewController:vc animated:YES];
	return @"iOS";
}

//关闭页面
- (NSString *)close:(NSString *)msg {
	[self.navigationController popViewControllerAnimated:YES];
	return @"iOS";
}

//获取token
- (NSString *)isLogin:(NSString *)msg {
	if (![App_Utility checkCurrentUser]) {
		[App_Utility showLoginViewController];
		return @"false";
	} else {
		return @"true";
	}
}

//获取userId
- (NSString *)getUserInfo:(NSString *)msg {
	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
	if (!QM_IS_STR_NIL(App_Utility.currentUser.userId.stringValue)) {
		[dict setObject:App_Utility.currentUser.userId.stringValue forKey:@"userId"];
	}
	if (!QM_IS_STR_NIL(App_Utility.currentUser.token)) {
		[dict setObject:App_Utility.currentUser.token forKey:@"token"];
	}
	
	return dict.JSONString;
}

//跳转收银台
- (NSString *)goCheckstand:(NSString *)jsonStr {
	NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
	NSError *error;
	NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData
														 options:NSJSONReadingMutableContainers
														   error:&error];
	
	//跳转收银台
	CheckstandViewController *vc = [[CheckstandViewController alloc] init];
	vc.orderId = [dict[@"orderId"] integerValue];
	vc.money = [dict[@"money"] floatValue];
	vc.isFormShop = YES;
	[self.navigationController pushViewController:vc animated:YES];
	return @"iOS";
}

//分享商品
- (NSString *)shareProduct:(NSString *)productId {
	[ESNetworkService getProductShareUrl:productId.integerValue Response:^(id dict, ESError *error) {
		if (dict&&[dict[@"code"] integerValue] == 0) {
			dispatch_main_async_safe(^{
				[self shareWithModel:[ProductShareModel mj_objectWithKeyValues:dict[@"data"]]];
			});
		} else {
			
		}
	}];
	return @"iOS";
}

- (void)canBack:(NSString *)msg :(JSCallback)completionHandler{
	if (self.kwebView.canGoBack) {
		completionHandler(@"true",YES);
	} else {
		completionHandler(@"false",YES);
	}
}

- (NSString *)goLogin {
	[App_Utility showLoginViewController];
	return @"iOS";
}

#pragma mark - lazy init
-(WKWebView*)kwebView
{
	if (!_kwebView) {
		if (self.contentType == WTCContentTypeOther) {
			_kwebView=[[DWKWebView alloc] initWithFrame:CGRectMake(0, IphoneBarHeight, kScreen_Width, kScreen_Height-IphoneBarHeight-kBottomSafeArea)];
		}else if (self.contentType == WTCContentTypeNav){
			_kwebView=[[DWKWebView alloc] initWithFrame:CGRectMake(0, NavBarHeight, kScreen_Width, kScreen_Height-NavBarHeight-kBottomSafeArea)];
		}else{
			_kwebView=[[DWKWebView alloc] initWithFrame:CGRectMake(0, IphoneBarHeight, kScreen_Width, kScreen_Height-IphoneBarHeight-kTabBarHeight)];
		}
		
		_kwebView.navigationDelegate=self;
		_kwebView.backgroundColor = [UIColor whiteColor];
		_kwebView.allowsBackForwardNavigationGestures = YES;
		_kwebView.scrollView.bounces = NO;
		if (@available(iOS 11.0, *)){
			_kwebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
		}
	}
	return _kwebView;
}

- (ShopProductShareView *)productShareView {
	if (!_productShareView) {
		_productShareView = [[ShopProductShareView alloc] initWithFrame:self.view.bounds];
		[self.view addSubview:_productShareView];
		[self.view bringSubviewToFront:_productShareView];
	}
	return _productShareView;
}

- (UIView *)refreshView {
	if (!_refreshView) {
		_refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
		_refreshView.backgroundColor = [UIColor whiteColor];
		_refreshView.userInteractionEnabled = YES;
		[self.view addSubview:_refreshView];
		[self.view bringSubviewToFront:_refreshView];
		
		UIImageView *imageView = [UIImageView new];
		imageView.image = GetImage(@"no_data");
		[_refreshView addSubview:imageView];
		
		UILabel *label = [UILabel new];
		label.textColor = RGBCOLOR(231, 231, 231);
		label.font = fcFont(16);
		label.text = @"加载失败,请重试";
		[_refreshView addSubview:label];
		
		//调整布局
		[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.equalTo(_refreshView);
			make.centerY.equalTo(_refreshView).offset(-10);
			make.size.mas_equalTo(CGSizeMake(300, 300));
		}];
		[label mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.equalTo(imageView);
			make.top.equalTo(imageView.mas_bottom).offset(5);
		}];
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refresh)];
		[_refreshView addGestureRecognizer:tap];
		_refreshView.hidden = YES;
	}
	return _refreshView;
}

@end
