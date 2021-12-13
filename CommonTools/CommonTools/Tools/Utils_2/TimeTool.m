//
//  TimeTool.m
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/10/31.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import "TimeTool.h"

#import <BRPickerView/BRDatePickerView.h>
#import <BRPickerView/BRDatePickerView+BR.h>

@implementation TimeTool

/// 当前时间戳与目标时间之间的差值
+ (NSString *)getDifferenceToCurrentSinceTimeStamp:(NSTimeInterval)timeinterval {
    if (timeinterval == 0) return @"";
    NSInteger value = [self getCurrentTimeSp:nil] - timeinterval;
	
	if (value / 60 == 0) {
		return [NSString stringWithFormat:@"%02ld秒", value];
	}else if (value / (60*60) == 0) {
		return [NSString stringWithFormat:@"%02ld分钟", value/60];
	}else if (value / (60*60*24) == 0) {
		return [NSString stringWithFormat:@"%ld小时", value/(60*60)];
    }else if (value / (60 *60 *24 *30) == 0) {
		return [NSString stringWithFormat:@"%ld天", value/(60*60*24)];
    }else if (value / (60 *60 *24 *30 *12) == 0) {
        return [NSString stringWithFormat:@"%ld个月", value/(60*60*24*30)];
    }else
        return [NSString stringWithFormat:@"%ld年", value/(60*60*24*30*12)];
}



/// 传入一个时间戳，返回这个时间戳距当前时间的 年、月、日、小时、分钟
+ (NSString *)getTimeFromPassTimeIntervalToNowTimeInterval:(NSTimeInterval)timeinterval {
    if (timeinterval == 0) return @"";
    NSInteger value = [self getCurrentTimeSp:nil] - timeinterval;
    
    if (value / 60 == 0) {
        return [NSString stringWithFormat:@"%ld秒", value];
    }else if (value / (60*60) == 0) {
        return [NSString stringWithFormat:@"%ld分钟", value/60];
    }else if (value / (60*60*24) == 0) {
        return [NSString stringWithFormat:@"%ld小时", value/(60*60)];
    }else if (value / (60 *60 *24 *30) == 0) {
        return [NSString stringWithFormat:@"%ld天", value/(60*60*24)];
    }else if (value / (60 *60 *24 *30 *12) == 0) {
        return [NSString stringWithFormat:@"%ld个月", value/(60*60*24*30)];
    }else
        return [NSString stringWithFormat:@"%ld年", value/(60*60*24*30*12)];
}


/// 当前时间与目标时间之间的差值
+ (NSString *)getDifferenceToCurrentSinceDateStr:(NSString *)dateStr {
    if (![ToolUtil isEqualToNonNull:dateStr])  return 0;
    // 截止时间data格式
    NSDate *expireDate = [TimeTool getDateWithDateStr:dateStr];
    return [self getDifferenceToCurrentSinceTimeStamp:[expireDate timeIntervalSince1970]];
}

/// value > 0 dateStr在当前时间之前 < 0 dateStr在当前时间之后
+ (double)getDifferenceSinceDateStr:(NSString *)dateStr {
    if (![ToolUtil isEqualToNonNull:dateStr])  return 0;
    double value = [self getCurrentTimeSp:[self getDateWithDateStr:dateStr]] - [self getCurrentTimeSp:nil];
    return value;
}


/// 计算会客开始时间和服务器时间的差值
/// @param teaStartTime 会客开始时间
/// @param cloudTime 服务器时间
+ (double)getDifferenceSinceDateStr:(NSString *)teaStartTime cloudTime:(NSString *)cloudTime{
    if (![ToolUtil isEqualToNonNull:teaStartTime])  return 0;
    NSDate *targetDate = [self getDateWithDateStr:teaStartTime];
    NSDate *cloundDate = [self getDateWithDateStr:cloudTime];
    double value = [self getCurrentTimeSp:targetDate] - [self getCurrentTimeSp:cloundDate];
    
    return value;
}

/// 计算两个日期之间相差的秒数，time1 - time2
/// @param time1 日期1
/// @param time2 日期2
+ (double)getDifferenceSinceDate:(NSString *)time1 toDate:(NSString *)time2{
    if (![ToolUtil isEqualToNonNull:time1])  return 0;
    NSDate *targetDate = [self getDateWithDateStr:time1];
    NSDate *cloundDate = [self getDateWithDateStr:time2];
    double value = [self getCurrentTimeSp:targetDate] - [self getCurrentTimeSp:cloundDate];
    return value;
}

/// 获取一个日期字符串的时间戳
/// @param date 日期字符串
+ (double)getTimeSpWithDateString:(NSString *)date {
    if (![ToolUtil isEqualToNonNull:date])  return 0;
    NSDate *targetDate = [self getDateWithDateStr:date];
    double value = [self getCurrentTimeSp:targetDate];
    return value;
}

/// 字符串转date
+ (NSDate *)getDateWithDateStr:(NSString *)dateStr {
    if (![ToolUtil isEqualToNonNull:dateStr])  return [NSDate date];
    
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    NSTimeZone* timeZone = [NSTimeZone systemTimeZone];
    [dateFomatter setTimeZone:timeZone];
    
    dateFomatter.dateFormat = AMDataFormatter;
    return [dateFomatter dateFromString:dateStr];
}

