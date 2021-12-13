//
//  ApiUtilHeader.h
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/10/29.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ApiUtil_H5Header.h"
NS_ASSUME_NONNULL_BEGIN

@interface ApiUtilHeader : NSObject
+ (NSString *)selectImConf;
+ (NSString *)get_app_application;

/**
 * 获取验证码
 * {"type":"1","mobile":"18758129692"}
 * type短信类型，1注册 2找回密码 3登录验证码 4绑定手机号 5解绑手机号 6通用
 * type = 1废弃
 
 @return URLString
 */
+ (NSString *)getVerificationCode;

/**
 * 验证验证码
 * {"type":"1","mobile":"18758129692","code":"3888"}
 * type短信类型，1注册 2找回密码 3登录验证码 4绑定手机号 5解绑手机号 6通用
 
 @return URLString
 */
+ (NSString *)verifyCode;

/**
 * 验证码登录/注册
 * {"type":"3","mobile":"18758129692","code":"4566"}
 * type短信类型，1注册 2找回密码 3登录验证码 4绑定手机号 5解绑手机号 6通用。
 * type = 1废弃
 * 如果该手机号已注册，则直接登录。如果未注册，则自动注册并返回用户信息。
 
 @return URLString
 */
+ (NSString *)smsLoginOrRegister;

/**
  * 账号登录
  * {"account":"18758129692","password":"123456"}
  account为登录账号，可以是昵称，也可以是手机号。如果是短信验证登录或微信登陆，未设置过密码，自动登录时，密码用6个0。如果设置过密码，可以用登录成功后返回的md5加密过的密码在自动登录是请求登录。
 
 @return URLString
 */
+ (NSString *)accountLoginOrRegister;

/**
 * 微信注册

 @return URLString
 */
+ (NSString *)registerWithWechat;


/**
 微信绑定

 @return URLString
 */
+ (NSString *)bindWithWechat;

/**
 * 第三方登录
 * {"openid":"oSPWT0ox-RTsliBscqp4yRLD_NF4"}

 @return URLString
 */
+ (NSString *)thirdLogin;

/**
 * 首次设置密码
 * {"uid":160,"password":"123456"}
 
 @return URLString
 */
+ (NSString *)firstSetPassword;

/**
 * 修改密码

 @return URLString
 */
+ (NSString *)changePassword;

/**
 * 找回密码
 * {"mobile":"18758129692","newpass":"123456789"}
 
 @return URLString
 */
+ (NSString *)resetPassword;

/**
 只绑定微信
 {"id":"","openid":"","wechatid":""}

 @return URLString
 */
+ (NSString *)b_wechat;

#pragma mark -  地址相关
/**
 * 获取用户当前地址列表 @"/User/get_user_address_list"
 * {"uid":"170"}
 
 @return URLString
 */
+ (NSString *)getUserAddressList;


/**
  * 修改用户地址信息
  * {"type":"1","address":{"id":"1","uid":"160","reciver":"秦翔","phone":"18758129692","addrregion":"浙江省杭州市下城区","address":"西湖铭楼401","is_default":"1"}}
  * type为操作类型，1：新增地址，2：编辑地址，3删除地址，4：设为默认地址。type为1时，address集合里不要传id。type为其它值时，address集合里必须传id。
  * is_default为是否设为默认：0否，1是。

 @return URLString
 */
+ (NSString *)editUserAddress;

/**
 * 获取用户默认地址
 * {"uid":"160"}

@return URLString
*/
+ (NSString *)getUserDefaultAddress;

#pragma mark - 个人/他人中心相关
/**
 * 获取个人中心数据
 * {"uid":"168"}
 
 @return URLString
 */
+ (NSString *)getUserInfo;

/**
* 获取艺术之家数据
* {"uid":"168"}

@return URLString
*/
+ (NSString *)getArtistUserInfo;

/**
 * 获取其他用户中心数据
 * {"artuid":"100","uid":"99"}
 
 @return URLString
 */
+ (NSString *)getOtherUserInfo;

/**
 * 编辑个人资料
 * {"uid":"160","uname":"翔子123"}单个参数.
 
 @return URLString
 */
+ (NSString *)editUserInfo;

/**
* 上传图片
*  表单形式提交，外加两个参数num:1上传原图，2上传原图并生成缩略图；
*  type:1:用户头像，2：店铺背景，3：拍品图片，4：商品图片，5：其他。
 @return URLString
 */
+ (NSString *)uploadImage;

+ (NSString *)JAVA_UploadImage;


/**
 获取当前用户的关注列表

 @return URLString
 */
+ (NSString *)getCollectUserList;

/**
 获取当前用户的粉丝列表

 @return URLString
 */
+ (NSString *)getFansList;

/**
* 获取收到的赞列表
* {"uid":"355735" ,page:0}

@return URLString
*/
+ (NSString *)getUserObjectLikedList;

/**
 获取用户关注数量和粉丝数量
 {"uid":"221"}

 @return URLString
 */
+ (NSString *)getCollFansCount;

/**
 * 获取当前用户的消息列表
 * {"uid":"241","type":"1","page":"0"}
 
 @return URLString
 */
+ (NSString *)getMessageList;

/**
 * 获取消息详情
 * {"messageid":"355735"}

 @return URLString
 */
+ (NSString *)getMessageDetail;

/**
 * 全部消息已读
 * {"uid":"241"}
 
 @return URLString
 */
+ (NSString *)setAllmessageRead;

/// 消息已读  消息类型：1系统消息 2:会客消息 3:交易通知
+ (NSString *)updateMessageStatus;
/**
清空用户未读点赞数量
{"uid":"221"}

@return URLString
*/
+ (NSString *)clearUnreadFabulous;

