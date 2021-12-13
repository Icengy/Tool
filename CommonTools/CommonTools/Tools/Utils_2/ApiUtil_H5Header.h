//
//  ApiUtil_H5Header.h
//  ArtMedia2
//
//  Created by icnengy on 2020/10/26.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ApiUtil_H5Header : NSObject

/// 邀请好友
+ (NSString *)h5_inviteFriends;

/// 帮助中心
/// @param flag 1 个人中心、0 艺术之家
+ (NSString *)h5_helpCenter:(NSInteger)flag;

/// 认证艺术家
+ (NSString *)h5_identityPost;

/// 邀新
+ (NSString *)h5_inviteNew;

/// 邀新排行
+ (NSString *)h5_inviteNewList;

/// 权属证书说明页
+ (NSString *)h5_ownerTips;

/// 艺币说明
+ (NSString *)h5_YBSM;


/// 艺术融媒体充值服务协议
+ (NSString *)h5_YSRMTCZFWXY;


/// 公众号注册页面
/// @param invitation_code 邀请码
+ (NSString *)h5_registerWith:(NSString *)invitation_code;

/// 公众号认证页面
/// @param invitation_code 邀请码
+ (NSString *)h5_identifConf:(NSString *)invitation_code;

/// 扫码进入商品详情
/// @param gid 商品ID
+ (NSString *)h5_goodDetail:(NSString *)gid;

/// 扫码进权属证书
/// @param gid 商品ID
+ (NSString *)h5_getCerdetail:(NSString *)gid;

/// 扫码进权属证书
/// @param articleid 协议ID
+ (NSString *)h5_agreement:(NSString *)articleid;

/// 访问用户更多信息
/// @param uid 用户ID
+ (NSString *)h5_showMoreInfo:(NSString *)uid;

/// 用户协议
+ (NSString *)h5_userInfoPre;
/// 拍品详情
/// @param auctionGoodId 拍品id
+ (NSString *)h5_auctionGoodDetail:(NSString *)auctionGoodId;

/// 拍品分享链接
/// @param auctionGoodId 拍品ID
+ (NSString *)h5_shareForAuctionItems:(NSString *)auctionGoodId;

/// 专场分享链接
/// @param auctionFieldId 专场
+ (NSString *)h5_shareForspecOccas:(NSString *)auctionFieldId;

@end

NS_ASSUME_NONNULL_END
