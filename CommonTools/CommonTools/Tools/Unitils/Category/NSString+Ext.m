//
//  NSString+Ext.m
//  DingDingClient
//
//  Created by phoenix on 14-10-10.
//  Copyright (c) 2014年 SEU. All rights reserved.
//

#import "NSString+Ext.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (IdentifierAddition)

+ (BOOL)isBlankString:(NSString *)string{
    BOOL result = NO;
    
    if (NULL == string || [string isEqual:nil] || [string isEqual:Nil])
    {
        result = YES;
    }
    else if ([string isEqual:[NSNull null]])
    {
        result = YES;
    }
    else if (0 == [string length] || 0 == [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length])
    {
        result = YES;
    }
    else if([string isEqualToString:@"(null)"])
    {
        result = YES;
    }
    
    return result;
}

// 普通字符串转换为十六进制
+ (NSString *)hexStringFromString:(NSString *)string
{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i = 0; i < [myD length]; i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x", bytes[i]&0xff];//16进制数
        
        if([newHexStr length]==1)
        {
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        }
        else
        {
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        }
    }
    return hexStr;
}

// 出现类似这样格式的字段"\\U6df1\\U5733\\U56fd\\U5f00\\U884c01\\U673a\\U623",通常为Unicode码,转换函数为
+ (NSString *)replaceUnicode:(NSString *)unicodeStr
{
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

+ (NSString *)getRoundFloat:(double)floatNumber withPrecisionNum:(NSInteger)precision {
    // 0.123456789  精度2
    //core foundation 的当前确切时间
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    //精度要求为2，算出 10的2次方，也就是100，让小数点右移两位，让原始小数扩大100倍
    double fact = pow(10,precision);//face = 100
    //让小数扩大100倍，四舍五入后面的位数，再缩小100倍，这样成功的进行指定精度的四舍五入
    double result = round(fact * floatNumber) / fact; // result = 0.12
    //组合成字符串 @"%.3f"   想要打印百分号%字符串 需要在前面加一个百分号 表示不转译
    NSString *proString = [NSString stringWithFormat:@"%%.%ldf",(long)precision]; //proString = @"%.2f"
    // 默认会显示6位 多余的n补0，所以需要指定显示多少小数位  @"%.2f" 0.123000
    NSString *resultString = [NSString stringWithFormat:proString,result];

    //time实际上是一个double
    CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();

    NSLog(@"time cost: %0.6f", end - start);

    return resultString;

}

+(NSString*)getTheCorrectNum:(NSString*)tempString withPrecisionNum:(NSInteger)precision
{
	//计算截取的长度
	NSUInteger endLength = tempString.length;
	//判断字符串是否包含 .
	if ([tempString containsString:@"."]) {
		//取得 . 的位置
		NSRange pointRange = [tempString rangeOfString:@"."];
		//判断 . 后面有几位
		NSUInteger f = tempString.length - 1 - pointRange.location;
		if (f > precision) {
			endLength = pointRange.location + precision + 1;
		}
	}
	//先将tempString转换成char型数组
	NSUInteger start = 0;
	const char *tempChar = [tempString UTF8String];
	//遍历,去除取得第一位不是0的位置
	for (int i = 0; i < tempString.length; i++) {
		if (tempChar[i] == '0') {
			start++;
		}else {
			break;
		}
	}
	//根据最终的开始位置,计算长度,并截取
	NSRange range = {start,endLength-start};
	tempString = [tempString substringWithRange:range];
	return tempString;
}
@end