/**
删除单条系统消息
{"uid":"221"，msgid":"355827"}

@return URLString
*/
+ (NSString *)deleteSystemMsg;

/**
实名认证
{"cardid":"5555555555555555555" ,"uname":"袁磊", "mobile":"15972089367", "uid":"760" }

@return URLString
*/
+ (NSString *)checkIDcard;

/**
获取认证表单信息
{ "uid":"760" }

@return URLString
*/
+ (NSString *)getUserIdentInfo;

/**
获取用户实名信息
{ "uid":"760" }

@return URLString
*/
+ (NSString *)get_user_id;

/**
获取用户关注信息
{ "artist_id":"846","user_id":"765" }

@return URLString
*/
+ (NSString *)get_artist_base_info;

#pragma mark - 获取个人/他人中心视频列表相关
/**
 * 获取个人主页视频列表 PersonalControllerListTypeMineVideo类型
 * {“uid”:"99","examineState":"0","isIncludeAuction":"","page":"0"}

 @return URLString
 */
+ (NSString *)getIndexMineVideoList;

/**
 * 获取个人主页收藏列表 PersonalControllerListTypeMineCollection类型
 * {“uid”:"100","page":"0"}
 
 @return URLString
 */
+ (NSString *)getIndexMineCollectionList;

/**
 * 获取个人主页草稿列表 PersonalControllerListTypeMineDraft类型
 * {“uid”:"100","page":"0"}
 
 @return URLString
 */
+ (NSString *)getIndexMineDraftList;

/**
 * 获取他人主页视频列表 PersonalControllerListTypeOtherVideo类型
 * {“uid”:"100","page":"0"}
 
 @return URLString
 */
+ (NSString *)getIndexOtherVideoList;

/**
 * 获取他人主页喜欢列表 PersonalControllerListTypeOtherLike类型
 * {“uid”:"100","page":"0"}
 
 @return URLString
 */
+ (NSString *)getIndexOtherLikeList;

#pragma mark - 短视频相关

/**
 * 获取短视频上传时的验证签名

 @return URLString
 */
+ (NSString *)getUploadSignature;

/**
 * 发布/保存视频，无修改，不带商品
 * "uid":"181",
 * "video_data":{ "id":"15",
                        "video_url":"video_urlstr",
                         "image_url":"image_urlstr",
                         "video_file_id":"1111",
                         "video_length":"12分钟",
                         "video_des":"123123接口上传测试1111",
                         "video_state":"0" }

 @return URLString
 */
+ (NSString *)postVideoWithoutGoodsWithoutModeify;

/**
 * 发布/保存视频，有修改，不带商品
 * "uid":"181",
 * "video_data":{ "id":"15",
					    "video_url":"video_urlstr",
 					    "image_url":"image_urlstr",
 					    "video_file_id":"1111",
 					    "video_length":"12分钟",
 					    "video_des":"123123接口上传测试1111",
 					    "video_state":"0" }
 
 @return URLString
 */
+ (NSString *)postVideoWithoutGoodsWithModeify;

/**
 * 发布视频，无修改，带商品
 * "uid": "181",
 * "video_data": { "video_url": "video_urlstr",
						"image_url": "image_urlstr",
						 "video_file_id": "1111",
						 "video_length": "12分钟",
						 "video_des": "接口上传测试",
						 "video_state": "0",
						 "goodsdata": { "gname": "测试发布商品111",
											 "gdescribe": "这里是新建库存拍品并发布商品的描述信息。",
											  "gprice": "100",
 											  "gfreeshipping": "0",
											  "auctionpic": ["/Upload/auction/20181011/5bbebf3db6e1e.jpg",
											                      "/Upload/auction/20181011/5bbefa431c036.jpg"] } } }
 
 @return URLString
 */
+ (NSString *)publishVideoWithGoodsWithoutModeify;

/**
 * 保存视频，无修改，带商品
 * { "uid": "181",
 * "video_data": { "video_url": "video_urlstr",
					    "image_url": "image_urlstr",
					     "video_file_id": "1111",
					     "video_length": "12分钟",
 					    "video_des": "接口上传测试",
 					    "video_state": "0",
 					    "stock_data": { "aname": "测试发布商品111",
											 "description": "这里是新建库存拍品并发布商品的描述信息。",
 											 "price": "100",
											 "freeshipping": "0",
 											 "auctionpic": ["/Upload/auction/20181011/5bbebf3db6e1e.jpg",
																"/Upload/auction/20181011/5bbefa431c036.jpg"] } } }
 
 @return URLString
 */
+ (NSString *)saveVideoWithGoodsWithoutModeify;

/**
 * 保存视频，有修改，带商品
 * { "uid": "181",
     "video_data": { "id": "15",
						  "video_url": "video_urlstr",
 						  "image_url": "image_urlstr",
 						  "video_file_id": "1111123123",
 						  "video_length": "12分钟",
 						  "video_des": "333333接口上传测试",
 						  "video_state": "0",
 						  "stock_data": { "aname": "测试发布商品111",
											   "description": "这里是新建库存拍品并发布商品的描述信息。",
 											   "price": "100",
 											   "freeshipping": "0",
 											   "auctionpic": ["/Upload/auction/20181011/5bbebf3db6e1e.jpg",
 											                      "/Upload/auction/20181011/5bbefa431c036.jpg"] } } }
 
 @return URLString
 */
+ (NSString *)saveVideoWithGoodsWithModeify;

