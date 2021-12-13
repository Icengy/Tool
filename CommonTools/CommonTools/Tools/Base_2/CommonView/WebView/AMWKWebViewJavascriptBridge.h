//
//  AMWKWebViewJavascriptBridge.h
//  ArtMedia2
//
//  Created by icnengy on 2020/10/26.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WKWebViewJavascriptBridge.h"

NS_ASSUME_NONNULL_BEGIN

@interface AMWKWebViewJavascriptBridge : WKWebViewJavascriptBridge

/// 微信分享
@property (nonatomic ,copy, readonly) NSString *friendShareMethod;
/// 朋友圈分享
@property (nonatomic ,copy, readonly) NSString *ranksShareMethod;
/// 图片保存
@property (nonatomic ,copy, readonly) NSString *saveImgMethod;
/// 跳转艺术家主页
@property (nonatomic ,copy, readonly) NSString *goArtistPageMethod;
/// 跳转短视频主页
@property (nonatomic ,copy, readonly) NSString *goVideoPageMethod;
/// 跳转商品主页
@property (nonatomic ,copy, readonly) NSString *goProductPageMethod;
/// 跳转艺术家认证
@property (nonatomic ,copy, readonly) NSString *goArtistAuthMethod;
/// 获取网页内容高度
@property (nonatomic ,copy, readonly) NSString *getPageHeightMethod;
/// 验证登录
@property (nonatomic ,copy, readonly) NSString *verifyLoginMethod;
/// 刷新页面
@property (nonatomic ,copy, readonly) NSString *refreshPageMethod;
/// 跳转拍场
@property (nonatomic ,copy, readonly) NSString *goAuctionFieldMethod;
/// 跳转拍品
@property (nonatomic ,copy, readonly) NSString *goAuctionGoodsMethod;

@end

NS_ASSUME_NONNULL_END
