//
//  MD5Tool.h
//  BoYi_WangYi
//
//  Created by 美术传媒 on 2017/7/17.
//  Copyright © 2017年 李星星. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD5Tool : NSObject

/**
 *  MD5加密, 32位 小写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForLower32Bate:(NSString *)str;

/**
 *  MD5加密, 32位 大写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForUpper32Bate:(NSString *)str;

/**
 *  MD5加密, 16位 小写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForLower16Bate:(NSString *)str;

/**
 *  MD5加密, 16位 大写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForUpper16Bate:(NSString *)str;

+(NSString *)md5WithString:(NSString*)str;

//将时间戳前后拼接字符，前面是YSRMT，后面是2020，例如：YSRMT16080151252020，然后将拼接后的字符md5加密，得到的就是sign
+(NSString *)signMd5:(NSString *)str;

@end