/**
 * 发布视频，有修改，带商品
 * { "uid": "181",
      "video_data": { "id": "15",
						   "video_url": "video_urlstr",
 						   "image_url": "image_urlstr",
 						   "video_file_id": "1111",
 						   "video_length": "12分钟",
 						   "video_des": "333333接口上传测试",
 						   "video_state": "0",
 						   "goodsdata": { "gname": "测试发布商品111",
											   "gdescribe": "这里是新建库存拍品并发布商品的描述信息。",
 											   "gprice": "100",
  											   "gfreeshipping": "0",
 											   "auctionpic": ["/Upload/auction/20181011/5bbebf3db6e1e.jpg",
 											                      "/Upload/auction/20181011/5bbefa431c036.jpg"] } } }
 
 @return URLString
 */
+ (NSString *)publishVideoWithGoodsWithModeify;

/**
* 编辑短视频
* {“uid”:"100","video_id":"100","image_url":"", "video_des":""}

@return URLString
*/
+ (NSString *)editVideoInfo;

#pragma mark -获取视频详情
/**
 * 获取视频详情
 * {“uid”:"100","videoid":"100"

 @return URLString
 */
+ (NSString *)getVideoDetials;

/**
* 获取视频频道列表

@return URLString
*/
+ (NSString *)getVideoColumn;


#pragma mark - 搜索模块

/**
 获取热门搜索标签

 @return URLString
 */
+ (NSString *)getSearchRecord;

/**
 获取用户搜索列表

 @return URLString
 */
+ (NSString *)getUserListSearch;

/**
 获取作品搜索列表

 @return URLString
 */
+ (NSString *)getVideoListSearch;


/**
 * 删除视频
 * {“videoid”:"1"}

 @return URLString
 */
+ (NSString *)deleteVideo;

/**
 * 获取可修改的短视频详情
 * {"id":"100","uid":"200"}
 
 @return URLString
 */
+ (NSString *)getVideoDetailForUpdate;

#pragma mark -  首页相关

/**
 * 获取首页推荐视频列表
 * {"uid":"100","page":"0"}

 @return URLString
 */
+ (NSString *)getRecommendVideoList;


/**
 * 获取首页收藏视频列表
 * {"uid":"100","page":"0"}

 @return URLString
 */
+ (NSString *)getMyCollectVideoList;

/**
 * 获取首页轮播图
 * {"type":"1"}
 
 @return URLString
 */
+ (NSString *)getAds;

/**
 * 获取首页广告图
 * {"type":"1"}
 
 @return URLString
 */
+ (NSString *)get_slogan;

/**
* 获取推荐艺术家列表
* {"uid":"760"}

@return URLString
*/
+ (NSString *)getRecommendArtist;

#pragma mark - 用户操作相关 点赞/收藏视频、关注用户

/**
 * 点赞收藏
 * {"uid":"142","type":"2","objtype":"5","objid":"332"}
 * objtype 1专场/2拍品/3即时拍/4投资拍品/5短视频/6拉黑用户/7屏蔽视频
 * type 1收藏 2点赞 3拉黑 4屏蔽
 * uid 用户ID
 * objid 对象id

 @return URLString
 */
+ (NSString *)collectObject;

/**
 * 用户关注/取关
 * {"uid":"158","collect_uid":"67"}

 @return URLString
 */
+ (NSString *)collectUser;

/**
* 用户举报
* {"user_id":"777","obj_type":"1","obj_id":"101"}
 1短视频，2评论，3回复

@return URLString
*/
+ (NSString *)reportObject;

#pragma mark - 商品相关
/**
 * 获取商品详情
 * {"uid":"142","goodid":"187"} uid为查看详情的用户id，游客身份不用传uid。goodid为商品id。
 
 @return URLString
 */
+ (NSString *)getGoodsDetail;

/**
* 获取商品详情-新
* {"user_id":"142","good_id":"187"} uid为查看详情的用户id，游客身份不用传uid。goodid为商品id。

@return URLString
*/
+ (NSString *)getGoodsDetailNew;

/**
* 编辑商品信息
* {"user_id":"142","good_id":"187","good_price":"","gfreeshipping":""}

@return URLString
*/
+ (NSString *)editGoodsInfo;

/**
* 删除商品
* {"user_id":"142","good_id":"187"}

@return URLString
*/
+ (NSString *)deleteGoods;
/// 商品列表
+ (NSString *)get_goods_list_with_map;
#pragma mark - 订单相关
/**
 * 创建订单
 * {"uid":"158","good_id":"194","address_id":"883"}

 @return URLString
 */
+ (NSString *)buildGoodsOrder;

/**
 * 获取我买到的订单列表
 * {"uid":"181","type":"1","page":"0"}
 
 @return URLString
 */
+ (NSString *)getBuyOrderList;

/**
 * 获取我卖掉的订单列表
 * {"uid":"181","type":"1","page":"0"}
 
 @return URLString
 */
+ (NSString *)getSellOrderList;

/**
 * 获取我买到的订单详情
 * {"order_id":"1684","uid":"181"}
 * type 1 全部 2 待付款 3 待发货 4 待收货 5 已完成
 
 @return URLString
 */
+ (NSString *)getBuyOrderDetail;

/**
 * 获取我卖掉的订单详情
 * {"order_id":"1685","uid":"181"}
 
 @return URLString
 */
+ (NSString *)getSellOrderDetail;

/**
 * 申请退货
 * {"type":"1","order_id":"79","is_received_goods":"2","apply_reason":"申请退货的原因。"}

 @return URLString
 */
+ (NSString *)applyRefund;

/**
 * 处理退货申请
 * {"type":"2","order_id":"2176","is_agree":"2","address_id":"883","refuse_remark":"拒绝退货申请的说明"}

 @return URLString
 */
