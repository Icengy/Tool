//
//  AlipayManager.h
//  ArtMedia2
//
//  Created by icnengy on 2020/2/25.
//  Copyright © 2020 lcy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlipayManager : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (id)yy_modelInitWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

+(instancetype)shareManager;

/// 商品支付
/// @param type 支付类型
/// @param roleType 订单ID
- (void)payIdentifyFeeWithType:(NSString *)type roleType:(NSString *)roleType;

/// 商品支付
/// @param type 支付类型
/// @param order_id 订单ID
- (void)payOrderWithType:(NSString*)type withOrderID:(NSString*)order_id;

/// 礼物支付（支付宝）
/// @param receiver_id 接受者ID
/// @param video_id 视频ID
/// @param gift_id 礼物ID
/// @param gift_count 礼物数量
- (void)payGiftWithReceiverID:(NSString *)receiver_id
                      videoid:(NSString *)video_id
                       giftID:(NSString*)gift_id
                    giftCount:(NSInteger)gift_count;

/// 会客预约订单支付（支付宝支付）
/// @param order_id 订单ID
/// @param type 关联业务类型 1:约见预约订单
- (void)payMeetingOrderWithID:(NSString *)order_id type:(NSString *)type;

/**
 支付宝统一下单 格式{"payType":orderid_map}

 @param orderid_map 订单组
 @param payType 业务类型{1:茶会订单; 2:艺币充值订单; 3:专场服务费订单; 4:专场保证金订单; 5:商家订单}
 */
- (void)payCommonByAlipayWithRelevanceMap:(NSArray *)orderid_map withPayType:(NSInteger)payType;

@end

NS_ASSUME_NONNULL_END
