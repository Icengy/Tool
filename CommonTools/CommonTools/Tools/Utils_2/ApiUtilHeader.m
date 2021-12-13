//
//  ApiUtilHeader.m
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/10/29.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import "ApiUtilHeader.h"

#define SplicingNewURLWith(urlStr)  [NSString stringWithFormat:@"%@/%@", URL_NEW_HOST, urlStr]
#define JavaNewUrl(urlStr)  [NSString stringWithFormat:@"%@/app-web/%@", URL_JAVA_HOST, urlStr]

@implementation ApiUtilHeader
#pragma mark - 统一配置获取
+ (NSString *)selectImConf {
    return JavaNewUrl(@"api/conf/im");
}
+ (NSString *)get_app_application {
    return @"/ApiV4/App/get_app_application";
}


#pragma mark - 账号登录相关
+ (NSString *)getVerificationCode {
    return @"/ApiV4/App/get_verification_code";
}

+ (NSString *)verifyCode {
    return @"/ApiV4/App/verify_code";
}

+ (NSString *)smsLoginOrRegister {
    return @"/ApiV4/User/sms_login_or_register";
}

+ (NSString *)accountLoginOrRegister {
    return @"/ApiV4/User/account_login";
}

+ (NSString *)registerWithWechat {
    return @"/ApiV4/User/register_with_wechat";
}

+ (NSString *)bindWithWechat {
    return @"/ApiV4/User/bind_wechat";
}

+ (NSString *)thirdLogin {
    return @"/ApiV4/User/third_login";
}

+ (NSString *)firstSetPassword {
    return @"/ApiV4/User/set_password";
}

+ (NSString *)changePassword {
    return @"/ApiV4/User/change_password";
}

+ (NSString *)resetPassword {
    return @"/ApiV4/User/reset_password";
}

+ (NSString *)b_wechat {
    return @"/ApiV4/User/b_wechat";
}

#pragma mark - 地址相关
+ (NSString *)getUserAddressList {
    return @"/ApiV4/User/get_user_address_list";
}

+ (NSString *)editUserAddress {
    return @"/ApiV4/User/edit_user_address";
}

+ (NSString *)getUserDefaultAddress {
    return @"/ApiV4/User/get_user_default_address";
}

#pragma mark - 个人/他人中心相关
+ (NSString *)getUserInfo {
    return @"/ApiV4/VUser/index";
}

+ (NSString *)getArtistUserInfo {
    return @"/ApiV4/VUser/get_artist_mange_info";
}

+ (NSString *)getOtherUserInfo {
    return @"/ApiV4/VUser/get_art_index";
}

+ (NSString *)editUserInfo {
    return @"/ApiV4/User/edit_user_info";
}
/// 图片上传
+ (NSString *)uploadImage {
    return @"/ApiV4/Public/upload";
}
/// JAVA图片上传
+ (NSString *)JAVA_UploadImage {
    return JavaNewUrl(@"/file/upload");
}

+ (NSString *)getCollectUserList {
    return @"/ApiV4/Mine/get_collect_user_list";
}

+ (NSString *)getFansList {
    return @"/ApiV4/Mine/get_fans_list";
}

+ (NSString *)getUserObjectLikedList {
    return SplicingNewURLWith(@"AppCommon/get_user_object_be_liked_list");
}

+ (NSString *)getCollFansCount {
    return @"/ApiV4/VUser/get_coll_fans_count";
}

+ (NSString *)getMessageList {
    return @"/ApiV4/RedisMessage/get_system_list";
}

+ (NSString *)getMessageDetail {
    return @"/ApiV4/Message/get_message_detail";
}

+ (NSString *)setAllmessageRead {
    return @"/ApiV4/RedisMessage/set_all_msg_read";
}

+ (NSString *)updateMessageStatus {
    return JavaNewUrl(@"YptUserMessage/updateMessageStatus");
}

+ (NSString *)clearUnreadFabulous {
    return @"/ApiV4/RedisMessage/clear_unread_fabulous";
}

+ (NSString *)deleteSystemMsg {
    return @"/ApiV4/RedisMessage/del_msg";
}

+ (NSString *)checkIDcard {
    return @"/ApiV4/FaceId/check_id_wt_mobile";
}

+ (NSString *)getUserIdentInfo {
    return @"/ApiV4/UserIdent/get_user_ident_info";
}

+ (NSString *)get_user_id {
    return @"/ApiV4/user/get_user_id";
}

+ (NSString *)get_artist_base_info {
    return @"/ApiV4/VUser/get_artist_base_info";
}

#pragma mark - 获取个人/他人中心视频列表相关
+ (NSString *)getIndexMineVideoList {
    return @"/ApiV4/VUser/get_index_video_list";
}

