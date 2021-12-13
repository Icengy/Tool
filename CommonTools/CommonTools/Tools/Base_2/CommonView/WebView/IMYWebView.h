//
//  IMYWebView.h
//  IMY_ViewKit
//
//  Created by ljh on 15/7/1.
//  Copyright (c) 2015年 IMY. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <WebKit/WebKit.h>

#import "IMYWebViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN
@interface IMYWebView : UIView

@property(weak,nonatomic, nullable) id<IMYWebViewDelegate> delegate;
@property(weak,nonatomic, nullable) id<IMYWebViewDataSource> dataSource;

///内部使用的webView
@property (nonatomic, readonly , nullable) id realWebView;
///预估网页加载进度
@property (nonatomic, readonly) double estimatedProgress;

@property (nonatomic, readonly , nullable) NSURLRequest *originRequest;

///back 层数
- (NSInteger)countOfHistory;
- (void)gobackWithStep:(NSInteger)step;

///---- UI 或者 WK 的API
@property (nonatomic, readonly , nullable) UIScrollView *scrollView;

- (id)loadRequest:(NSURLRequest *)request;
- (id)loadHTMLString:(NSString *)string baseURL:(NSURL *_Nullable)baseURL;

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly) NSURLRequest *currentRequest;
@property (nonatomic, readonly) NSURL *URL;

@property (nonatomic, readonly, getter=isLoading) BOOL loading;
@property (nonatomic, readonly) BOOL canGoBack;
@property (nonatomic, readonly) BOOL canGoForward;
///是否根据视图大小来缩放页面  默认为YES
@property (nonatomic) BOOL scalesPageToFit;

- (id)goBack;
- (id)goForward;
- (id)reload;
- (id)reloadFromOrigin;
- (void)stopLoading;

- (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^)(id, NSError *))completionHandler;
///不建议使用这个办法  因为会在内部等待webView 的执行结果
- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)javaScriptString ;
- (void)callHandler:(NSString *)functionName data:(NSString *_Nullable)dataStr completionHandler:(void (^)(id responseData))completionHandler;


@end

NS_ASSUME_NONNULL_END
