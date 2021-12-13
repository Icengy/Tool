//
//  IMYWebView.m
//  IMY_ViewKit
//
//  Created by ljh on 15/7/1.
//  Copyright (c) 2015年 IMY. All rights reserved.
//

#import "IMYWebView.h"

#import <TargetConditionals.h>
#import <dlfcn.h>
#import "AMWKWebViewJavascriptBridge.h"

@interface IMYWebView()<WKNavigationDelegate,WKUIDelegate, WKScriptMessageHandler>

@property (nonatomic, assign) double estimatedProgress;
@property (nonatomic, strong) NSURLRequest *originRequest;
@property (nonatomic, strong) NSURLRequest *currentRequest;

@property (nonatomic, strong) AMWKWebViewJavascriptBridge *bridge;

@property (nonatomic, copy) NSString *title;

@end

@implementation IMYWebView

@synthesize realWebView = _realWebView;
@synthesize scalesPageToFit = _scalesPageToFit;

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _initMyself];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self _initMyself];
    }
    return self;
}

- (void)_initMyself
{
    [self initWKWebView];
    self.scalesPageToFit = YES;
    
    [self initJavaBridge];
    
    [self.realWebView setFrame:self.bounds];
    [self.realWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self addSubview:self.realWebView];
}

-(void)initWKWebView
{
    WKWebViewConfiguration* configuration = [[NSClassFromString(@"WKWebViewConfiguration") alloc] init];
    configuration.preferences = [NSClassFromString(@"WKPreferences") new];
    
    configuration.userContentController = [NSClassFromString(@"WKUserContentController") new];
    
    WKWebView * webView = [[NSClassFromString(@"WKWebView") alloc] initWithFrame:self.bounds configuration:configuration];
    webView.UIDelegate = self;
//    webView.navigationDelegate = self;
    
    webView.backgroundColor = [UIColor clearColor];
    webView.opaque = NO;
    
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
    _realWebView = webView;
}