+ (NSString *)getIndexMineCollectionList {
    return @"/ApiV4/VUser/get_index_collect_video";
}

+ (NSString *)getIndexMineDraftList {
    return @"/ApiV4/VUser/get_index_video_drafts";
}

+ (NSString *)getIndexOtherVideoList {
    return @"/ApiV4/VUser/get_art_video_list";
}

+ (NSString *)getIndexOtherLikeList {
    return @"/ApiV4/VUser/get_art_video_like_list";
}

#pragma mark - 短视频相关
+ (NSString *)getUploadSignature {
    return @"/ApiV4/Accesstoken/get_upload_signature";
}

//发布/保存视频，无修改，不带商品
+ (NSString *)postVideoWithoutGoodsWithoutModeify {
    return @"/ApiV4/Video/publish_video";
}

//发布/保存视频，有修改，不带商品
+ (NSString *)postVideoWithoutGoodsWithModeify {
    return @"/ApiV4/Video/update_video_no_goods";
}

//发布视频，无修改，带商品
+ (NSString *)publishVideoWithGoodsWithoutModeify {
    return @"/ApiV4/Video/publish_video_with_goods";
}

//保存视频，无修改，带商品
+ (NSString *)saveVideoWithGoodsWithoutModeify {
    return @"/ApiV4/Video/save_draft";
}

//保存视频，有修改，带商品
+ (NSString *)saveVideoWithGoodsWithModeify {
    return @"/ApiV4/Video/upd_video_w_goods_t_raft";
}

//发布视频，有修改，带商品
+ (NSString *)publishVideoWithGoodsWithModeify {
    return @"/ApiV4/Video/upd_video_w_goods_t_publish";
}

+ (NSString *)editVideoInfo {
    return @"/ApiV4/Video/edit_video_info";
}

#pragma mark -获取视频详情
+ (NSString *)getVideoDetials {
    return @"/ApiV4/Video/get_video_detials";
}

+ (NSString *)getVideoColumn {
    return SplicingNewURLWith(@"AppCommon/get_video_column");
}

#pragma mark - 搜索模块
+ (NSString *)getSearchRecord {
    return @"/ApiV4/Search/get_search_record";
}

+ (NSString *)getUserListSearch {
    return @"/ApiV4/Search/n_search_user_list";
}

+ (NSString *)getVideoListSearch {
    return @"/ApiV4/Video/get_video_search";
}

+ (NSString *)deleteVideo {
    return @"/ApiV4/Video/del_video";
}

+ (NSString *)getVideoDetailForUpdate {
    return @"/ApiV4/Video/get_video_details_forupdate";
}

#pragma mark -  首页相关
+ (NSString *)getRecommendVideoList {
    return @"/ApiV4/Video/get_Recommend_video_list";
}

+ (NSString *)getMyCollectVideoList {
    return @"/ApiV4/Video/get_MyCollect_video_list";
}

+ (NSString *)getAds {
    return @"/ApiV4/App/get_ads";
}

+ (NSString *)get_slogan {
    return @"/ApiV4/App/get_slogan";
}

+ (NSString *)getRecommendArtist {
    return @"/ApiV4/Artist/get_recommend_artist";
}

#pragma mark - 用户操作相关 点赞/收藏视频、关注用户
+ (NSString *)collectObject {
    return @"/ApiV4/Collect/collect_object";
}

+ (NSString *)collectUser {
    return @"/ApiV4/Collect/collect_user";
}

+ (NSString *)reportObject {
    return SplicingNewURLWith(@"AppCommon/report_object");
}

#pragma mark - 商品相关
+ (NSString *)getGoodsDetail {
    return @"/ApiV4/MallGoods/get_goods_detail";
}

+ (NSString *)getGoodsDetailNew {
    return SplicingNewURLWith(@"Goods/get_good_detail");
}

+ (NSString *)editGoodsInfo {
    return @"/ApiV4/Video/edit_good_info";
}

+ (NSString *)deleteGoods {
    return @"/ApiV4/Video/delete_good";
}


/// 商品列表
+ (NSString *)get_goods_list_with_map {
    return @"/ApiV4/MallGoods/get_goods_list_with_map";
}



#pragma mark - 下单相关
+ (NSString *)buildGoodsOrder {
    return @"/ApiV4/BuyOrder/build_goods_order";
}

+ (NSString *)getBuyOrderList {
    return @"/ApiV4/BuyOrder/new_get_order_list_with_map";
}

+ (NSString *)getSellOrderList {
    return @"/ApiV4/SellOrder/new_get_order_list_with_map";
}

