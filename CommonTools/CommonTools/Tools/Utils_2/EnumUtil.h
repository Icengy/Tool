//
//  EnumUtil.h
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/11/4.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EnumUtil : NSObject

/**
 搜索结果列表枚举 SearchResultViewController
 */
typedef NS_ENUM(NSUInteger, MessageDetailListStyle) {
    /// 点赞列表
    MessageDetailListStyleCollect = 0,
    /// 评论列表
    MessageDetailListStyleDiscuss,
    /// 回复列表
    MessageDetailListStyleReply
};

/**
 搜索结果列表枚举 SearchResultViewController

 - SearchResultTypeForVideo: 作品
 - SearchResultTypeForCustom: 用户
 */
typedef NS_ENUM(NSUInteger, SearchResultType) {
	SearchResultTypeForVideo = 0,
	SearchResultTypeForCustom
};

/**
 首页列表枚举 HomeNormalViewController

 - HomeListTypeRecommend: 推荐列表
 - HomeListTypeFollow: 关注列表
 */
//typedef NS_ENUM(NSUInteger, HomeListType) {
//	HomeListTypeRecommend = 0,      // 推荐列表
//	HomeListTypeFollow    // 关注列表
//};

/**
 个人/他人中心视频列表枚举
 
 * 1、他人视频/他人喜欢/我的收藏 （同样式列表）
 * 2、我的视频（可编辑）
 * 3、我的草稿（显示编辑时间）
 
 - PersonalControllerListTypeOtherVideo: 他人视频
 - PersonalControllerListTypeOtherLike: 他人喜欢
 - PersonalControllerListTypeMineVideo: 我的视频
 - PersonalControllerListTypeMineCollection: 我的收藏
 - PersonalControllerListTypeMineDraft: 我的草稿
 */
typedef NS_ENUM(NSUInteger, PersonalControllerListType) {
    ///他人视频
	PersonalControllerListTypeOtherVideo = 0,
    ///他人喜欢
	PersonalControllerListTypeOtherLike,
    ///我的视频
	PersonalControllerListTypeMineVideo,
    ///我的收藏
	PersonalControllerListTypeMineCollection,
    ///我的草稿
	PersonalControllerListTypeMineDraft,
    /// 短视频(艺术家)
    PersonalControllerListTypeArtCreate,
    ///作品集 (带商品的<他人视频>)
    PersonalControllerListTypeArtGallery
};


#pragma mark -
/**
 订单方式枚举

 - MyOrderWayTypeBuyed: 我买到的订单
 - MyOrderWayTypeSalled: 我卖出的订单
 */
typedef NS_ENUM(NSUInteger, MyOrderWayType) {
	///买到的订单
	MyOrderWayTypeBuyed = 0,
	///卖出的订单
	MyOrderWayTypeSalled
};

/**
 * 订单状态
 * 生成订单=0，已付款=1，已发货=2，订单完成=3，退货中=4，退货完成=5，已退款=6，已提现=7，关闭订单=8

  - MyOrderTypeWeiFuKuan:待付款
  - MyOrderTypeYiFuKuan:已付款
  - MyOrderTypeQueRenShouHuo:已发货
  - MyOrderTypeSuccess:待收货
  - MyOrderTypeTuiHuoZhong:退货中
  - MyOrderTypeTuiHuoWanCheng:退货完成
  - MyOrderTypeYiTuiKuan:退款完成
  - MyOrderTypeYiTiXian:已提现
  - MyOrderTypeCancel:订单取消
 */
typedef NS_ENUM(NSUInteger, MyOrderType) {
	///全部 -1
	MyOrderTypeAll = 0,
    
	///生成订单0 --> 待付款/等待买家付款
	MyOrderTypeDaiFuKuan,
    
	///已付款1 --> 待发货/未发货
	MyOrderTypeYiFuKuan,
    
	///已发货2 --> 确认收货/等待买家收货
	MyOrderTypeQueRenShouHuo,
    
	///确认收货3 --> 交易成功/交易成功
	MyOrderTypeSuccess,
    
	///退货中4 --> 退货中/退货中
	MyOrderTypeTuiHuoZhong,
    
	///退货完成5 --> 退款中/退货完成
	MyOrderTypeTuiHuoWanCheng,
    
	///已退款6 --> 已退款/已退款
	MyOrderTypeYiTuiKuan,
    
	///已提现7 --> 已提现/已提现
	MyOrderTypeYiTiXian,
    
	///订单关闭8 --> 订单关闭/订单关闭
	MyOrderTypeCancel
};

#pragma mark - 分享
typedef NS_ENUM(NSUInteger, AMAuctionOrderStyle) {
    /// 全部订单
    AMAuctionOrderStyleAll = 0,
    /// 待支付
    AMAuctionOrderStyleToBePaid,
    /// 待发货
    AMAuctionOrderStyleToBeDelivered,
    /// 已发货
    AMAuctionOrderStyleDelivered,
    /// 已收货
    AMAuctionOrderStyleReceived,
    /// 交易成功
    AMAuctionOrderStyleSuccess,
    /// 交易关闭
    AMAuctionOrderStyleClose
};

#pragma mark - 弹出框
typedef NS_ENUM(NSUInteger, AMImageSelectedMeidaType) {
    ///拍照
    AMImageSelectedMeidaTypeCamera = 0,
    ///照片
    AMImageSelectedMeidaTypePhoto
};