+ (NSString *)timeFormatted:(double)timeinterval {
    return [self timeFormatted:timeinterval withFormater:AMDataFormatter5];
}

+ (NSString *)timeFormatted:(double)timeinterval withFormater:(NSString *)formater {
    if ([formater isEqualToString:AMDataFormatter4]) {
        int seconds = (int)timeinterval % 60;
        int minutes = ((int)timeinterval / 60) % 60;
        int hours = ((int)timeinterval / 3600) % 60;
        return [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
    }
	int seconds = (int)timeinterval % 60;
	int minutes = ((int)timeinterval / 60) % 60;
	return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}

//从1970年开始到现在经过了多少秒
+ (NSTimeInterval)getCurrentTimeSp:(NSDate *)date {
    if (!date) date = [NSDate date];
	return (NSTimeInterval)[date timeIntervalSince1970];
}

// 时间戳转时间,时间戳为13位是精确到毫秒的，10位精确到秒
+ (NSString *)getDateStringWithTimeStr:(NSString *)str {
	NSTimeInterval time = [[ToolUtil isEqualToNonNull:str replace:@"0"] doubleValue];//传入的时间戳str如果是精确到毫秒的记得要/1000
	NSDate *detailDate = [NSDate dateWithTimeIntervalSince1970:time];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
	//设定时间格式,这里可以设置成自己需要的格式
	[dateFormatter setDateFormat:AMDataFormatter];
	NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
	return currentDateStr;
}

//+ (NSString *)timeAllFormatted:(NSString *)timeinterval {
//	NSString *timeStr = [[self dateFormatWith:@"YYYY-MM-dd HH:mm:ss"] stringFromDate:date];
//	return timeStr;
//}

//获取日期格式化器
+ (NSDateFormatter *)dateFormatWith:(NSString *)formatStr {
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateStyle:NSDateFormatterMediumStyle];
	[formatter setTimeStyle:NSDateFormatterShortStyle];
	[formatter setDateFormat:formatStr];
	//设置时区
	NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
	[formatter setTimeZone:timeZone];
	
	return formatter;
}

//将时间戳转换为标准格式时间字符串
+ (NSString *)timestampToTime:(double)timestamp {
	return [self timestampToTime:timestamp withFormat:AMDataFormatter4];
}

//将时间戳转换为时间字符串
+ (NSString *)timestampToTime:(double)timestamp withFormat:(NSString *)formatStr {
//    NSLog(@"timestamp = %@",@(timestamp));
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *timeStr = [[self dateFormatWith:formatStr] stringFromDate:date];
    
    return timeStr;
}

//将时间戳转换为时间字符串
+ (NSString *)timestampForTeaToTime:(double)timestamp {
//    NSLog(@"timestamp = %@",@(timestamp));
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:AMDataFormatter];//@"YYYY-MM-dd HH:mm:ss"
    //设置时区
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSString *timeStr = [formatter stringFromDate:date];
    
    return timeStr;
}

///计算时间戳距离当前时间的差值
+ (void)compareCurrentDateTimeWithTime:(NSInteger)time block:(void (^)(BOOL isFinish ,NSString *_Nullable compareStr))completeBlock {
    NSInteger timeA = [self getCurrentTimeSp:nil];
	if (completeBlock) {
		if (labs(timeA - time) < 15*60) {
			completeBlock(YES ,[self compareTwoTime:timeA otherTime:time]);
		}else
			completeBlock(NO ,nil);
	}
}

///计算两个时间戳之间的差值
+ (NSString *)compareTwoTime:(NSInteger)time otherTime:(NSInteger)otherTime {
	double value = 15*60 - labs(otherTime -time);
	return [NSString stringWithFormat:@"00:%@",[self timeFormatted:value]];
}

+ (NSString *)disscussTimestampWithTimeStr:(NSString *)timeStr {
    if (![ToolUtil isEqualToNonNull:timeStr]) return @"";
    
    NSTimeInterval time = [timeStr doubleValue];
    NSTimeInterval currentTime = [self getCurrentTimeSp:nil];
    ///@"yyyy-MM-dd HH:mm:ss"
    BOOL isSameDay = [self isSameDay:time withTime:currentTime];
    time += (8 *60 *60);
    if (isSameDay) /// 是同一天
        return [self timestampToTime:time  withFormat:@"HH:mm"];
    return [self timestampToTime:time withFormat:@"MM月dd日"];
}

+ (BOOL)isSameDay:(NSTimeInterval)time withTime:(NSTimeInterval)time2 {
    //传入时间毫秒数
    NSDate *pDate1 = [NSDate dateWithTimeIntervalSince1970:time];
    NSDate *pDate2 = [NSDate dateWithTimeIntervalSince1970:time2];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:pDate1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:pDate2];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}


+ (NSString *)getCurrentDateStr{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    // [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss SS"];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}

+ (NSString *)getCurrentTimestamp {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0]; // 获取当前时间0秒后的时间
    NSTimeInterval time = [date timeIntervalSince1970];// *1000 是精确到毫秒(13位),不乘就是精确到秒(10位)
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}


@end