+ (NSString *)getBuyOrderDetail {
    return @"/ApiV4/BuyOrder/get_goods_order_detail";
}

+ (NSString *)getSellOrderDetail {
    return @"/ApiV4/SellOrder/get_goods_order_detail";
}

+ (NSString *)applyRefund {
    return @"/ApiV4/BuyOrder/apply_refund";
}

+ (NSString *)dealRefund {
    return @"/ApiV4//SellOrder/deal_refund";
}

+ (NSString *)resetGoodOrderAddress {
    return @"/ApiV4/BuyOrder/reset_good_order_address";
}

+ (NSString *)confirmReceiptForBuyer {
    return @"/ApiV4/BuyOrder/confirm_receipt";
}

+ (NSString *)confirmReceiptForSeller {
    return @"/ApiV4/SellOrder/confirm_receipt";
}

+ (NSString *)applyOrderForOrder {
    return @"/ApiV4/ApplyOrder/apply_order";
}

+ (NSString *)applyOrderForWallet  {
    return @"/ApiV4/DrawCashOrder/add_draw_cash_order";
}

+ (NSString *)addDeliveryForBuyer {
    return @"/ApiV4/BuyOrder/add_delivery";
}

+ (NSString *)addDeliveryForSeller {
    return @"/ApiV4/SellOrder/add_delivery";
}

+ (NSString *)getCustomerTelephone {
    return SplicingNewURLWith(@"AppCommon/get_customer_telephone");
}

#pragma mark - 支付相关
#pragma mark ---------- 微信支付
+ (NSString *)sendOrderWithWX {
    return @"/ApiV4/WxPay/pay";
}

#pragma mark ---------- 支付宝支付
+ (NSString *)sendOrderWithAlipay {
    return @"/ApiV4/Alipay/tradeAppPay";
}

#pragma mark - 统一支付
+ (NSString *)payCommon {
    return JavaNewUrl(@"api/pay/openPay3");
}

#pragma mark - 收款账户相关
+ (NSString *)getUserBankAccountList {
    return @"/ApiV4/VUser/get_user_bank_account";
}

+ (NSString *)deleteUserBankAccount {
    return @"/ApiV4/VUser/delete_user_bank_account";
}

+ (NSString *)bindPayOpenid {
    return @"/ApiV4/User/Bind_Pay_Openid";
}

+ (NSString *)getBanklist {
    return @"/ApiV4/VUser/get_banklist";
}

+ (NSString *)addUserBankAccount {
    return @"/ApiV4/VUser/add_user_bank_account";
}

#pragma mark - 认证相关
+ (NSString *)artistIdentifyIndex {
    return @"/ApiV4/UserIdent/n_ident_index";
}

+ (NSString *)getIdentInfo {
    return @"/ApiV4/UserIdent/get_ident_info";
}

+ (NSString *)addUserIdentify {
    return @"/ApiV4/UserIdent/n_add_user_identify";
}

+ (NSString *)getDetectAuth {
    return @"/ApiV4/FaceId/newGetDetectAuth";
}

+ (NSString *)posDetectInfo {
    return @"/ApiV4/FaceId/newGetDetectInfo";
}

+ (NSString *)getCateTree {
    return @"/ApiV4/App/get_cate_tree";
}

#pragma mark - 协议文本相关
+ (NSString *)getSystemArticle {
    return @"/ApiV4/App/get_system_article";
}

#pragma mark - 打赏相关
+ (NSString *)getGiftRank {
    return @"/ApiV4/Gift/get_gift_rank";
}

+ (NSString *)getApplyAmount {
    return @"/ApiV4/Gift/get_apply_amount";
}

+ (NSString *)getMySendOutGift {
    return @"/ApiV4/Gift/get_my_Send_Out_Gift";
}

+ (NSString *)getMyReceivedGift {
    return @"/ApiV4/Gift/get_my_Received_Gift";
}

+ (NSString *)rollTips {
    return @"/ApiV4/Gift/roll_tips";
}

#pragma mark - 分享相关
+ (NSString *)getShareUrl {
    return @"/ApiV4/Video/shareUrl";
}


#pragma mark - 版本相关
+ (NSString *)getVersion {
    return @"/ApiV4/Public/get_version";
}

#pragma mark - 黑名单相关
+ (NSString *)get_blacklist {
    return @"/ApiV4/Collect/get_blacklist";
}

#pragma mark - 资讯相关
+ (NSString *)getInfoTypeList {
    return @"/ApiV4/Information/getInfoTypeList";
}

+ (NSString *)get_information_list {
    return @"/ApiV4/Information/get_information_list";
}

+ (NSString *)getInformationDetail {
    return @"/ApiV4/Information/get_information_detail";
}