- (void)initJavaBridge {
    if (!_bridge) {
        [AMWKWebViewJavascriptBridge enableLogging];
        _bridge = [AMWKWebViewJavascriptBridge bridgeForWebView:self.realWebView];
        [_bridge setWebViewDelegate:self];
        
        /// 验证登录
        @weakify(self);
        [_bridge registerHandler:_bridge.verifyLoginMethod handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"verifyLogin - %@",data);
            if ([UserInfoManager shareManager].isLogin) {
                NSDictionary *userData = [[UserInfoManager shareManager] readUserData];
                NSString *userDataJsonStr = [userData yy_modelToJSONString];
                if (responseCallback) responseCallback(userDataJsonStr);
            }else {
                if (self.dataSource && [self.dataSource respondsToSelector:@selector(webView:didSelectedJSForLogin:)]) {
                    [self.dataSource webView:self didSelectedJSForLogin:nil];
                }
                if (responseCallback) responseCallback(@"");
            }
        }];
        
        /// 跳转艺术家认证
        [_bridge registerHandler:_bridge.goArtistAuthMethod handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"goArtistAuthMethod - %@",data);
            @strongify(self);
            if (self.dataSource && [self.dataSource respondsToSelector:@selector(webView:didSelectedJSForArtistAuth:)]) {
                [self.dataSource webView:self didSelectedJSForArtistAuth:nil];
            }
        }];
        
        /// 微信分享
        [_bridge registerHandler:_bridge.friendShareMethod handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"friendShareMethod - %@",data);
            if (self.dataSource && [self.dataSource respondsToSelector:@selector(webView:didSelectedJSForShare:data:)]) {
                [self.dataSource webView:self didSelectedJSForShare:0 data:data];
            }
        }];
        
        /// 朋友圈分享
        [_bridge registerHandler:_bridge.ranksShareMethod handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"ranksShareMethod - %@",data);
            if (self.dataSource && [self.dataSource respondsToSelector:@selector(webView:didSelectedJSForShare:data:)]) {
                [self.dataSource webView:self didSelectedJSForShare:1 data:data];
            }
        }];
        
        ///图片保存
        [_bridge registerHandler:_bridge.saveImgMethod handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"saveImgMethod - %@",data);
            NSDictionary *imageData = (NSDictionary *)[data objectForKey:@"data"];
            if (self.dataSource && [self.dataSource respondsToSelector:@selector(webView:didSelectedJSForSaveImage:)]) {
                [self.dataSource webView:self didSelectedJSForSaveImage:imageData];
            }
        }];
        
        /// 跳转艺术家主页
        [_bridge registerHandler:_bridge.goArtistPageMethod handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"goArtistPageMethod - %@",data);
            if (self.dataSource && [self.dataSource respondsToSelector:@selector(webView:didSelectedJSForArtistPage:)]) {
                [self.dataSource webView:self didSelectedJSForArtistPage:data];
            }
        }];
        
        /// 跳转短视频主页
        [_bridge registerHandler:_bridge.goVideoPageMethod handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"goVideoPageMethod - %@",data);
            if (self.dataSource && [self.dataSource respondsToSelector:@selector(webView:didSelectedJSForVideoPage:)]) {
                [self.dataSource webView:self didSelectedJSForVideoPage:data];
            }
        }];
        
        /// 跳转商品主页
        [_bridge registerHandler:_bridge.goProductPageMethod handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"goProductPageMethod - %@",data);
            if (self.dataSource && [self.dataSource respondsToSelector:@selector(webView:didSelectedJSForProductPage:)]) {
                [self.dataSource webView:self didSelectedJSForProductPage:data];
            }
        }];
        
        [_bridge registerHandler:_bridge.getPageHeightMethod handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"getPageHeightMethod - %@",data);
            if (self.dataSource && [self.dataSource respondsToSelector:@selector(webView:didSelectedGetPageHeightMethod:)]) {
                [self.dataSource webView:self didSelectedGetPageHeightMethod:data];
            }
        }];
        
        /// 跳转拍场
        [_bridge registerHandler:_bridge.goAuctionFieldMethod handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"getPageHeightMethod - %@",data);
            if (self.dataSource && [self.dataSource respondsToSelector:@selector(webView:didSelectedJSForAuctionFieldPage:)]) {
                [self.dataSource webView:self didSelectedJSForAuctionFieldPage:data];
            }
        }];
        
        /// 跳转拍品
        [_bridge registerHandler:_bridge.goAuctionGoodsMethod handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"getPageHeightMethod - %@",data);
            if (self.dataSource && [self.dataSource respondsToSelector:@selector(webView:didSelectedJSForAuctionGoodsPage:)]) {
                [self.dataSource webView:self didSelectedJSForAuctionGoodsPage:data];
            }
        }];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"estimatedProgress"])
    {
        self.estimatedProgress = [change[NSKeyValueChangeNewKey] doubleValue];
    }
    else if([keyPath isEqualToString:@"title"])
    {
        self.title = change[NSKeyValueChangeNewKey];
    }
    else if ([keyPath isEqualToString:@"contentSize"])
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            CGSize size = [self.realWebView scrollView].contentSize;
            if (self.delegate && [self.delegate respondsToSelector:@selector(webViewDidFinishLoad:withContentSize:)]) {
                [self.delegate webViewDidFinishLoad:self withContentSize:size];
            }
        });
    }
}

#pragma mark- WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    webView.allowsBackForwardNavigationGestures = YES;
    BOOL resultBOOL = [self callback_webViewShouldStartLoadWithRequest:navigationAction.request navigationType:navigationAction.navigationType];
    BOOL isLoadingDisableScheme = [self isLoadingWKWebViewDisableScheme:navigationAction.request.URL];
    
    if(resultBOOL && !isLoadingDisableScheme) {
        self.currentRequest = navigationAction.request;
        if(navigationAction.targetFrame == nil) {
            [webView loadRequest:navigationAction.request];
        }
        decisionHandler(WKNavigationActionPolicyAllow);
    }else {
        decisionHandler(WKNavigationActionPolicyCancel);
    }
}

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    webView.allowsBackForwardNavigationGestures = YES;
    [SVProgressHUD show];
    [self callback_webViewDidStartLoad];
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    webView.allowsBackForwardNavigationGestures = YES;
    [SVProgressHUD dismiss];
    [self callback_webViewDidFinishLoad];
}
- (void)webView:(WKWebView *) webView didFailProvisionalNavigation: (WKNavigation *) navigation withError: (NSError *) error
{
    [SVProgressHUD dismiss];
    [self callback_webViewDidFailLoadWithError:error];
}
- (void)webView: (WKWebView *)webView didFailNavigation:(WKNavigation *) navigation withError: (NSError *) error
{
    [SVProgressHUD dismiss];
    [self callback_webViewDidFailLoadWithError:error];
}
#pragma mark- WKUIDelegate
///--  还没用到
#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
//    if (self.delegate) {
//        if ([message.name isEqualToString:@"friendShare"]) {/// 分享至微信好友
//            if( [self.delegate respondsToSelector:@selector(webView:didSelectedJSForShare:data:)]) {
//                [self.delegate webView:self didSelectedJSForShare:0 data:navigationAction.request.URL.query];
//            }
//        }
//        if ([message.name isEqualToString:@"ranksShare"]) {/// 分享至微信朋友圈
//            if( [self.delegate respondsToSelector:@selector(webView:didSelectedJSForShare:data:)]) {
//                [self.delegate webView:self didSelectedJSForShare:1 data:navigationAction.request.URL.query];
//            }
//        }
//        if ([message.name isEqualToString:@"saveImg"]) {/// 保存照片
//            if( [self.delegate respondsToSelector:@selector(webView:didSelectedJSForSaveImage:)]) {
//                [self.delegate webView:self didSelectedJSForSaveImage:nil];
//            }
//        }
//    }
}