+ (NSString *)dealRefund;

/**
 * 更换订单地址
 * {"order_id":"77","address_id":"883"}
 
 @return URLString
 */
+ (NSString *)resetGoodOrderAddress;

/**
 * 确认订单-买家
 * {"type":"1","order_id":"79"}type为订单类型：1拍品订单，2商品订单。
 
 @return URLString
 */
+ (NSString *)confirmReceiptForBuyer;

/**
 * 确认订单-卖家
 * {"type":"2","order_id":"79"}type为订单类型：1拍品订单，2商品订单。
 
 @return URLString
 */
+ (NSString *)confirmReceiptForSeller;


/**
 * 订单申请提现
 * {"type":"2","order_id":"2179"}
 
 @return URLString
 */
+ (NSString *)applyOrderForOrder;

/**
 * 退货时填写物流
 * {"type":"2","order_id":"2176","delivery_id":"191","delivery_comp":"顺丰快递","delivery_no":"111222333"}

 @return URLString
 */
+ (NSString *)addDeliveryForBuyer;

/**
 * 发货时填写物流
 * {"type":"2","order_id":"2176","delivery_id":"191","delivery_comp":"顺丰快递","delivery_no":"111222333"}
 
 @return URLString
 */
+ (NSString *)addDeliveryForSeller;

/**
* 获取客服

@return URLString
*/
+ (NSString *)getCustomerTelephone;

#pragma mark - 支付相关
#pragma mark ---------- 微信支付
/**
* 发送订单(微信支付)
*
@return URLString
*/
+ (NSString *)sendOrderWithWX;

/**
* 视频打赏(微信支付)
* {"type":"","apptype":"","giveruid":"","giftid":"","num":"","videoid":"","uid":""}

@return URLString
*/
//+ (NSString *)sendOrderWithWX;

/**
* 缴纳费用(认证费/保证金)
* type 5 缴纳年费 6 缴纳店铺保证金 7 经纪人同时交纳年费和保证金 9艺术家认证 apptype 1 苹果 2 安卓 roletype 1经纪人，2艺术家 uid 用户id

@return URLString
*/
//+ (NSString *)sendOrderWithWX;
#pragma mark ---------- 支付宝支付
/**
* 发送订单(支付宝支付)
* {"uid":"176","type":"1","order_id":"386","apptype":"1"}
* type为订单类型：3商品订单。apptype为客户端类型：6苹果，7安卓。

@return URLString
*/
+ (NSString *)sendOrderWithAlipay;

/**
* 视频打赏(支付宝支付)
* {"type":"8","apptype":"","giveruid":"","giftid":"","num":"","videoid":"","uid":""}
* ttype 传8 apptype（6：ios支付宝 7：安卓支付宝） giveruid 视频上传人id giftid 当前用户id 传1 num 数量 videoid 视频id uid 视频上传人id

@return URLString
*/
//+ (NSString *)sendOrderWithAlipay;

/**
* 缴纳费用(认证费/保证金)
* type 5 缴纳年费 6 缴纳店铺保证金 7 经纪人同时交纳年费和保证金 9艺术家认证 apptype 1 苹果 2 安卓 roletype 1经纪人，2艺术家 uid 用户id

@return URLString
*/
//+ (NSString *)sendOrderWithAlipay;

#pragma mark - 统一支付
+ (NSString *)payCommon;

#pragma mark - 收款账户相关
/**
 * 获取用户收款账户列表
 * {"uid":"100"}

 @return URLString
 */
+ (NSString *)getUserBankAccountList;

/**
 * 解除用户收款账户的已绑定银行卡
 * {"uid":"100","bid":"1"}
 
 @return URLString
 */
+ (NSString *)deleteUserBankAccount;

/**
 * 绑定收款微信
 * { "openid":"", "headimg":"", "nickname":"", "uid":"" }

 @return URLString
 */
+ (NSString *)bindPayOpenid;

/**
 * 获取银行列表

 @return URLString
 */
+ (NSString *)getBanklist;

/**
 * 新增新的收款账户
 * { "uid":"", "account_type":"", "account_user_name":"", "account_number":"", "bank_name":"" }
 
 @return URLString
 */
+ (NSString *)addUserBankAccount;

#pragma mark - 认证相关
/**
 * 认证首页
 * {"uid":""}
 * 0未实名 1未提交认证资料（可以点击认证） 2申请中 3申请未通过 4申请通过，未缴费 5认证通过

 @return URLString
 */
+ (NSString *)artistIdentifyIndex;

/**
 * 获取用户上传的认证信息
 * {"uid":"158"}
 
 @return URLString
 */
+ (NSString *)getIdentInfo;

/**
 * 提交用户认证资料
 * identify_type //1经纪人，2艺术家 uid self_introduction 自我介绍 organization 艺术领域 pic 图册 organization 所属机构 arts 艺术领域

 @return URLString
 */
+ (NSString *)addUserIdentify;

/**
 * 获取核身鉴权token
 * {"IdCard":"411526199002190000","Name":"翔子"}

 @return URLString
 */
+ (NSString *)getDetectAuth;

/**
 * 生成认证申请
 * {"BizToken":"2C470CE4-9B0A-4D2C-B5B8-42AC9776CA0C","uid":"181","identify_type":"1"}
 
 @return URLString
 */
+ (NSString *)posDetectInfo;

/**
* 获取艺术家创作领域列表

@return URLString
*/
+ (NSString *)getCateTree;

#pragma mark - 协议文本相关

/**
 * 获取相关协议文本
 * {"articleid":"5"} 5注册协议 6竞拍及闪拍服务协议 7竞拍及闪拍须知 9关于我们
 
 @return URLString
 */