#pragma mark - 推送相关
+ (NSString *)getUnreadCount {
    return @"/ApiV4/RedisMessage/get_unread_count";
}

#pragma mark - 邀新相关
+ (NSString *)getMyInviterList {
    return @"/ApiV4/Invitation/get_my_inviter_list";
}

+ (NSString *)getMyInviter {
    return @"/ApiV4/Invitation/get_my_inviter";
}

+ (NSString *)addMyInviter {
    return @"/ApiV4/Invitation/add_my_inviter";
}

#pragma mark - 钱包相关
+ (NSString *)myIncomeIndex {
    return @"/ApiV4/Bill/my_income_index";
}

+ (NSString *)getBillList {
    return @"/ApiV4/Bill/get_bill_list";
}

+ (NSString *)getIncomeDetails {
    return @"/ApiV4/Bill/get_income_details";
}

+ (NSString *)getMyWalletBalance {
    return @"/ApiV4/UserWallet/get_my_wallet_balance";
}

+ (NSString *)getMyRealyMoneyList {
    return @"/ApiV4/RealMoneyOrder/get_my_realymoney_list";
}

+ (NSString *)getMyRealyMoneyDetails {
    return @"/ApiV4/RealMoneyOrder/get_details";
}

+ (NSString *)getSaleProfitList {
    return @"/ApiV4/Bill/get_sale_profit_list";
}

#pragma mark - 评论回复

+ (NSString *)addComment {
    return SplicingNewURLWith(@"Comment/add_comment");
    //    return [NSString stringWithFormat:@"%@/Comment/add_comment", URL_NEW_HOST];
}

+ (NSString *)getTreeCommentList {
    return SplicingNewURLWith(@"Comment/get_tree_comment_list");
    //    return [NSString stringWithFormat:@"%@/Comment/get_tree_comment_list", URL_NEW_HOST];
}

+ (NSString *)getReplyBySingleComment {
    return SplicingNewURLWith(@"Comment/get_reply_by_single_comment");
    //    return [NSString stringWithFormat:@"%@/Comment/get_reply_by_single_comment", URL_NEW_HOST];
}

+ (NSString *)addReplyToComment {
    return SplicingNewURLWith(@"Comment/add_reply_to_comment");
    //    return [NSString stringWithFormat:@"%@/Comment/add_reply_to_comment", URL_NEW_HOST];
}

+ (NSString *)aboutCommentLike {
    return SplicingNewURLWith(@"Comment/about_comment_like");
    //    return [NSString stringWithFormat:@"%@/Comment/add_reply_to_comment", URL_NEW_HOST];
}

+ (NSString *)getCommentNoticeList {
    return SplicingNewURLWith(@"Comment/get_comment_notice_list");
}

+ (NSString *)getReplyNoticeList {
    return SplicingNewURLWith(@"Comment/get_reply_notice_list");
}

+ (NSString *)setNoticeRead {
    return SplicingNewURLWith(@"AppCommon/set_notice_read");
}

#pragma mark - 视频编辑-音频
+ (NSString *)getMusicCategory {
    return SplicingNewURLWith(@"AppCommon/get_music_category");
}

+ (NSString *)getMusicList {
    return SplicingNewURLWith(@"AppCommon/get_music_list");
}

#pragma mark - 一键登录相关接口
//获取认证密钥
+ (NSString *)mobileGetCaseSecret {
    return JavaNewUrl(@"api/mobile/getCaseSecret");
}

//获取本机手机号
+ (NSString *)mobilePhoneNumber {
    return JavaNewUrl(@"api/mobile/phoneNumber");
}

/// 一键登录用的注册和登录通用接口
+ (NSString *)userMobileLoginOrRegister {
    return @"/ApiV4/User/mobile_login_or_register";
}


#pragma mark - 会客相关接口
/// 进房
+ (NSString *)enterMeetingRoom {
    return @"/ApiV4/App/get_meeting_sign_by_user_id";
}

/// 会客管理列表
+ (NSString *)tea_Manager {
    return JavaNewUrl(@"teaAboutInfo/selectListByPage");
}
//邀请名单
+ (NSString *)invitationNumberList {
    return JavaNewUrl(@"Invite/selectInvitrListPage");
}
//会客记录
+ (NSString *)tea_Record {
    return JavaNewUrl(@"teaAboutInfo/selectListRecordByPage");
}
//约见详情
+ (NSString *)tea_meetingDetail:(NSString *)teaAboutOrderId {
    NSString *url = [NSString stringWithFormat:@"tea/order/selectOrderByOrderId/%@", teaAboutOrderId];
    return JavaNewUrl(url);
}
//取消约见
+ (NSString *)teaOrderCancel:(NSString *)teaAboutOrderId {
    NSString *url = [NSString stringWithFormat:@"tea/order/cancel/%@", teaAboutOrderId];
    return JavaNewUrl(url);
}

