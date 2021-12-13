//
//  NetworkMacro.h
//  ArtMedia
//
//  Created by 美术传媒 on 2018/10/8.
//  Copyright © 2018年 lcy. All rights reserved.
//

#ifndef NetworkMacro_h
#define NetworkMacro_h

#import "ApiUtil.h"
#import "URLHost.h"

#define showNetworkError @"请求数据失败"

#define MaxListCount  10


#define AMTXLiveLicenceURL  @"http://license.vod2.myqcloud.com/license/v1/0796daeb6a3b9c13874baf3aec01ad2b/TXLiveSDK.licence"
#define AMLicenceURL        @"http://license.vod2.myqcloud.com/license/v1/0796daeb6a3b9c13874baf3aec01ad2b/TXUgcSDK.licence"
#define AMLicenceKey        @"c123237b2602b42ea5f43857f1d10486"


#define UMengAppKey @"5f699ccda4ae0a7f7d0a3de9"

#define AMWeChatAppID @"wxc3a93cd0e5533610"
#define AMWeChatAppSecret @"93d0a696015a87770076c3db58cd648b"

#define AMAlipayAppID @"wxc3a93cd0e5533610"
#define AMAlipayAppSecret @"93d0a696015a87770076c3db58cd648b"

#define GTAppId  @"bRXgJVBBO57JTVxL4TFY39"
#define GTAppKey  @"NkXK1oEk889jgGJ9AQVa79"
#define GTAppSecret  @"IYia3DMpTKACyipUveMPQ9"

#define WXPaymentResultForNormal @"WXPaymentResultForNormalNotification"
#define WXPaymentResultForOrderDetail @"WXPaymentResultForOrderDetail"
#define WXPaymentResultForOrderList @"WXPaymentResultForOrderList"

#define WXShareResult @"WXShareResultNotification"

#define WXAuthResult @"WeChatAuthNotification"

#define AliPaymentResultForNormal @"AliPaymentResultForNormalNotification"

#define ReloadDataAfterDelete @"ReloadDataAfterDeleteNotification"

#define isFirstLaunchDefaults  @"isFirstLaunchUserDefaults"

#define AMUserMsg   @"_user_msg"
#define AMPhoneDefaults @"_PHONE_NUM"

#define AMPhoneUpdatesDefaults @"_PHONE_Unforce_Update"
#define AMHomeUpdatesDefaults @"_LIST_Home_Update"

#define AMLoginSuccess @"AMLoginSuccess"


#endif /* NetworkMacro_h */