+ (NSString *)getSystemArticle;


#pragma mark - 打赏相关
/**
 * 获取礼物排行榜
 * {"videoid":"346"}

 @return URLString
 */
+ (NSString *)getGiftRank;

/**
 * 获取可提现金额
 * {"uid":"214"}
 
 @return URLString
 */
+ (NSString *)getApplyAmount;

/**
 * 获取我送出去的礼物
 * {"uid":"181","page":"0"}

 @return URLString
 */
+ (NSString *)getMySendOutGift;

/**
 * 获取收取的礼物
 * {"uid":"181","page":"0"}

 @return URLString
 */
+ (NSString *)getMyReceivedGift;

/**
 获取滚动消息内容

 @return URLString
 */
+ (NSString *)rollTips;

#pragma mark - 分享相关

/**
 * 获取分享相关信息
 * {"videoid":"333"}

 @return URLString
 */
+ (NSString *)getShareUrl;


#pragma mark - 版本相关
/**
 * 获取最新版本信息
 * {"type":"1"} type 1安卓 2苹果

 @return URLString
 */
+ (NSString *)getVersion;

#pragma mark - 黑名单相关
+ (NSString *)get_blacklist;

#pragma mark - 资讯相关
+ (NSString *)getInfoTypeList;

/// 获取资讯列表
/// {"type":"1","page":"0","num":"3"} type文章类型：1官方资讯 2艺术新闻 3艺术品鉴 4站内信。num为特殊模块获取前几条。
+ (NSString *)get_information_list;

/**
 * 获取资讯详情
 * {"informationid":"242"}

 @return URLString
 */
+ (NSString *)getInformationDetail;


#pragma mark - 推送相关

/**
* 获取未读消息数量
* {"uid":"242"}

@return URLString
*/
+ (NSString *)getUnreadCount;


#pragma mark - 邀新相关
/**
* 获取我成功邀请的用户列表
* {"uid":"242"， "page":"0"}

@return URLString
*/
+ (NSString *)getMyInviterList;

/**
* 获取我的邀请人
* {"uid":"242"}

@return URLString
*/
+ (NSString *)getMyInviter;

/**
* 绑定我的邀请人
* {"uid":"758","type":"0","code":"S666666","agentType":"1"}

@return URLString
*/
+ (NSString *)addMyInviter;

#pragma mark - 钱包相关
/**
* 我的收入首页
* {"uid":"242"}

@return URLString
*/
+ (NSString *)myIncomeIndex;

/**
* 我的收入子列表
* {"account_type":"",23 销售和收益，"state":"", 1销售 2收益 3提现，"uid":""}

@return URLString
*/
+ (NSString *)getBillList;

/**
* 我的收入子列表详情
* {"id":""，"uid":""}

@return URLString
*/
+ (NSString *)getIncomeDetails;

/**
* 我的余额信息
* {"flag":"",1 苹果系统 2安卓系统，"uid":""}
 * balance ：当前可以用余额  frozen_balance：当前冻结余额

@return URLString
*/
+ (NSString *)getMyWalletBalance;

/**
* 我的余额子列表
* {"flag":"",0 全部 1支出 2转入 3充值 4提现 5退款，"page":""，"uid":""}

@return URLString
*/
+ (NSString *)getMyRealyMoneyList;

/**
* 我的余额子列表详情
* {"id":""，"uid":""}

@return URLString
*/
+ (NSString *)getMyRealyMoneyDetails;

/**
* 预估销售/收益子列表
* {"orderstate":"",0预估收益 2失效收益，"state":"", 1预估销售收益 2预估收益，"uid":""}

@return URLString
*/
+ (NSString *)getSaleProfitList;

/**
* 钱包申请提现
* {"ctype":"",  //收款账户类型，"cashcount":"",//收款账户 输入收款账户的id，"uid":"", //当前用户，"draw_money":"", //提现金额，"state":""//提现类型 1销售金额提现 2收益金额提现

@return URLString
*/
+ (NSString *)applyOrderForWallet;

#pragma mark - 评论回复相关
/**
* 添加评论
* {"obj_type":"1","obj_id":"142","user_id":"777","comment":"评论内容"}
 obj_type：评论对象类型：1短视频 obj_id：评论对象id user_id：发表评论的用户id comment：评论内容

@return URLString
*/
+ (NSString *)addComment;

/**
* 获取树状评论列表
* {"obj_id":"142","page":"0"}
 obj_id：评论对象id page：0

@return URLString
*/
+ (NSString *)getTreeCommentList;

/**
* 获取回复列表
* {"obj_id":"142","page":"0"}
 obj_id：评论对象 id page：0

@return URLString
*/
+ (NSString *)getReplyBySingleComment;

/**
* 添加回复
* {"comment_id":"14","reply_type":"1","to_reply_id":"0","user_id":"777","reply_comment":"回复评论"}
 obj_id：评论对象 id page：0

@return URLString
*/
+ (NSString *)addReplyToComment;

/**
* 评论点赞
* {"user_id":"746","comment_id":"20"}

@return URLString
*/
+ (NSString *)aboutCommentLike;

/**
* 消息-评论列表
* {"user_id":"746","comment_id":"20"}

@return URLString
*/
+ (NSString *)getCommentNoticeList;

/**
* 消息-回复列表
* {"user_id":"746","comment_id":"20"}

@return URLString
*/
+ (NSString *)getReplyNoticeList;