//约见记录
+ (NSString *)appoint_recordUrl{
    return JavaNewUrl(@"tea/order/page");
}
// 约见详情-时间延期
+ (NSString *)appoint_endTime_Delay{
    return JavaNewUrl(@"tea/order/updateEndTime");
}
//约见订单状态修改
+ (NSString *)appointment_statusChange{
    return JavaNewUrl(@"tea/order/updateOrderStatus");
}


+ (NSString *)getArtTeaStting:(NSString *)artistId {
    NSString *url = [NSString stringWithFormat:@"teaAboutSystem/selectTeaConfig/%@", artistId];
    return JavaNewUrl(url);
}

+ (NSString *)getArtTeaStatus {
    return JavaNewUrl(@"teaAboutSystem/selectTeaStatus");
}

+ (NSString *)getTeaBondList {
    return JavaNewUrl(@"teaAboutPriceConfig/securityDeposit");
}

+ (NSString *)getArtInfoBeforeCreatOrder {
    return JavaNewUrl(@"tea/order/selectArtInfoBeforeCreatOrder");
}


+ (NSString *)addTeaOrder {
    return JavaNewUrl(@"tea/order/addTeaOrder");
}

+ (NSString *)payTeaOrder {
    return JavaNewUrl(@"api/pay/openPay");
}

+ (NSString *)getOrderInfoText {
    /// articleCode
    return JavaNewUrl(@"teaAboutPriceConfig/selectOneOrAllSystemArticle");
}

+ (NSString *)changeTeaSystemStatus {
    return JavaNewUrl(@"teaAboutSystem/teaSystem");
}

+ (NSString *)selectMakePleaseList {
    return JavaNewUrl(@"teaAboutInfo/selectMakePleaseList");
}

+ (NSString *)selectMakeByPage {
    return JavaNewUrl(@"teaAboutInfo/selectMakeByPage");
}

+ (NSString *)addTwoSubmit {
    return JavaNewUrl(@"teaAboutInfo/addTwoSubmit");
}

+ (NSString *)canNewTea {
    return JavaNewUrl(@"teaAboutInfo/selectInfoType");
}

+ (NSString *)addteaAbout {
    return JavaNewUrl(@"teaAboutInfo/addTeaAbout");
}

+ (NSString *)getMeetingDetail {
    return JavaNewUrl(@"teaAboutInfo/selectById");
}

+ (NSString *)getTeaInviteList {
    return JavaNewUrl(@"Invite/selectRollPage");
}

+ (NSString *)getMeetingOrderRecordList {
    return JavaNewUrl(@"tea/order/page");
}

+ (NSString *)getMeetingOrderManageListStatusCountByGroup {
    return JavaNewUrl(@"tea/order/selectOrderStatusCountByGroup");
}

+ (NSString *)getMeetingOrderManageList {
    return JavaNewUrl(@"tea/order/selectAllInviteStatusAndCount");
}

+ (NSString *)getMeetingInveteInfo {
    return JavaNewUrl(@"Invite/selectStartTime");
}

+ (NSString *)updateOrderStatus {
    return JavaNewUrl(@"tea/order/updateOrderStatus");
}

+ (NSString *)postRoomStatistics {
    return JavaNewUrl(@"room/timeStatistics");
}

+ (NSString *)getRoomMemberList {
    return JavaNewUrl(@"tea/party/user");
}

+ (NSString *)uploadRoomMemberStatus {
    return JavaNewUrl(@"tea/party/operation/edit");
}

+ (NSString *)updateMeetingExplain {
    return JavaNewUrl(@"teaAboutInfo/updateExplain");
}

+ (NSString *)cancelMeetingParty {
    return JavaNewUrl(@"teaAboutInfo/cancelParty");
}

+ (NSString *)selectInfoLogByArtId {
    return JavaNewUrl(@"teaAboutInfo/selectInfoLogByArtId");
}

+ (NSString *)selectArtInfoCountByInfoStatus {
    return JavaNewUrl(@"teaAboutInfo/selectArtInfoCountByInfoStatus");
}


/// 获取艺术家可以观看的课程列表
+ (NSString *)selectEffectLiveCourseListOfTeacher {
    return JavaNewUrl(@"liveCourse/selectEffectLiveCourseListOfTeacher");
}
#pragma mark - 权属证书
+ (NSString *)selectWaitAuthGoodsList {
    return @"/ApiV4/VUser/select_wait_auth_goods";
}

