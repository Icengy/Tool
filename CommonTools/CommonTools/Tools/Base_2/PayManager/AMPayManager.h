//
//  AMPayManager.h
//  ArtMedia2
//
//  Created by icnengy on 2020/11/23.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WechatManager.h"
#import "AlipayManager.h"
#import "AppleManager.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AMPayManagerDelagate <NSObject>

@optional

/// 返回支付宝支付结果
/// @param isSuccess YES：支付成功 NO：支付失败/取消
- (void)getAlipayPayResult:(BOOL)isSuccess;

/// 返回微信支付结果
/// @param isSuccess YES：支付成功 NO：支付失败/取消
- (void)getWXPayResult:(BOOL)isSuccess;

/// 返回线下支付结果
/// @param offlineTradeNo 商务订单号
- (void)getOfflinePayResult:(BOOL)isSuccess offlineTradeNo:(NSString * _Nullable)offlineTradeNo;

/// 返回苹果支付结果
/// @param applePayTradeNo 商务订单号
/// @param applePayAmount 支付金额
- (void)getApplePayResult:(NSString * _Nullable)applePayTradeNo withAmount:(NSString *_Nullable)applePayAmount;

@end

@interface AMPayManager : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (id)yy_modelInitWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

+ (instancetype)shareManager;

/**
 统一下单 格式{"payType":orderid_map}

 @param orderid_map 订单组
 @param payType 业务类型{1:茶会订单; 2:艺币充值订单; 3:专场服务费订单; 4:专场保证金订单; 5:商家订单}
 @param payChannel #交易渠道 1:支付宝;2:微信;3:apple pay;4:线下支付
 @param delegate 支付回调代理
 */
- (void)payCommonWithRelevanceMap:(NSArray *)orderid_map withPayType:(NSInteger)payType byChannel:(NSInteger)payChannel delegate:(id <AMPayManagerDelagate>)delegate;

/// 支付保证金(认证费)
/// @param type 5 缴纳年费 6 缴纳店铺保证金 7 经纪人同时交纳年费和保证金 9艺术家认证
/// @param roleType 1经纪人，2艺术家
/// @param payChannel #交易渠道 1:支付宝;2:微信;3:apple pay;4:线下支付
/// @param delegate 支付回调代理
- (void)payIdentifyFeeWithType:(NSString*)type roleType:(NSString *)roleType byChannel:(NSInteger)payChannel delegate:(id <AMPayManagerDelagate>)delegate;

/// 商品支付
/// @param type 支付类型
/// @param order_id 订单ID
/// @param payChannel #交易渠道 1:支付宝;2:微信;3:apple pay;4:线下支付
/// @param delegate 支付回调代理
- (void)payOrderWithType:(NSString*)type withOrderID:(NSString*)order_id byChannel:(NSInteger)payChannel delegate:(id <AMPayManagerDelagate>)delegate;

/// 会客预约订单支付
/// @param order_id 订单ID
/// @param type  关联业务类型 1:约见预约订单
/// @param payChannel #交易渠道 1:支付宝;2:微信;3:apple pay;4:线下支付
/// @param delegate 支付回调代理
- (void)payMeetingOrderWithID:(NSString *)order_id type:(NSString *)type byChannel:(NSInteger)payChannel delegate:(id <AMPayManagerDelagate>)delegate;

/// 礼物赠送
/// @param receiver_id 接收者ID
/// @param video_id 视频ID
/// @param gift_id 礼物ID
/// @param gift_count 礼物数量
/// @param payChannel #交易渠道 1:支付宝;2:微信;3:apple pay;4:线下支付
/// @param delegate 支付回调代理
- (void)payGiftWithReceiverID:(NSString *)receiver_id
                     videoid:(NSString *)video_id
                      giftID:(NSString*)gift_id
                    giftCount:(NSInteger)gift_count
                    byChannel:(NSInteger)payChannel delegate:(id <AMPayManagerDelagate>)delegate;

@end

NS_ASSUME_NONNULL_END