/**
* 消息-评论/回复列表已读
* {"obj_type":"1","obj_id":"142"}
 obj_type：1设置单个视频对象下的评论消息已读，2设置单个评论对象下的回复消息已读。
 obj_type为1时，obj_id传视频对象id。obj_type为2时，obj_id传评论对象id。

@return URLString
*/
+ (NSString *)setNoticeRead;


#pragma mark - 视频编辑-音频
/**
* 获取音频分类

@return URLString
*/
+ (NSString *)getMusicCategory;

/**
* 获取音频列表

@return URLString
*/
+ (NSString *)getMusicList;

#pragma mark - 一键登录相关接口

/**
* 获取认证密钥
@return URLString
*/
+ (NSString *)mobileGetCaseSecret;

/**
* 获取本机手机号
@return URLString
*/

+ (NSString *)mobilePhoneNumber;
/**
* 一键登录用的注册和登录通用接口
@return URLString
*/

+ (NSString *)userMobileLoginOrRegister;

#pragma mark - 会客-进房
/**
 * 获取音频列表
 * {"uid":"816","timespan":"1597740031","token":"131e0c18cb743e6a734f2c98c24586d2"}
 
@return URLString
*/
+ (NSString *)enterMeetingRoom;
#pragma mark--------会客管理
/**
 * 会客管理列表
 * {"artistId":"816","infoStatus":"1:待开始 2:进行中 3:已结束 4:已取消"}
 
@return URLStrings
*/
+ (NSString *)tea_Manager;

/**
 * 邀请人员名单接口
 * {"id":"816","infoStatus":1:待开始 2:进行中 3:已结束 4:已取消}
 
@return URLStrings
*/
+ (NSString *)invitationNumberList;

/**
 * 会客记录列表
 * {"teaAboutInfoId":"816","status":"1:待邀请 2:已邀请/待参见 3:已参加  4:已取消'"}
 
@return URLStrings
*/
+ (NSString *)tea_Record;

/**
 * 约见记录列表
 * {"teaAboutInfoId":"816","orderStatus":"1:待邀请 2:已邀请/待参见 3:已参加  4:已取消","page":""}
 
@return URLStrings
*/
+ (NSString *)appoint_recordUrl;

/**
 * 约见详情
 * {"teaAboutInfoId":"816","orderStatus":"1:待邀请 2:已邀请/待参见 3:已参加  4:已取消","page":""}
 
@return URLStrings
*/
+ (NSString *)tea_meetingDetail:(NSString *)teaAboutOrderId;

/// 取消约见
/// @param teaAboutOrderId 约见订单ID
+ (NSString *)teaOrderCancel:(NSString *)teaAboutOrderId;
/**
 * 约见延期
 * {"teaAboutOrderId":"816"}
 
@return URLStrings
*/
+ (NSString *)appoint_endTime_Delay;

/**
 * 约见订单状态修改(确认参加、暂不参加)
 * {"teaAboutOrderId":"816", 'orderStatus':'1:待邀请 2:已邀请/待参见 3:已参加  4:已取消"','peopleInviteStatus':1:已参加 2:不参加 3:待确认"}
 
@return URLStrings
*/
+ (NSString *)appointment_statusChange;

/**
 * 获取约见信息
 * {artistId，memberId}
 
@return URLString
*/
+ (NSString *)getArtTeaStatus;

/**
 * 获取约见设置
 * {artistId，memberId}
 
@return URLString
*/
+ (NSString *)getArtTeaStting:(NSString *)artistId;


/**
* 获取约见保证金列表
 
@return URLString
*/
+ (NSString *)getTeaBondList;

/**
 * 下单页面获取用户信息+保证金
 * {"artistId":"746"}
@return URLString
*/
+ (NSString *)getArtInfoBeforeCreatOrder;

/**
 * 会客下单
 * {"artistId":"746","memberId":"", "securityDeposit":""}
 
@return URLString
*/
+ (NSString *)addTeaOrder;

/**
 * 会客支付
 * {"relevanceId":"订单id", @"relevanceType":"1:约见预约订单 ", @"tradingChannel":"交易渠道 1:支付宝 2:微信", wxCode, userId}
@return URLString
*/
+ (NSString *)payTeaOrder;

/**
 * 获取会客须知
@return URLString
*/
+ (NSString *)getOrderInfoText;

/**
 * 修改会客设置
@return URLString
*/
+ (NSString *)changeTeaSystemStatus;

/**
 * 查询预约用户列表（用于新建会客）
 * {"artistId":""}
@return URLString
*/
+ (NSString *)selectMakePleaseList;

/**
 * 查询预约用户列表 (用于会客继续邀请)
 * {"artistId":"", "teaAboutInfoId":""}
@return URLString
*/
+ (NSString *)selectMakeByPage;

/**
 * 继续邀请
 * {"teaAboutInfoId":"", orderIds:[]}
@return URLString
*/
+ (NSString *)addTwoSubmit;

/**
 * 判断新建会客弹框接口
 * {"artistId":""}
 
@return URLString
*/
+ (NSString *)canNewTea;

/**
* 新建会客
 * {"artistId":""，teaStartTime:'开始时间',teaSignUpEndTime:'截止时间', teaDesc:'会客说明', orderIds:'选中预约人员uid数组'，peopleMax:'最大人数'，peopleMin:'最小人数'}
@return URLString
*/
+ (NSString *)addteaAbout;

/**
* 获取会客详情
 * {"teaAboutInfoId":""}
@return URLString
*/
+ (NSString *)getMeetingDetail;

/**
* 获取会客参会人员列表
 * {"teaAboutInfoId":""}
@return URLString
*/
+ (NSString *)getTeaInviteList;

/**
* 获取约见记录列表
 * {"id":"","orderStatus":"", "page":""}
@return URLString
*/
+ (NSString *)getMeetingOrderRecordList;


