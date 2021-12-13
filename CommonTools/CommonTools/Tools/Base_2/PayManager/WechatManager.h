//
//  WechatManager.h
//  HM503
//
//  Created by 美术传媒 on 2018/11/8.
//  Copyright © 2018 lcy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WXApi.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WechatManagerDelagate <NSObject>

@required
-(void)wechatPaySuccessful;
-(void)wechatPayFail;

@end

@interface WechatManager : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (id)yy_modelInitWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@property(nonatomic,weak)id<WechatManagerDelagate>delegate;
@property(nonatomic,copy)NSString*orderID;

+(instancetype)shareManager;


/// 支付保证金(认证费)
/// @param type 5 缴纳年费 6 缴纳店铺保证金 7 经纪人同时交纳年费和保证金 9艺术家认证
/// @param roleType 1经纪人，2艺术家
- (void)payIdentifyFeeWithType:(NSString*)type roleType:(NSString *)roleType;

/// 订单支付（微信支付）
/// @param type 支付类型
/// @param order_id 订单ID
- (void)payOrderWithType:(NSString*)type withOrderID:(NSString*)order_id;

/// 会客预约订单支付（微信支付）
/// @param order_id 订单ID
/// @param type  关联业务类型 1:约见预约订单
- (void)payMeetingOrderWithID:(NSString *)order_id type:(NSString *)type;

/**
 礼物赠送

 @param receiver_id 接收者ID
 @param video_id 视频ID
 @param gift_id 礼物ID
 @param gift_count 礼物数量
 */
- (void)payGiftWithReceiverID:(NSString *)receiver_id
					 videoid:(NSString *)video_id
					  giftID:(NSString*)gift_id
				   giftCount:(NSInteger)gift_count;

/**
 微信统一下单 格式{"payType":orderid_map}

 @param orderid_map 订单组
 @param payType 业务类型{1:茶会订单; 2:艺币充值订单; 3:专场服务费订单; 4:专场保证金订单; 5:商家订单}
 */
- (void)payCommonByWechatWithRelevanceMap:(NSArray *)orderid_map withPayType:(NSInteger)payType;


//查询订单状态
- (void)getStateOfOrderWithResp:(BaseResp *)resp;

/**
 发起微信分享

 @param scene 类型
 */
- (void)wxSendReqWithScene:(AMShareViewItemStyle)scene withParams:(NSDictionary *_Nullable)params;

/**
发起微信纯图片分享
*/
- (void)wxSendImageWithScene:(AMShareViewItemStyle)scene withImage:(UIImage *_Nullable)image;

@end

NS_ASSUME_NONNULL_END