+ (NSString *)certificateQueryList{
    return JavaNewUrl(@"certificate/query");
}

#pragma mark - 消息
+ (NSString *)selectNewsList{
    return JavaNewUrl(@"YptUserMessage/selectNewsList");
}
+ (NSString *)selectNewsByPage{
    return JavaNewUrl(@"YptUserMessage/selectNewsByPage");
}

+ (NSString *)addMessageStatus {
    return JavaNewUrl(@"YptUserMessage/addMessageStatus");
}

#pragma mark - 会客厅
+ (NSString *)huiketing{
    return JavaNewUrl(@"user/name");
}

#pragma mark - 课程
/// 首页获取课程列表
+ (NSString *)getLiveCourseList {
    return JavaNewUrl(@"liveCourse/selectLiveCourseList");
}

/// 获取课程详情
+ (NSString *)getLiveCourseDetail:(NSString *)courseId{
    NSString *url = [NSString stringWithFormat:@"liveCourse/selectLiveCourseDetailVOByCourseId/%@", courseId];
    return JavaNewUrl(url);

}

/// 获取课时回放列表
+ (NSString *)selectPlaybackCourseChapterList:(NSString *)courseId {
    NSString *url = [NSString stringWithFormat:@"liveCourse/selectPlaybackCourseChapterListByCourseId/%@", courseId];
    return JavaNewUrl(url);
}

/// 创建课程
+ (NSString *)addLiveCourse {
    return JavaNewUrl(@"liveCourse/addLiveCourse");
}

/// 添加课时
+ (NSString *)addLiveCourseChapter {
    return JavaNewUrl(@"liveCourseChapter/addLiveCourseChapter");
}

/// 修改课时
+ (NSString *)updateLiveCourseChapter {
    return JavaNewUrl(@"liveCourseChapter/updateLiveCourseChapterByChapterId");
}

/// 删除课时
+ (NSString *)deleteLiveCourseChapter {
    return JavaNewUrl(@"liveCourseChapter/deleteLiveCourseChapterByChapterId");
}

/// 修改课时列表排序
+ (NSString *)updateLiveCourseChapterSort {
    return JavaNewUrl(@"liveCourseChapter/updateLiveCourseChapterSortByCourseId");
}

/// 课程发布
+ (NSString *)publishLiveCourse {
    return JavaNewUrl(@"liveCourse/publishLiveCourseByCourseId");
}

/// 课程信息查询
+ (NSString *)getSingleLiveCourseDetail:(NSString *)courseId {
    NSString *url = [NSString stringWithFormat:@"liveCourse/selectLiveCourseByCourseId/%@", courseId];
    return JavaNewUrl(url);
}

/// 老师课程列表
+ (NSString *)getLiveCourseListOfCurrentTeacher {
    return JavaNewUrl(@"liveCourse/selectLiveCourseListOfCurrentTeacher");
}

/// 老师编辑课程
+ (NSString *)updateLiveCourseListOfCurrentTeacher {
    return JavaNewUrl(@"liveCourse/updateLiveCourseListOfCurrentTeacher");
}

///  老师结束课程
+ (NSString *)stopLiveCourse {
    return JavaNewUrl(@"liveCourse/stopLiveCourse");
}

/// 加入学习，即用户购买课程
+ (NSString *)addLiveCourseOrder {
    return JavaNewUrl(@"liveCourseOrder/addLiveCourseOrder");
}


#pragma mark - 易币

/// 获取用户的艺币余额
+ (NSString *)selectUserWalletByUserId {
    return JavaNewUrl(@"userWallet/selectUserWalletByUserId");
}

/// 获取用户的艺币明细列表
+ (NSString *)selectAccountVirualGoldDetailListByMemberId {
    return JavaNewUrl(@"accountVirtualGoldDetail/selectAccountVirtualGoldDetailListByMemberId");
}

/// 获取系统民币艺币兑换列表
+ (NSString *)selectBasicRmbVmoneyRatioList {
    return JavaNewUrl(@"basicRmbVmoneyRatio/selectBasicRmbVmoneyRatioList");
}

/// 立即支付（即下单操作-下支付订单，生成艺币充值订单）
+ (NSString *)addLiveVrtualGoldOrder {
    return JavaNewUrl(@"liveVirtualGoldOrder/addLiveVirtualGoldOrder");
}

/// 艺币订单明细
+ (NSString *)selectAccountVirtualGoldDetailById {
    return JavaNewUrl(@"accountVirtualGoldDetail/selectAccountVirtualGoldDetailById");
}
/// ApplePay回调
+ (NSString *)applePayNotify{
    return JavaNewUrl(@"api/pay/applePayNotify");
}