#pragma mark - 钱包
typedef NS_ENUM(NSUInteger, AMWalletItemStyle) {
    ///余额
    AMWalletItemStyleBalance = 0,
    ///收入
    AMWalletItemStyleRevenue,
    ///艺币
    AMWalletItemStyleYiB,
    ///积分
    AMWalletItemStyleIntegral,
    
    
    /// 预估销售
    AMWalletItemStyleEstimateSale,
    /// 预估收益
    AMWalletItemStyleEstimateProfit
};

typedef NS_ENUM(NSUInteger, AMWalletItemDetailStyle) {
    AMWalletItemDetailStyleNone,
    
    ///艺币-全部
    AMWalletItemDetailStyleYBDefault   = 0,
    /// 艺币-充值
    AMWalletItemDetailStyleYBRecharge,
    /// 艺币-消费
    AMWalletItemDetailStyleYBConsumption,
    
    
    /// 收入-全部
    AMWalletItemDetailStyleRevenueDefault,
    /// 收入-销售
    AMWalletItemDetailStyleRevenueSale,
    /// 收入-收益
    AMWalletItemDetailStyleRevenueProfit,
    /// 收入-提现
    AMWalletItemDetailStyleRevenueCashout,
    /// 收入-会客收益
    AMWalletItemDetailStyleRevenueMeetingProfit,
    /// 收入-直播课收益
    AMWalletItemDetailStyleRevenueCourseProfit,
    
    
    /// 余额-全部
    AMWalletItemDetailStyleBalanceDefault,
    /// 余额-支出
    AMWalletItemDetailStyleBalanceExpenditure,
    /// 余额-转入
    AMWalletItemDetailStyleBalanceRollin,
    /// 余额-提现
    AMWalletItemDetailStyleBalanceCashout,
    /// 余额-退款
    AMWalletItemDetailStyleBalanceRefund,
    
    
    /// 预估销售-有效
    AMWalletItemDetailStyleEstimateSaleValid,
    /// 预估销售-无效
    AMWalletItemDetailStyleEstimateSaleInvalid,
    
    
    /// 预估收益-有效
    AMWalletItemDetailStyleEstimateProfitValid,
    /// 预估收益-无效
    AMWalletItemDetailStyleEstimateProfitInvalid
};

#pragma mark - 分享
typedef NS_ENUM(NSUInteger, AMShareViewItemStyle) {
    /// 微信好友
    AMShareViewItemStyleWX = 0,
    /// 微信朋友圈
    AMShareViewItemStyleWXFriend,
    /// 复制
    AMShareViewItemStyleCopy,
    /// 保存本地
    AMShareViewItemStyleSaveLocal,
    /// 举报
    AMShareViewItemStyleReport,
    /// 屏蔽
    AMShareViewItemStyleShield
};

#pragma mark - 支付
typedef NS_ENUM(NSUInteger, AMAwakenPayStyle) {
    /// 默认模式，RMB购买
    AMAwakenPayStyleDefalut = 0,
    /// 消费虚拟币模式
    AMAwakenPayStyleConsumption,
    /// 充值虚拟币模式
    AMAwakenPayStyleRecharge,
    /// 购买拍品模式
    AMAwakenPayStyleAuction
};

typedef NS_ENUM(NSUInteger, AMPayWay) {
    /// 默认（虚拟币消费模式）
    AMPayWayDefault = 0,
    /// 苹果支付
    AMPayWayApple,
    /// 微信支付
    AMPayWayWX,
    /// 支付宝支付
    AMPayWayAlipay,
    /// 银行卡支付
    AMPayWayBank,
    /// 线下
    AMPayWayOffline
};


/**
 视频播放格式枚举

 - MyVideoShowStyleForSingle 单个播放
 - MyVideoShowStyleForList 列表播放
 */
typedef NS_ENUM(NSUInteger, MyVideoShowStyle) {
    /// 单个视频播放
    MyVideoShowStyleForSingle = 0,
    /// 列表播放
    MyVideoShowStyleForList
};

/**
会客布局格式枚举

- TC_Float 前后堆叠模式
- TC_Gird 九宫格模式
*/
typedef NS_ENUM(NSUInteger, TCLayoutType) {
    TC_Float,   // 前后堆叠模式
    TC_Gird    // 九宫格模式
};

/**
 会客用户列表样式枚举
 */
typedef NS_ENUM(NSUInteger, AMMeetingMemberStyle) {
    /// 默认列表（不显示麦克风和摄像头）
    AMMeetingMemberStyleDefault = 0,
    /// 一般样式（显示麦克风和摄像头）
    AMMeetingMemberStyleNormal,
    /// 用户管理列表（显示麦克风和摄像头管理）
    AMMeetingMemberStyleManager
};

/**
 约见管理/记录样式枚举
 */
typedef NS_ENUM(NSUInteger, AMMeetingRecordManageStyle) {
    /// 约见记录
    AMMeetingRecordManageStyleRecord = 0,
    /// 约见管理
    AMMeetingRecordManageStyleManage
};
/**
约见管理/记录列表样式枚举
*/
typedef NS_ENUM(NSUInteger, AMMeetingRecordManageListStyle) {
    /// 默认全部
    AMMeetingRecordManageListStyleAll = 0,
    /// 待邀请
    AMMeetingRecordManageListStyleDaiYaoQing,
    /// 已邀请/待确认
    AMMeetingRecordManageListStyleYiYaoQing,
    /// 已确认
    AMMeetingRecordManageListStyleYiQueRen,
    /// 已取消
    AMMeetingRecordManageListStyleYiQuXiao
};

@end

NS_ASSUME_NONNULL_END