/**
* 获取约见管理总量
 * {"artistId":""}
@return URLString
*/
+ (NSString *)getMeetingOrderManageListStatusCountByGroup;

/**
* 获取约见管理列表
 * {"artistId":"","status":"", "page":""}
@return URLString
*/
+ (NSString *)getMeetingOrderManageList;

/**
 * 获取邀请名单统计信息
 * {"teaAboutInfoId":""}
@return URLString
*/
+ (NSString *)getMeetingInveteInfo;

/**
 * 确认参加/暂不参加
 * {"teaAboutInfoId":""}
@return URLString
*/
+ (NSString *)updateOrderStatus;

/**
 * 进房时间统计
 * {"teaAboutInfoId":"","userId":"", "inOut":""}
@return URLString
*/
+ (NSString *)postRoomStatistics;

/**
 * 获取房间人员列表信息
 * {"teaAboutInfoId":"","operatedUser":"","operationId":"","beOperatedUser":"","operatedType":""}
 * 操作类型。1:禁言，2:不禁言，3:禁视频，4:不禁视频
@return URLString
*/
+ (NSString *)getRoomMemberList;

/**
 * 更新房间人员状态信息
 * {"operationId":"","teaAboutInfoId":"","operatedUser":"","beOperatedUser":"","operatedType":""}
 
@return URLString
*/
+ (NSString *)uploadRoomMemberStatus;

/**
 * 编辑会客信息说明
 * {"teaAboutInfoId":"","teaDesc":""}
 
@return URLString
*/
+ (NSString *)updateMeetingExplain;

/**
 * 取消会客
 * {"teaAboutInfoId":"","cancelReason":"", "infoStatus":""}
 
@return URLString
*/
+ (NSString *)cancelMeetingParty;

/// 会客操作记录
+ (NSString *)selectInfoLogByArtId;

/// 会客成功统计
+ (NSString *)selectArtInfoCountByInfoStatus;

#pragma mark - 权属证书
/**
 * 未实名列表
 * {"user_id":""}
 
@return URLString
*/
+ (NSString *)selectWaitAuthGoodsList;

/// 权属证书列表
+ (NSString *)certificateQueryList;

#pragma mark - 消息

/// 查询消息通知列表
+ (NSString *)selectNewsList;

/// 查询消息通知详情
+ (NSString *)selectNewsByPage;

/// 插入邀请认证消息
+ (NSString *)addMessageStatus;

#pragma mark -
/// 会客厅
+ (NSString *)huiketing;

#pragma mark - 课程
/**
 * 首页获取课程列表
 * {"current":"当前页码"}
 * POST
 
@return URLString
*/
+ (NSString *)getLiveCourseList;

/**
 * 获取课程详情
 * {"courseId":"课程id"}
 * GET
 
@return URLString
*/
+ (NSString *)getLiveCourseDetail:(NSString *)courseId;

/**
 * 获取课时回放列表
 * {"courseId":"课程id"}
 * GET
 
@return URLString
*/
+ (NSString *)selectPlaybackCourseChapterList:(NSString *)courseId;

/**
 * 创建课程
 * {"courseTitle":"课程标题", "description":"课程简介", "coverImage":"课程封面图片路径", "isFree":"是否免费，1 是，2 否", "coursePrice":"课程售价"}
 * POST
 
@return URLString
*/
+ (NSString *)addLiveCourse;

/**
 * 添加课时
 * {"courseId":"课程id", "chapterSort":"课时序号", "chapterTitle":"课时标题", "isFree":"是否免费，1 是，2 否", "liveStartTime":"开播时间"}
 * POST
 
@return URLString
*/
+ (NSString *)addLiveCourseChapter;

/**
 * 修改课时
 * {"courseId":"课程id", "chapterId":"课时id", "chapterTitle":"课时标题", "isFree":"是否免费，1 是，2 否", "liveStartTime":"开播时间"}
 * POST
 
@return URLString
*/
+ (NSString *)updateLiveCourseChapter;

/**
 * 删除课时
 * {"courseId":"课程id", "chapterId":"课时id"}
 * POST
 
@return URLString
*/
+ (NSString *)deleteLiveCourseChapter;

/**
 * 修改课时列表排序
 * {"courseId":"课程id", "chapterList":"课时数组"}
 * "chapterList": [
             {
               "chapterId": 2,              //课时主键id
               "chapterSort": 1,            //课时序号
              },
            ...
            ]
 * POST
 
@return URLString
*/
+ (NSString *)updateLiveCourseChapterSort;

/**
 * 课程发布
 * {"courseId":"课程id"}
 * POST
 
@return URLString
*/
+ (NSString *)publishLiveCourse;

/**
 * 课程信息查询 (课程发布结果查询)
 * {"courseId":"课程id"}
 * GET
 
@return URLString
*/
+ (NSString *)getSingleLiveCourseDetail:(NSString *)courseId;

/**
 * 获取老师课程列表
 * {"current":"当前页码"}
 * POST
 
@return URLString
*/
+ (NSString *)getLiveCourseListOfCurrentTeacher;


/// 获取艺术家可以观看的课程列表
+ (NSString *)selectEffectLiveCourseListOfTeacher;

/**
 * 老师编辑课程
 * {"courseId":"课程id", "description":"课程描述", "chapterTitle":"课时标题", "isFree":"是否免费，1 是，2 否", "coverImage":"课程封面图片路径", "coursePrice":"课程售价"}
 * POST
 
@return URLString
*/
+ (NSString *)updateLiveCourseListOfCurrentTeacher;