#pragma mark - 直播间
/// 获取直播间推流地址（讲师获取推流地址）
+ (NSString *)getPushStreamAddr {
    return JavaNewUrl(@"liveCourseChapter/selectLiveCourseChapterLiveRoomAddr");
}

/// 获取课时直播间拉流
+ (NSString *)getPullStreamAddr {
    return JavaNewUrl(@"liveCourseChapter/selectLiveRoomAddressByChapterId");
}
/// 开启课时直播
+ (NSString *)startLiveCourseChapter {
    return JavaNewUrl(@"liveCourseChapter/startLiveCourseChapter");
}
/// 结束课时直播
+ (NSString *)stopLiveCourseChapter {
    return JavaNewUrl(@"liveCourseChapter/stopLiveCourseChapter");
}
/// 艺术家退出直播间（未勾选结束课时直播）
+ (NSString *)quitLiveRoomOfLiveCourseChapter {
    return JavaNewUrl(@"liveCourseChapter/quitLiveRoomOfLiveCourseChapter");
}
/// 艺术家重新进入直播间
+ (NSString *)restartLiveCourseChapter {
    return JavaNewUrl(@"liveCourseChapter/restartLiveCourseChapter");
}

/// 删除课程
+ (NSString *)deleteLiveCourse {
    return JavaNewUrl(@"liveCourse/deleteLiveCourse");
}




/// 广播在线人数
+ (NSString *)updateOnlineMemberNum:(NSString *)roomID{
    NSString *url = [NSString stringWithFormat:@"api/im/updateOnlineMemberNum/%@", roomID];
    return JavaNewUrl(url);
}
/// 新增直播课程聊天记录
+ (NSString *)addLiveCourseChapterMsg {
    return JavaNewUrl(@"liveCourseChapterMsg/addLiveCourseChapterMsg");
}

/// 分页查询直播课程聊天记录
+ (NSString *)queryPageLiveCourseChapterMsg {
    return JavaNewUrl(@"liveCourseChapterMsg/queryPageLiveCourseChapterMsg");
}
/// 我的课程数量统计
+ (NSString *)selectLiveCourseCountOfCurrentTeacher {
    return JavaNewUrl(@"liveCourse/selectLiveCourseCountOfCurrentTeacher");
}
/// 生成签名
+ (NSString *)sigApi {
    return JavaNewUrl(@"api/conf/sigApi");
}



#pragma mark - 我的学习

/// 课程订单列表
+ (NSString *)selectLiveCourseOrderListOfMySelf {
    return JavaNewUrl(@"liveCourseOrder/selectLiveCourseOrderListOfMySelf");
}
/// 获取回放视频地址
+ (NSString *)selectPlaybackAddressByChapterId{
    return JavaNewUrl(@"liveCourseChapter/selectPlaybackAddressByChapterId");
}

#pragma mark - 直播pm

/// 专场列表
+ (NSString *)selectAuctionFieldListOfHome{
    return JavaNewUrl(@"auctionField/selectAuctionFieldListOfHome");
}
/// 专场详情（带拍品列表）
+ (NSString *)selectAuctionFieldInfoById:(NSString *)auctionFieldId{
    NSString *url = [NSString stringWithFormat:@"auctionField/selectAuctionFieldInfoById/%@", auctionFieldId];
    return JavaNewUrl(url);
}
/// 专场详情里面的拍品列表
+ (NSString *)selectAuctionGoodsListByAuctionFieldId{
    return JavaNewUrl(@"auctionGoods/selectAuctionGoodsListByAuctionFieldId");
}
/// 拍品详情
+ (NSString *)selectAuctionGoodsById:(NSString *)auctionGoodId{
    NSString *url = [NSString stringWithFormat:@"auctionGoods/selectAuctionGoodsById/%@", auctionGoodId];
    return JavaNewUrl(url);
}
/// 查看拍品出价记录
+ (NSString *)selectAuctionGoodsOfferPriceListByAuctionGoodId{
    return JavaNewUrl(@"auctionGoodsOfferPrice/selectAuctionGoodsOfferPriceListByAuctionGoodId");
}


/// 用户办理线上号牌
+ (NSString *)addAuctionUserPlateNumberOfOnline{
    return JavaNewUrl(@"plateNumber/addAuctionUserPlateNumberOfOnline");
}
/// 用户生成保证金订单
+ (NSString *)addAuctionUserDepositOrderByPlateNumberLogId{
    return JavaNewUrl(@"depositOrder/addAuctionUserDepositOrderByPlateNumberLogId");
}
/// 办理号牌时去支付选择’线下支付‘是更改支付订单的支付方式
+ (NSString *)updateAuctionUserDepositOrderPayTypeById{
    return JavaNewUrl(@"depositOrder/updateAuctionUserDepositOrderPayTypeById");
}
/// 用户出价
+ (NSString *)addOfferPriceToAuctionGoodsOfCurrentUser{
    return JavaNewUrl(@"auctionGoodsOfferPrice/addOfferPriceToAuctionGoodsOfCurrentUser");
}

