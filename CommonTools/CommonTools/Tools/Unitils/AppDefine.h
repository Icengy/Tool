//
//  AppDefine.h
//  ESTicket
//
//  Created by 鹏 刘 on 15/11/20.
//  Copyright © 2015年 鹏 刘. All rights reserved.
//
//111
#ifndef AppDefine_h
#define AppDefine_h

/*********************WTC********************************/


#define payKey [GTMBase64 stringByEncodingData:[@"NjM0Nzg4Mjg2MjU5" dataUsingEncoding:NSUTF8StringEncoding]]
/************开发环境*********/
#import "AppUrlDefine.h"
/******************************/

#define timeNowStamp [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]*1000]
#define krootFollowOrderUrl [NSString stringWithFormat:@"%@/index.html?_=%@#/",khostFollowOrder,timeNowStamp]


/**************************************/


/****通知****/
#define kESDidLoginNotification           @"ESDidLoginNotification"
#define kESDidLogoutNotification          @"ESDidLogoutNotification"

#define kESTockenDidExpiredNotification   @"ESTockenDidExpiredNotification"
#define kChangeSelfInfoSuccess @"ChangeSelfInfoSuccess"

#define kWechatLoginSuccess  @"kWechatLoginSuccess"

#define kWechatChargeSuccess @"kWechatChargeSuccess"
#define kWechatChargeCancel  @"kWechatChargeCancel"
#define kAlipayChargeSuccess @"kAlipayChargeSuccess"
#define kAlipayChargeCancel  @"kAlipayChargeCancel"



#define kFinshRead @"FinshRead"
#define kBuyPlanSuccess @"BuyPlanSuccess"
#define kMatchFoucesStateChange @"MatchFoucesStateChange"
#define kMatchScreenChange @"MatchScreenChange"
#define kFllowMatchCountChange @"FllowMatchCountChange"
#define kFllowBasketMatchCountChange @"FllowBasketMatchCountChange"

#define kSelectMatchMessageNotification @"SelectMatchMessageNotification"


#define kSearchClick @"SearchClick"

#define kADLunchFinish @"ADLunchFinish"
/****TCP消息通知****/
#define kGlobalMatchUpdateTCPMessage    @"GlobalMatchUpdateTCPMessage"
#define kExponentailChangeTCPMessage    @"kExponentailChangeTCPMessage"
#define kMatchImportantEventTCPMessage  @"MatchImportantEventTCPMessage"
#define kMatchLiveTCPMessage            @"MatchLiveTCPMessage"
#define kMatchInitTCPMessage            @"MatchInitTCPMessage"
#define kMatchUpdateTCPMessage          @"MatchUpdateTCPMessage"
#define kMatchTechnologyChangeMessage   @"MatchTechnologyChangeMessage"
#define kMatchUpdateALLImportantEventMessage @"MatchUpdateALLImportantEventMessage"
#define kGlobalMatchBaskectTCPMessage	@"GlobalMatchBaskectTCPMessage"
#define kGlobalBasketLiveTCPMessage @"GlobalBasketLiveTCPMessage"

//聊天
#define kChatTCPInitModel               @"ChatTCPInitModel"
#define kChatTCPMessageModel            @"ChatTCPMessageModel"
#define kChatTCPResponseModel           @"ChatTCPResponseModel"

//社区
#define kRefreshComunityMessageCount             @"kRefreshComunityMessageCount"

//文章评论
#define kReplyCommitSuccess             @"kReplyCommitSuccess"

//商城
#define kCancelShopOrderSuccess			@"kCancelShopOrderSuccess"
#define kAddressModifySuccess			@"kAddressModifySuccess"
#define kAddressDeleteSuccess			@"kAddressDeleteSuccess"

/****NSUserDefault本地化***/
#define kIOSState @"iosState"
#define kDeviceTokenUmeng @"deviceTokenU"
#define ksearchHistroy @"searchHistroy"
#define ksearchHistroyCommunity @"searchHistroyCommunity"
#define kdataSearchHistory @"dataSearchHistory"
#define kDidEnterChatRoomBefore @"didEnterChatRoomBefore"
#define kSocketGoalCache @"SocketGoalCache"

#define kUnfinishedTradeArr @"UnfinishedTradeArr"

#define kFootBallScreenCache @"FootBallScreenCache"
#define kBasketScreenCache @"BasketScreenCache"
#define kLastHomePageIsBasket @"LastHomePageIsBasket"
#define kUploadedPhotoCache @"UploadedPhotoCache"
#define kUploadedVideoCache @"UploadedVideoCache"
#define kEventTopicName @"EventTopicName"
#define kEventTopicId @"EventTopicId"





#define NavBarHeight (kScreen_Height >= 812.0 ? 88 : 64)
#define kTabBarHeight  ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define IphoneBarHeight (kScreen_Height >= 812.0 ? 44 : 20)
#define kBottomSafeArea ([[UIApplication sharedApplication] statusBarFrame].size.height>20?34:0)
#define kNavBarHeight  44.0

#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
//
#define DebugLog(s, ...) NSLog(@"%s(%d): %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
//#define NSLog(...)
#define WTCLog(FORMAT,...) fprintf(stderr,"\n %s:%d   %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

//相对于5s的宽高比例缩放基数
#define k5sVersusWidth [UIScreen mainScreen].bounds.size.width/320
#define k5sVersusHight [UIScreen mainScreen].bounds.size.height/568
//相对于6s的宽高等比例缩放基数
#define k6sVersusWidth [UIScreen mainScreen].bounds.size.width/375
#define k6sVersusHight [UIScreen mainScreen].bounds.size.height/667
#define Adapt(x)                     (SCREEN_WIDTH/375.0) * x
//相对于6splus的宽高等比例缩放基数
#define k6splusVersusWidth [UIScreen mainScreen].bounds.size.width/414
#define k6splusVersusHight [UIScreen mainScreen].bounds.size.height/736



