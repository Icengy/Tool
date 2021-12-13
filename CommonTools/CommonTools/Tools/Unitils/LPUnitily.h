//
//  LPUnitily.h
//  IntegralManage
//
//  Created by tbow-app-02 on 12-6-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import <YWFeedbackFMWK/YWFeedbackKit.h>
#import <YWFeedbackFMWK/YWFeedbackViewController.h>

#define ES_LPUnitily [LPUnitily sharedManager]

@interface LPUnitily : NSObject
//阿里云反馈
@property (nonatomic, strong) YWFeedbackKit *feedbackKit;

+ (LPUnitily *)sharedManager;

//判断是否有网络
+(BOOL)haveNetwork;
/**
 对字符串进行URL解码
 @param string  要进行解码的字符串
 @return    解码后的字符串
 */
+ (NSString *)decodeString:(NSString *)string;
/**
 对字符串进行URL编码
 @param string  要进行编码的字符串
 @return    编码后的字符串
 */
+ (NSString *)encodeString:(NSString *)string;
/**
 将字符串进行MD5加密
 @param source  要进行MD5的源
 @return    加密后的字符串
 */
+ (NSString *)stringWithMD5:(NSString *)source;
//返回小写的加密后的字符串
+ (NSString *)lowercaseStringWithMD5:(NSString *)source;
/**
 将NSData进行MD5加密
 @param data  要进行MD5的源
 @return    加密后的NSData
 */
+ (NSData *)md5Data:(NSData *)data;
/**
 将字符串转换为16进制形式
 @param str 待转换的字符串
 @return    转换后的16进制字符串
 */
//+ (NSString *)stringToHex:(NSString *)str;
/**
 将字符串进行MD5返回大写形式
 @param source  待加密源
 @return    加密后大写字符串
 @
 */
//+ (NSString *)UpperCaseStringWithMD5:(NSString *)source;
/**
 字符串格式日期转换成NSDate
 @param httpDate    字符串格式日期
 @param NSDate对象
 */
+ (NSDate *)stringToDate:(NSString *)httpDate;
/**
 日期对象转换为字符串
 @param date 日期对象
 @return 日期字符串格式
 */
+ (NSString *)dateToString:(NSDate *)date;

/**
 *timeType @"yyyy-MM-dd HH:mm:ss" http日期字符串格式
 */
+ (NSString *)dateToString:(NSDate *)date type:(NSString *)timeType;
+ (NSDate *)stringToDate:(NSString *)dateString type:(NSString *)timeType;

/**
根据生日取年龄
 */
+ (NSString *)getNLWithBirthdayDate:(NSDate *)birthday;
+ (NSString *)getNLWithBirthdayString:(NSString *)birthdayString;
/**
 得到日期的星期
 @param date    日期对象
 @return 星期的字符串表示
 */
+ (NSString *)circumferencedayofDate:(NSDate *)date;
+ (NSString *)weekdayofDate:(NSDate *)date;
/**
 返回带有星期的日期字符串
 @param date    日期对象
 @return    带有星期的日期字符串
 */
+ (NSString *)dateWithWeekDay:(NSDate *)date;

//将时间戳转换成NSDate
+(NSDate *)changeSpToTime:(NSString*)spString;

//将yyyy-MM-dd HH:mm:ss格式时间转换成时间戳
+(long)changeTimeToTimeSp:(NSString *)timeStr;

//获取当前系统的时间戳
+(long)getTimeSp;
/**
 获取系统版本
 @return    系统版本
 */
+ (float)iosVersion;

/**
 获取应用程序代理
 */
+ (AppDelegate *)getAppDelegate;

+ (void)setBorderByView:(UIView *)view;
+ (void)setRoundBorderByView:(UIView *)view;
//+ (NSString *)md5Digest:(NSString *)str;
// 正则判断手机号码地址格式
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
//正则判断邮箱格式
+ (BOOL)isEmailNumber:(NSString *)emailNumber;
//正则判断区号
+ (BOOL)isAreaNumber:(NSString *)arealNumber;
//正则判断数字
+ (BOOL)isNumber:(NSString *)number;
//正整数+0
+ (BOOL)isCountNumber:(NSString *)number;
//正浮点数
+ (BOOL)isZFloatNumber:(NSString *)number;
//正则判断邮编
+ (BOOL)isZipCode:(NSString *)zipCode;
//正则判断固话号
+ (BOOL)isPhoneNumber:(NSString *)number;
//验证首字母不能为数字 用户名不能以数字开头
+ (BOOL)validateNumber:(NSString*)number;
//密码不能使用数字、字母以外的字符
+ (BOOL)validatePassWord:(NSString *)passWord;
//判断输入是否合法（个性签名，组织姓名，组织名称）
+ (BOOL)isInputLegal:(NSString *)string;
// double到int，四舍五入
+ (int)covertDoubleToInt:(double)value;
/** 是否是金钱*/
+ (BOOL)isMoney:(NSString *)money;

//获取文本填充的高度 maxHeight=MAXFLOAT 的时候说明没有行数限制
+ (CGSize)getSize:(NSString *)content font:(UIFont *)font width:(CGFloat)aWidth maxHeight:(CGFloat)maxHeight;

