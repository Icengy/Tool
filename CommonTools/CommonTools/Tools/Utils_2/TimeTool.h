//
//  TimeTool.h
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/10/31.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AMDataFormatter @"yyyy-MM-dd HH:mm:ss"
#define AMDataFormatter2 @"yyyy-MM-dd HH:mm"
#define AMDataFormatter3 @"yyyy年MM月dd日"
#define AMDataFormatter4 @"HH:mm:ss"
#define AMDataFormatter5 @"mm:ss"

NS_ASSUME_NONNULL_BEGIN

@interface TimeTool : NSObject

///当前时间与目标时间戳之间的差值
+ (NSString *)getDifferenceToCurrentSinceTimeStamp:(NSTimeInterval)timeinterval;
+ (NSString *)getTimeFromPassTimeIntervalToNowTimeInterval:(NSTimeInterval)timeinterval;
/// 当前时间与目标时间之间的差值
+ (NSString *)getDifferenceToCurrentSinceDateStr:(NSString *)dateStr;
///当前时间与目标时间戳之间的差值
/// 返回时间戳
+ (double)getDifferenceSinceDateStr:(NSString *)dateStr;

/// 字符串转date
+ (NSDate *)getDateWithDateStr:(NSString *)dateStr;
///时间戳转标准时间字符串
+ (NSString *)getDateStringWithTimeStr:(NSString *)str;

///时间戳转分秒
+ (NSString *)timeFormatted:(double)timeinterval;
///时间戳转时分秒
+ (NSString *)timeFormatted:(double)timeinterval withFormater:(NSString *)formater;

///将时间戳转换为时间字符串
+ (NSString *)timestampToTime:(double)timestamp;
+ (NSString *)timestampToTime:(double)timestamp withFormat:(NSString *)formatStr;
+ (NSString *)timestampForTeaToTime:(double)timestamp;

///计算时间戳距离当前时间的差值
+ (void)compareCurrentDateTimeWithTime:(NSInteger)time block:(void (^)(BOOL isFinish ,NSString *_Nullable compareStr))completeBlock;

/// 评论/回复时间格式
+ (NSString *)disscussTimestampWithTimeStr:(NSString *)timeStr;

/// 计算会客开始时间和服务器时间的差值
/// @param teaStartTime 会客开始时间
/// @param cloudTime 服务器时间
+ (double)getDifferenceSinceDateStr:(NSString *)teaStartTime cloudTime:(NSString *)cloudTime;

/// 计算两个日期之间相差的秒数，time1 - time2
/// @param time1 日期1
/// @param time2 日期2
+ (double)getDifferenceSinceDate:(NSString *)time1 toDate:(NSString *)time2;
/// 获取一个日期字符串的时间戳
/// @param date 日期字符串
+ (double)getTimeSpWithDateString:(NSString *)date;

/// 获取当前时间的详细日期和时分秒
+ (NSString *)getCurrentDateStr;
/// 传入一个时间戳，返回这个时间戳距当前时间的 年、月、日、小时、分钟
//+ (NSString *)getTimeFromPassTimeIntervalToNowTimeInterval:(NSTimeInterval)timeinterval;


/// 获取当前时间的时间戳字符串
+ (NSString *)getCurrentTimestamp;
//从1970年开始到现在经过了多少秒
+ (NSTimeInterval)getCurrentTimeSp:(NSDate *_Nullable)date;

@end

NS_ASSUME_NONNULL_END