#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define IS_PAD (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)





// 状态码
#define kNetWorkCode         @"code"
// 数据实体
#define kNetWorkDataBody     @"data"
// 列表实体
#define kNetWorkList         @"list"
// 错误信息
#define kNetWorErrorMsg      @"message"
// 错误域


// 判断对象是否为空
// 字符串
#define QM_IS_STR_NIL(objStr) (![objStr isKindOfClass:[NSString class]] || objStr == nil || [objStr length] <= 0)
#define QM_STR_NOT_NIL(__x) (QM_IS_STR_NIL(__x)) ? @"" : __x
// 字典
#define QM_IS_DICT_NIL(objDict) (![objDict isKindOfClass:[NSDictionary class]] || objDict == nil || [objDict count] <= 0)
// 数组
#define QM_IS_ARRAY_NIL(objArray) (![objArray isKindOfClass:[NSArray class]] || objArray == nil || [objArray count] <= 0)
// float
#define QM_IS_FLOAT_NIL(objFloat) (objFloat == nil)
// 判断delegate是否响应某个selector
#define QM_IS_DELEGATE_RSP_SEL(iDel, iSel) (iDel != nil && [iDel respondsToSelector:@selector(iSel)])


//手机序列号
#define kidentifierNumber  [[UIDevice currentDevice].identifierForVendor UUIDString] ;
//手机别名： 用户定义的名称
#define kuserPhoneName  [[UIDevice currentDevice] name];

//设备名称
#define kdeviceName  [[UIDevice currentDevice] systemName];

//手机系统版本
#define kphoneVersion  [[UIDevice currentDevice] systemVersion];

//手机型号
#define kphoneModel  [[UIDevice currentDevice] model];

//地方型号  （国际化区域名称）
#define klocalPhoneModel  [[UIDevice currentDevice] localizedModel];

// 当前应用名称
#define kappCurName  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];

//当前应用包名
#define kappBundleName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];

// 当前应用软件版本  比如：1.0.1
#define kappCurVersion  [infoDictionary objectForKey:@"CFBundleShortVersionString"];

// 当前应用版本号码   int类型
#define kappCurVersionNum  [infoDictionary objectForKey:@"CFBundleVersion"];

/*************************wtc**************************/



//AppDelegate
#define APP_DELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)

// 应用程序的名字
#define APP_NAME [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]

// 应用程序版本号
#define APP_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]

// 沙盒Document路径
#define AppDocumentPath  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define ITUNES_APP_KEY 1483005690

//获得存放数据库文件的沙盒地址
#define kDbFilePath [AppDocumentPath stringByAppendingPathComponent:@"/shopkeeper.sqlite"]

#define ScoreURL(id) [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/guang-dian-bi-zhi/id%d?mt=8",id] //app store 评分


#ifdef DEBUG
//开发环境
#else
//生产环境
#endif


/**
 * 图片
 * 文字大小
 * 颜色
 */
#define GetImage(imageName) [UIImage imageNamed:imageName]

//***老版UI字体宏
#define GetFont(x) [UIFont systemFontOfSize:(x+2)]
#define GetBoldFont(x) [UIFont boldSystemFontOfSize:(x+2)]
//**新版UI字体宏
#define fcFont(x) [UIFont systemFontOfSize:x]
#define fcBoldFont(x) [UIFont boldSystemFontOfSize:x]

//*** DINCondensed-Bold 使用自定义字体
#define kCustomFont(x) [UIFont fontWithName:@"DINCondensed-Bold" size:x]
//
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGBCOLORV(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]
#define RGBCOLORVA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

#define IsIphone5 (SCREEN_HEIGHT == 568) ? YES:NO
#define IsIphone6 (SCREEN_HEIGHT == 667) ? YES:NO
#define IsIphone6Plus (SCREEN_HEIGHT == 736) ? YES:NO
#define IsIphoneX (SCREEN_HEIGHT >= 812.0) ? YES:NO

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define SCREEN_ORIGINY ([[UIApplication sharedApplication] statusBarFrame].size.height + 44.0f)
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define kScreenRate ([UIScreen mainScreen].bounds.size.width / 320.0)
#define kFontRate ((SCREEN_WIDTH == 320) ? 1 : kScreenRate*0.9)
#define kCustomAlertViewWidth  270.0/320*SCREEN_WIDTH

#define SCREEN_LeftOffSet 10
#define SCREEN_RightOffSet 10


#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define SM_TEXTSIZE(text, font) [text length] > 0 ? [text \
sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero;
#else
#define SM_TEXTSIZE(text, font) [text length] > 0 ? [text sizeWithFont:font] : CGSizeZero;
#endif

// 汉字范围
#define MIN_CODE 0x4E00
#define MAX_CODE 0x9FA5

/**
 *  成功后的block
 *
 *  @param dict 返回的成功数据
 */
typedef void (^SuccessBlock)(id obj);

/**
 *  失败后的block
 */
typedef void (^FailBlock)(id obj);


typedef enum : NSUInteger {
    kESContentType_BankRecharge = 1,//银行卡充值(汇付宝)
    kESContentType_BankRecharge_UPAY_ALI,
    kESContentType_BankRecharge_YB, //银行卡充值（易宝）
    kESContentType_DuoBao,          //一块夺宝
    kESContentType_CustomNav,       //显示自定义的navigationView
    kESContentType_bfzb             //比分直播
    
} ESContentType;


#endif /* AppDefine_h */