/**
 * 老师结束课程
 * {"courseId":"课程id"}
 * POST
 
@return URLString
*/
+ (NSString *)stopLiveCourse;

/**
 * 加入学习，即用户购买课程
 * {"courseId":"课程id"}
 * POST
 
@return URLString
*/
+ (NSString *)addLiveCourseOrder;

/// 删除课程
+ (NSString *)deleteLiveCourse;

#pragma mark - 易币
/// 获取用户的艺币余额
+ (NSString *)selectUserWalletByUserId;

/// 获取用户的艺币明细列表
/*
 consumeType    int    否    null    消费类型 1:充值(+);2消费(-)，空代表查询全部
 current    int    是    notnull    当前页码
 size    int    否    null    每页大小
 
 */
+ (NSString *)selectAccountVirualGoldDetailListByMemberId;

/// 获取系统民币艺币兑换列表
+ (NSString *)selectBasicRmbVmoneyRatioList;

/// 立即支付（即下单操作-下支付订单）
+ (NSString *)addLiveVrtualGoldOrder;

/// 艺币订单明细
+ (NSString *)selectAccountVirtualGoldDetailById;

/// ApplePay回调
+ (NSString *)applePayNotify;


#pragma mark - 直播间
/// 获取直播间推流地址（讲师获取推流地址）
+ (NSString *)getPushStreamAddr;
/// 进入直播间(获取课时直播间拉流)
+ (NSString *)getPullStreamAddr;

/// 开启课时直播
+ (NSString *)startLiveCourseChapter;
/// 结束课时直播
+ (NSString *)stopLiveCourseChapter;
/// 艺术家退出直播间（未勾选结束课时直播）
+ (NSString *)quitLiveRoomOfLiveCourseChapter;
/// 艺术家重新进入直播间
+ (NSString *)restartLiveCourseChapter;

/// 广播在线人数
/// @param roomID 房间ID
+ (NSString *)updateOnlineMemberNum:(NSString *)roomID;

/// 新增直播课程聊天记录
+ (NSString *)addLiveCourseChapterMsg;

/// 分页查询直播课程聊天记录
+ (NSString *)queryPageLiveCourseChapterMsg;
/// 我的课程数量统计
+ (NSString *)selectLiveCourseCountOfCurrentTeacher;


/// 生成签名
+ (NSString *)sigApi;
#pragma mark - 我的学习

/// 课程订单列表
+ (NSString *)selectLiveCourseOrderListOfMySelf;


/// 获取回放视频地址
+ (NSString *)selectPlaybackAddressByChapterId;


#pragma mark - 直播pm
/// 专场列表
+ (NSString *)selectAuctionFieldListOfHome;
/// 专场详情
+ (NSString *)selectAuctionFieldInfoById:(NSString *)auctionFieldId;
/// 专场详情里面的拍品列表
+ (NSString *)selectAuctionGoodsListByAuctionFieldId;
/// 拍品详情
+ (NSString *)selectAuctionGoodsById:(NSString *)auctionGoodId;
/// 查看拍品出价记录
+ (NSString *)selectAuctionGoodsOfferPriceListByAuctionGoodId;
/// 用户办理线上号牌
+ (NSString *)addAuctionUserPlateNumberOfOnline;
/// 用户生成保证金订单
+ (NSString *)addAuctionUserDepositOrderByPlateNumberLogId;
/// 办理号牌时去支付选择’线下支付‘是更改支付订单的支付方式
+ (NSString *)updateAuctionUserDepositOrderPayTypeById;
/// 用户出价
+ (NSString *)addOfferPriceToAuctionGoodsOfCurrentUser;
/// 获取拍品的下一口价格
+ (NSString *)selectNextOfferPriceByAuctionGoodId:(NSString *)auctionGoodId;
/// 获取下20口价
/// @param auctionGoodId 拍品id
+ (NSString *)selectNextOfferPriceListByAuctionGoodId:(NSString *)auctionGoodId;
/// 获取pm专场直播拉流地址
+ (NSString *)getPalyUrlOfAuctionField:(NSString *)auctionFieldId;
/// 查看当前用户号牌详情
+ (NSString *)selectAuctionUserPlateNumberByCurrentUser:(NSString *)auctionFieldId;
/// 获取专场正在直播的拍品
+ (NSString *)selectLivingAuctionGoodsIdByAuctionFieldId:(NSString *)auctionFieldId;

/// 参拍记录
+ (NSString *)selectAuctionUserGoodsRecordListOfCurrentUser;
/// 未结拍品(购物车)
+ (NSString *)selectAuctionUnsettledGoodsListByCurrentUser;
/// 获取订单详情
+ (NSString *)selectAuctionGoodOrderDetailOfAuctionUserById:(NSString *)auctionOrderId;
/// 拍品订单列表
+ (NSString *)selectAuctionGoodOrderListByAuctionUseId;
/// 我的保证金流水列表
+ (NSString *)selectAuctionUserDepositOrderListOfCurrentUser;
/// pm下单接口
+ (NSString *)addAuctionGoodOrder;
/// 拍品确认收货
+ (NSString *)confirmReceiptOfAuctionUserByAuctionGoodOrderId:(NSString *)auctionGoodOrderId;
/// 获取冻结保证金
+ (NSString *)selectDepositOrderStatisticsInfoOfCurrentUser;
/// 根据图录号和专场id查询拍品id
+ (NSString *)selectAuctionGoodIdByGoodNumberAndFieldId;


#pragma mark - 分享链接
/// 分享课程详情
/// @param courseID 课程id
+ (NSString *)shareCourseDetailURL:(NSString *)courseID;


@end

NS_ASSUME_NONNULL_END