/*给图片加圆角*/
+ (void)addCornerToView:(UIView *)view withRadius:(CGFloat)radius;
/*给图片加单边圆角*/
+ (void)addSingleCornerToView:(UIView *)view withRadius:(CGFloat)radius withUIRectCorner:(UIRectCorner)corner;
/*正方形图片变成圆形*/
+ (void)addCircularToView:(UIView *)view;

/*tableview滚动到最上方*/
+ (void)tableViewScrollToTop:(UITableView *)tableView;

/* 提醒 */
+ (void)alertNoNetWork;
+ (void)alertHttpTimeOut;
+ (void)alertMessage:(NSString *)message;
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message;

+ (UIWindow *)keyWindow;

+ (NSData *)resizeImage:(UIImage *)image;

+ (NSTimeInterval)getCurTick;

/**
 *  根据文本内容和字体求文本总宽度
 *
 *  @param string 传入的文本内容
 *  @param font   传入的字体大小
 *
 *  @return CGFloat
 */
+ (CGFloat)getWidthFromString:(NSString *)string font:(CGFloat)font;

/**
 *  根据文本的固定宽度 文本大小及内容求文本所占的高度
 *
 *  @param string 传入的文本内容
 *  @param font   传入的字体大小
 *  @param width  传入的固定宽度
 *
 *  @return CGFloat
 */
+ (CGFloat)getHeightFromString:(NSString *)string font:(UIFont*)font width:(CGFloat)width;

/**
 *  根据文本的固定宽度 文本大小及内容求文本所占的高度
 *
 *  @param string 传入的文本内容
 *  @param font   传入的字体大小
 *  @param width  传入的固定宽度
 *  @param speace  行间距
 *  @return CGFloat
 */
+ (CGFloat)getHeightFromString:(NSString *)string font:(UIFont*)font width:(CGFloat)width andSpeace:(CGFloat)speace;

//排列算法
+ (NSInteger)getPailieCountWithNum:(NSInteger)Num subNum:(NSInteger)subNum;
//排列组合算法
+ (NSInteger)getCountWithNum:(NSInteger)Num subNum:(NSInteger)subNum;

//**求一个数的阶乘
+ (NSInteger)cheng:(NSInteger )num;

//设置label行间距
+ (void)setLineplaceWithLabel:(UILabel *)label lineSpacing:(NSInteger)lineSpacing;
/** 获取ip地址*/
+ (NSString *)deviceIPAdress;

+ (NSString *)getIpAddresses;
//将View生成图片
+(UIImage*)createImageFromView:(UIView*)view;


/**
 *  修改给定的字符串数组中的字符串的颜色
 *
 *  @param label                       传入的label
 *  @param textArray                   需要变色的字符串数组
 *  @param font                        修改后的字体
 *  @param color                       修改后的颜色
 */
+ (void)setSubStringWithLabel:(UILabel *)label textArray:(NSArray *)textArray font:(UIFont *)font color:(UIColor *)color;

/**
 *  修改给定文字之间的文本的颜色（不包括给定文字）
 *
 *  @param becomeStr 开始之前的文本
 *  @param endStr    结束之后的文本
 *  @param label     传入的label
 *  @param color     传入的颜色
 */
+ (void)setSubStrColorWithBecomeStr:(NSString *)becomeStr endStr:(NSString *)endStr label:(UILabel *)label color:(UIColor *)color;

/**
 *  修改给定文字之后的文本的颜色
 *
 *  @param becomeStr 开始之前的文本
 *  @param label     传入的label
 *  @param color     传入的颜色
 *  @param font      传入的字体大小
 */
+ (void)setSubStrColorFromBecomeStr:(NSString *)becomeStr label:(UILabel *)label color:(UIColor *)color font:(UIFont *)font;
/**包含开始字符*/
+ (void)setSubStrColorWithFromBecomeStr:(NSString *)becomeStr label:(UILabel *)label color:(UIColor *)color font:(UIFont *)font;
/**
 *  修改给定文字之间的文本的颜色（包括给定文字）
 *
 *  @param fromStr 开始之前的文本
 *  @param endStr    结束之后的文本
 *  @param label     传入的label
 *  @param color     颜色
 *  @param font      字体大小
 */
+ (void)setSubStrColorWithFromStr:(NSString *)fromStr endStr:(NSString *)endStr label:(UILabel *)label color:(UIColor *)color font:(UIFont *)font;

/**
 *  奖金优化动画
 */
+ (void)addAnimationWithButton:(UIButton *)button;

+ (UIViewController *)currentViewController;
+ (UIViewController *)activityViewController;

/** 将图片放正*/
+ (UIImage *)rotateImage:(UIImage *)aImage;

/* 填加和移除HUD到系统window */
- (void)addHUDToSystemWindowWithString:(NSString *)string;
- (void)removeHUDToSystemWindow;

/* 填加和移除HUD到当前view */
- (void)addHUDToCurrentViewWithString:(NSString *)string;
- (void)removeHUDToCurrentView;

- (void)showToastInView:(UIView *)superView withText:(NSString *)text;
/* KeyWindow添加toast */
- (void)showToastWithText:(NSString *)text;
/* KeyWindow添加toast (带时间)*/
- (void)showToastWithText:(NSString *)text duration:(CGFloat)second;
/* 显示进球通知view */
-(void)showGotScoreViewWithModel:(id)model;


@end

