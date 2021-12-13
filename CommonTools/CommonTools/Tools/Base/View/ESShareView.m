//
//  ESShareView.m
//  Gallop_iOS
//
//  Created by lixuanye on 2020/3/25.
//  Copyright © 2020 homosum. All rights reserved.
//

#import "ESShareView.h"
#import "WXApi.h"

@interface ESShareView()
@property (nonatomic,strong) NSDictionary *model;
//背景
@property (nonatomic,strong) UIView *bgView;
//分享按钮区域
@property (nonatomic,strong) UIView *shareContentView;
@property (nonatomic,strong) NSMutableArray<UIButton *> *shareBtnArr;
@property (nonatomic,strong) UIButton *cancelBtn;
@end

@implementation ESShareView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self setupView];
	}
	return self;
}

- (void)setupView {
	self.hidden = YES;
	[self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.top.equalTo(self);
		make.bottom.equalTo(self).offset(- 124 - kBottomSafeArea);
	}];
	//
	[self.shareContentView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.equalTo(self);
		make.bottom.equalTo(self).offset(0);
		make.height.mas_equalTo(124+kBottomSafeArea);
	}];
	[self.shareBtnArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:44 leadSpacing:100 tailSpacing:100];
	[self.shareBtnArr mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo(CGSizeMake(44, 44));
		make.top.equalTo(self.shareContentView).offset(15);
	}];
	[self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.equalTo(self.shareContentView);
        make.bottom.equalTo(self.shareContentView).offset(-kBottomSafeArea);
		make.height.mas_equalTo(50);
	}];
}

- (void)shareWithModel:(id)model {
	self.model = model;
	self.hidden = NO;
}

#pragma mark - action
- (void)cancelBtnClick {
	self.hidden = YES;
}

- (void)shareBtnClick:(UIButton *)btn {
	//获取分享截图
	switch (btn.tag) {
		case 0: {
			//微信
			[self shareWithModel:self.model type:0];
		}
			break;
		case 1: {
			//朋友圈
			[self shareWithModel:self.model type:1];
		}
			break;
		default:
			break;
	}
}

- (void)shareWithModel:(NSDictionary *)model type:(int)type{
	if([WXApi isWXAppInstalled]){//判断当前设备是否安装微信客户端
		UIImage *imageToShare = QM_IS_STR_NIL([model objectForKey:@"icon"]) ? GetImage(@"app_icon") : [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[model objectForKey:@"icon"]]]];
		//创建多媒体消息结构体
		WXMediaMessage *message = [WXMediaMessage message];
		message.title = [model objectForKey:@"title"];//标题
		message.description = [model objectForKey:@"content"];//描述
		[message setThumbImage:imageToShare];//设置预览图
		
		//创建网页数据对象
		WXWebpageObject *webObj = [WXWebpageObject object];
		webObj.webpageUrl = [model objectForKey:@"link"];//链接
		message.mediaObject = webObj;
		
		SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
		sendReq.bText = NO;//不使用文本信息
		sendReq.message = message;
		sendReq.scene = type;
		
		[WXApi sendReq:sendReq completion:nil];//发送对象实例
	}else{
		//未安装微信应用或版本过低
		NSURL *url = [NSURL URLWithString:[model objectForKey:@"link"]];
		UIImage *imageV = QM_IS_STR_NIL([model objectForKey:@"icon"]) ? GetImage(@"app_icon") : [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[model objectForKey:@"icon"]]]];
		NSString *str = [[model objectForKey:@"title"] stringByAppendingFormat:@"\n%@",[model objectForKey:@"content"]];
		NSArray *items = [NSArray arrayWithObjects:url,imageV,str, nil];
		UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
		[APP_DELEGATE.window.rootViewController presentViewController:activityViewController animated:YES completion:nil];
	}
}

#pragma mark - lazy init
//背景
- (UIView *)bgView {
	if (!_bgView) {
		_bgView = [UIView new];
		_bgView.backgroundColor = RGBACOLOR(0, 0, 0, 0.3);
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelBtnClick)];
		[_bgView addGestureRecognizer:tap];
		[self addSubview:_bgView];
	}
	return _bgView;
}
//分享区域
- (UIView *)shareContentView {
	if (!_shareContentView) {
		_shareContentView = [UIView new];
		_shareContentView.backgroundColor = [UIColor whiteColor];
		[self addSubview:_shareContentView];
	}
	return _shareContentView;
}

- (NSMutableArray<UIButton *> *)shareBtnArr {
	if (!_shareBtnArr) {
		_shareBtnArr = [NSMutableArray array];
		NSArray *imageArr = @[@"微信",@"朋友圈"];
		for (NSUInteger i = 0; i < 2; i++) {
			UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
			[btn setImage:GetImage(imageArr[i]) forState:UIControlStateNormal];
			btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
			btn.tag = i;
			[btn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
			[self.shareContentView addSubview:btn];
			[_shareBtnArr addObject:btn];
		}
	}
	return _shareBtnArr;
}

- (UIButton *)cancelBtn {
	if (!_cancelBtn) {
		_cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		[_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
		_cancelBtn.titleLabel.font = fcFont(16);
		[_cancelBtn setTitleColor:ColorAppBlack forState:UIControlStateNormal];
		[_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
		[self.shareContentView addSubview:_cancelBtn];
	}
	return _cancelBtn;
}
@end