#pragma mark- CALLBACK IMYVKWebView Delegate

- (void)callback_webViewDidFinishLoad {
//	[SVProgressHUD dismiss];
    if([self.delegate respondsToSelector:@selector(webViewDidFinishLoad:)])
    {
        [self.delegate webViewDidFinishLoad:self];
    }
}
- (void)callback_webViewDidStartLoad
{
    if([self.delegate respondsToSelector:@selector(webViewDidStartLoad:)])
    {
        [self.delegate webViewDidStartLoad:self];
    }
}
- (void)callback_webViewDidFailLoadWithError:(NSError *)error {
//	[SVProgressHUD dismiss];
    if([self.delegate respondsToSelector:@selector(webView:didFailLoadWithError:)])
    {
        [self.delegate webView:self didFailLoadWithError:error];
    }
}

-(BOOL)callback_webViewShouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(WKNavigationType)navigationType {
//    [SVProgressHUD show];{
//	[SVProgressHUD show];
    BOOL resultBOOL = YES;
    if([self.delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)])
    {
        if(navigationType == -1) {
            navigationType = WKNavigationTypeOther;
        }
        resultBOOL = [self.delegate webView:self shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    return resultBOOL;
}

#pragma mark- 基础方法
///判断当前加载的url是否是WKWebView不能打开的协议类型
- (BOOL)isLoadingWKWebViewDisableScheme:(NSURL *)url
{
    BOOL retValue = NO;
    
    //判断是否正在加载WKWebview不能识别的协议类型：phone numbers, email address, maps, etc.
    if([url.scheme isEqualToString:@"tel"]) {
        UIApplication *app = [UIApplication sharedApplication];
        if ([app canOpenURL:url]) {
            [app openURL:url options:@{} completionHandler:nil];
            retValue = YES;
        }
    }
    
    return retValue;
}

-(UIScrollView *)scrollView
{
    return [(id)self.realWebView scrollView];
}

- (id)loadRequest:(NSURLRequest *)request
{
    self.originRequest = request;
    self.currentRequest = request;
    
    return [(WKWebView*)self.realWebView loadRequest:request];
}
- (id)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL
{
    return [(WKWebView*)self.realWebView loadHTMLString:string baseURL:baseURL];
}
-(NSURLRequest *)currentRequest
{
    return _currentRequest;
}
-(NSURL *)URL
{
    return [(WKWebView*)self.realWebView URL];
}
-(BOOL)isLoading
{
    return [self.realWebView isLoading];
}
-(BOOL)canGoBack
{
    return [self.realWebView canGoBack];
}
-(BOOL)canGoForward
{
    return [self.realWebView canGoForward];
}

- (id)goBack
{
    return [(WKWebView*)self.realWebView goBack];
}
- (id)goForward
{
    return [(WKWebView*)self.realWebView goForward];
}
- (id)reload
{
    return [(WKWebView*)self.realWebView reload];
}
- (id)reloadFromOrigin
{
    return [(WKWebView*)self.realWebView reloadFromOrigin];
}
- (void)stopLoading
{
    [self.realWebView stopLoading];
}

- (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^)(id, NSError *))completionHandler
{
        return [(WKWebView*)self.realWebView evaluateJavaScript:javaScriptString completionHandler:completionHandler];
}
-(NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)javaScriptString
{
    __block NSString* result = nil;
    __block BOOL isExecuted = NO;
    [(WKWebView*)self.realWebView evaluateJavaScript:javaScriptString completionHandler:^(id obj, NSError *error) {
        result = obj;
        isExecuted = YES;
    }];
    
    while (isExecuted == NO) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    return result;
}
-(void)setScalesPageToFit:(BOOL)scalesPageToFit
{
    if(_scalesPageToFit == scalesPageToFit)
    {
        return;
    }
    
    WKWebView* webView = _realWebView;
    
    NSString *jScript = @"var meta = document.createElement('meta'); \
    meta.name = 'viewport'; \
    meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'; \
    var head = document.getElementsByTagName('head')[0];\
    head.appendChild(meta);";
    
    if(scalesPageToFit)
    {
        WKUserScript *wkUScript = [[NSClassFromString(@"WKUserScript") alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
        [webView.configuration.userContentController addUserScript:wkUScript];
    }
    else
    {
        NSMutableArray* array = [NSMutableArray arrayWithArray:webView.configuration.userContentController.userScripts];
        for (WKUserScript *wkUScript in array)
        {
            if([wkUScript.source isEqual:jScript])
            {
                [array removeObject:wkUScript];
                break;
            }
        }
        for (WKUserScript *wkUScript in array)
        {
            [webView.configuration.userContentController addUserScript:wkUScript];
        }
    }
	
    _scalesPageToFit = scalesPageToFit;
}

-(BOOL)scalesPageToFit
{
    return _scalesPageToFit;
}

-(NSInteger)countOfHistory
{
    WKWebView* webView = self.realWebView;
    return webView.backForwardList.backList.count;
}
-(void)gobackWithStep:(NSInteger)step
{
    if(self.canGoBack == NO)
        return;
    
    if(step > 0)
    {
        NSInteger historyCount = self.countOfHistory;
        if(step >= historyCount)
        {
            step = historyCount - 1;
        }
        WKWebView* webView = self.realWebView;
        WKBackForwardListItem* backItem = webView.backForwardList.backList[step];
        [webView goToBackForwardListItem:backItem];
    }
    else
    {
        [self goBack];
    }
}

- (void)callHandler:(NSString *)functionName data:(NSString *_Nullable)dataStr completionHandler:(nonnull void (^)(id _Nonnull))completionHandler {
    [_bridge callHandler:functionName data:dataStr responseCallback:^(id responseData) {
        if (completionHandler) completionHandler(responseData);
    }];
}

#pragma mark-  如果没有找到方法 去realWebView 中调用
-(BOOL)respondsToSelector:(SEL)aSelector
{
    BOOL hasResponds = [super respondsToSelector:aSelector];
    if(hasResponds == NO)
    {
        hasResponds = [self.delegate respondsToSelector:aSelector];
    }
    if(hasResponds == NO)
    {
        hasResponds = [self.realWebView respondsToSelector:aSelector];
    }
    return hasResponds;
}
- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature* methodSign = [super methodSignatureForSelector:selector];
    if(methodSign == nil)
    {
        if([self.realWebView respondsToSelector:selector])
        {
            methodSign = [self.realWebView methodSignatureForSelector:selector];
        }
        else
        {
            methodSign = [(id)self.delegate methodSignatureForSelector:selector];
        }
    }
    return methodSign;
}
- (void)forwardInvocation:(NSInvocation*)invocation
{
    if([self.realWebView respondsToSelector:invocation.selector])
    {
        [invocation invokeWithTarget:self.realWebView];
    }
    else
    {
        [invocation invokeWithTarget:self.delegate];
    }
}

#pragma mark- 清理
-(void)dealloc
{
    WKWebView* webView = _realWebView;
    webView.UIDelegate = nil;
    webView.navigationDelegate = nil;
    
    [webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [webView removeObserver:self forKeyPath:@"title"];
    [webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
    
    [_realWebView scrollView].delegate = nil;
    [_realWebView stopLoading];
    [(WKWebView*)_realWebView loadHTMLString:@"" baseURL:nil];
    [_realWebView stopLoading];
    [_realWebView removeFromSuperview];
    _realWebView = nil;
}
@end
