//
//  NSString+Ext.h
//  DingDingClient
//
//  Created by phoenix on 14-10-10.
//  Copyright (c) 2014年 SEU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (IdentifierAddition)

// 判断是否是空字串
+ (BOOL)isBlankString:(NSString*)string;

// 普通字符串转换为十六进制
+ (NSString*)hexStringFromString:(NSString*)string;

// 出现类似这样格式的字段"\\U6df1\\U5733\\U56fd\\U5f00\\U884c01\\U673a\\U623",通常为Unicode码,转换函数为
+ (NSString*)replaceUnicode:(NSString*)unicodeStr;

/**
 基础计算 截取指定小数位数 时间耗时较少
 */
+ (NSString *)getRoundFloat:(double)floatNumber withPrecisionNum:(NSInteger)precision;

/**
 基础计算 截取指定小数位数(不四舍五入)
 */
+(NSString*)getTheCorrectNum:(NSString*)tempString withPrecisionNum:(NSInteger)precision;
@end
