//
//  IMYWebViewDelegate.h
//  ArtMedia2
//
//  Created by icnengy on 2020/10/26.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IMYWebView;
NS_ASSUME_NONNULL_BEGIN

@protocol IMYWebViewDelegate <NSObject>

@optional
- (void)webViewDidStartLoad:(IMYWebView *_Nullable)webView;
- (void)webViewDidFinishLoad:(IMYWebView *_Nullable)webView;
- (void)webView:(IMYWebView *_Nullable)webView didFailLoadWithError:(NSError *_Nullable)error;
- (BOOL)webView:(IMYWebView *_Nullable)webView shouldStartLoadWithRequest:(NSURLRequest *_Nullable)request navigationType:(WKNavigationType)navigationType;
- (void)webViewDidFinishLoad:(IMYWebView *_Nullable)webView withContentSize:(CGSize)contentSize;

@end

@protocol IMYWebViewDataSource <NSObject>

@optional
- (void)webView:(IMYWebView *_Nullable)webView didSelectedJSForShare:(NSInteger)shareType data:(id _Nullable)data;
- (void)webView:(IMYWebView *_Nullable)webView didSelectedJSForSaveImage:(id _Nullable)imageData;
- (void)webView:(IMYWebView *_Nullable)webView didSelectedJSForLogin:(id _Nullable)sender;
- (void)webView:(IMYWebView *_Nullable)webView didSelectedJSForArtistAuth:(id _Nullable)sender;
- (void)webView:(IMYWebView *_Nullable)webView didSelectedJSForArtistPage:(id _Nullable)data;
- (void)webView:(IMYWebView *_Nullable)webView didSelectedJSForVideoPage:(id _Nullable)data;
- (void)webView:(IMYWebView *_Nullable)webView didSelectedJSForProductPage:(id _Nullable)data;
- (void)webView:(IMYWebView *_Nullable)webView didSelectedGetPageHeightMethod:(id _Nullable)data;

- (void)webView:(IMYWebView *_Nullable)webView didSelectedJSForAuctionFieldPage:(id _Nullable)data;
- (void)webView:(IMYWebView *_Nullable)webView didSelectedJSForAuctionGoodsPage:(id _Nullable)data;

@end

NS_ASSUME_NONNULL_END