/// 获取拍品的下一口价格
+ (NSString *)selectNextOfferPriceByAuctionGoodId:(NSString *)auctionGoodId{
    NSString *url = [NSString stringWithFormat:@"auctionGoodsOfferPrice/selectNextOfferPriceByAuctionGoodId/%@", auctionGoodId];
    return JavaNewUrl(url);
}

/// 获取下20口价
/// @param auctionGoodId 拍品id
+ (NSString *)selectNextOfferPriceListByAuctionGoodId:(NSString *)auctionGoodId{
    NSString *url = [NSString stringWithFormat:@"auctionGoodsOfferPrice/selectNextOfferPriceListByAuctionGoodId/%@", auctionGoodId];
    return JavaNewUrl(url);
}


/// 获取pm专场直播拉流地址
+ (NSString *)getPalyUrlOfAuctionField:(NSString *)auctionFieldId{
    NSString *url = [NSString stringWithFormat:@"auctionField/getPalyUrlOfAuctionField/%@", auctionFieldId];
    return JavaNewUrl(url);
}
/// 查看当前用户号牌详情
+ (NSString *)selectAuctionUserPlateNumberByCurrentUser:(NSString *)auctionFieldId{
    NSString *url = [NSString stringWithFormat:@"plateNumber/selectAuctionUserPlateNumberByCurrentUser/%@", auctionFieldId];
    return JavaNewUrl(url);
}
/// 获取专场正在直播的拍品
+ (NSString *)selectLivingAuctionGoodsIdByAuctionFieldId:(NSString *)auctionFieldId{
    NSString *url = [NSString stringWithFormat:@"auctionGoods/selectLivingAuctionGoodsIdByAuctionFieldId/%@", auctionFieldId];
    return JavaNewUrl(url);
}



+ (NSString *)selectAuctionUserGoodsRecordListOfCurrentUser {
    return JavaNewUrl(@"auctionUserGoodsRecord/selectAuctionUserGoodsRecordListOfCurrentUser");
}

+ (NSString *)selectAuctionUnsettledGoodsListByCurrentUser {
    return JavaNewUrl(@"auctionUnsettledGoods/selectAuctionUnsettledGoodsListByCurrentUser");
}

+ (NSString *)selectAuctionGoodOrderDetailOfAuctionUserById:(NSString *)auctionOrderId {
    NSString *urlStr = [NSString stringWithFormat:@"auctionGoodOrder/selectAuctionGoodOrderDetailOfAuctionUserById/%@",[ToolUtil isEqualToNonNull:auctionOrderId replace:@"0"]];
    return JavaNewUrl(urlStr);
}

+ (NSString *)selectAuctionGoodOrderListByAuctionUseId {
    return JavaNewUrl(@"auctionGoodOrder/selectAuctionGoodOrderListByAuctionUseId");
}

+ (NSString *)selectAuctionUserDepositOrderListOfCurrentUser {
    return JavaNewUrl(@"depositOrder/selectAuctionUserDepositOrderListOfCurrentUser");
}

+ (NSString *)addAuctionGoodOrder {
    return JavaNewUrl(@"auctionGoodOrder/addAuctionGoodOrder");
}

+ (NSString *)confirmReceiptOfAuctionUserByAuctionGoodOrderId:(NSString *)auctionGoodOrderId {
    NSString *urlStr = [NSString stringWithFormat:@"auctionGoodOrder/confirmReceiptOfAuctionUserByAuctionGoodOrderId/%@",[ToolUtil isEqualToNonNull:auctionGoodOrderId replace:@"0"]];
    return JavaNewUrl(urlStr);
}

+ (NSString *)selectDepositOrderStatisticsInfoOfCurrentUser {
    return JavaNewUrl(@"depositOrder/selectDepositOrderStatisticsInfoOfCurrentUser");
}

+ (NSString *)selectAuctionGoodIdByGoodNumberAndFieldId {
    return JavaNewUrl(@"auctionGoods/selectAuctionGoodIdByGoodNumberAndFieldId");
}

#pragma mark - 分享链接
/// 分享课程详情
/// @param courseID 课程id
+ (NSString *)shareCourseDetailURL:(NSString *)courseID{
    NSString *string = [NSString stringWithFormat:@"%@/appShare/courseDetail?courseId=%@",AMSharePrefix , courseID];
    return string;
}


@end

