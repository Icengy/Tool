//
//  CMMUtility.h
//  JUXIU_iOS
//
//  Created by Homosum on 16/7/20.
//  Copyright © 2016年 JuXiuSheQu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMMUtility : NSObject
+(void)showNote:(NSString *)content;

+ (void)showNoteWithError:(NSError *)error;

+ (void)showNoteMsgWithError:(NSError *)error;
//can't response Wait
+(void)unuseWait;
//postWait
+(void)postWait;
// show temp login view
+(void)hodgeWait;
+(void)showTMPLogin;
+(void)showToastWithText:(NSString*)msg;
+(void)showToastWithText:(NSString*)msg duration:(CGFloat)second;
// show alert view with delegate and alert String
+(void)showAlertWith:(NSString *)alertStr target:(id)target tag:(int)tag;

+(void)showSucessWith:(NSString*)str;

// show network Indicator
+(void)showWaitingAlertView;

// hide network Indicator
+(void)hideWaitingAlertView;
+(void)showFailureWith:(NSString*)str;
//image转data
+(NSData*)imageConvertToData:(UIImage*)image;

//保存image到本地沙盒
+(void)saveImage:(UIImage*)image andName:(NSString*)imageName;

//从沙盒中取image
+(UIImage*)fetchImageWithName:(NSString*)imageName;
//时间戳转时间
+(NSString *)timeStringFromTimestamp:(NSString *)timestamp;
/**
 * 时间比较 yes:未过期 no:已过期
 **/
+(BOOL)timeCompareWithNow:(NSString*)timestamp;

/**
 * 时间转换
 * timeFormat @"yyyy-MM-dd HH:mm:ss"
 **/
+(NSString*)timeConvertWithTimeStamp:(NSString *)timestamp andTimeFormat:(NSString*)timeFormat;
/**
 * 时间转时间戳
 * timeFormat @"yyyy-MM-dd HH:mm:ss"
 **/

+(NSString*)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)timeFormat;
/**
 * 数字变色处理
 */
+(void)changeNumsLabel:(UILabel*)label withColor:(UIColor*)color;
+(NSString*)getCurrentTimes;
/**
 *  获取时间差值  截止时间-当前时间
 *  nowDateStr : 当前时间
 *  deadlineStr : 截止时间
 *  @return 时间戳差值
 */
+ (NSInteger)getDateDifferenceWithNowDateStr:(NSString*)nowDateStr deadlineStr:(NSString*)deadlineStr;
/**
*  获取时间距离当前时间天数
 *  时间格式:yyyy-MM-dd
*/
+ (NSInteger)getDayDifferenceWithStr:(NSString *)timeStr;

+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image;

+(UIImage*)qr_codeToImageWithSize:(CGFloat)size andUrlStr:(NSString*)urlstr;

//
+(CGRect)vvs6SBoundsWithX:(CGFloat)x Y:(CGFloat)y Width:(CGFloat)width Height:(CGFloat)height;
+(CGFloat)vvs6SWidth:(CGFloat)width;
+(CGFloat)vvs6SHight:(CGFloat)hight;
+(NSDictionary *)dictionaryWithUrlString:(NSString *)urlStr;

@end
