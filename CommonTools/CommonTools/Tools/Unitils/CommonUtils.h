//
//  CommonUtils.h
//  DingDingCore
//
//  Created by phoenix on 14-10-10.
//  Copyright (c) 2014年 SEU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtils : NSObject

// 判断是否为空串
+ (BOOL)isNull:(id)object;

// 检查返回的字符串是否是"<null>"(return 字符串本身或者""(注意不是nil,是空,字符串里面的货是空))
+ (id)checkNull:(id)object;

// 把string进行URL编码转换统一成NSUTF8StringEncoding格式
+ (NSString*)encodeURL:(NSString*)string;

// url字串编码
+ (NSString*)urlEncode:(NSString*)url encoding:(NSStringEncoding)stringEncoding;

// dictionary对象转json字串
+ (NSString*)dictionaryToJsonString:(NSDictionary*)dic;

// 根据1个号得到这个数字的最后一位
+ (int)getLastIndexNum:(int)num;

// 得到当前系统计数器时间
+ (NSTimeInterval)getCurTick;

// 得到当前系统时间，字符串表现形式
+ (NSString*)getSysTime;

// 得到当前系统时间，字符串表现形式
+ (NSString*)getSysTimeSSS;

// 得到当前系统时间，字符串表现形式
+ (NSString*)getSysTimeForTimer;

// 根据一个字符串判断一下这个字符串是不是null或者是空串等等不合法的字符
+ (BOOL)stringIsUsefull:(NSString*)string;

// 正则,手机号码校验。
+ (BOOL)isValidateMobileNumber:(NSString*)strMobile;

// 得到正确的11位手机号
+ (NSString*)getMobileNumber:(NSString*)mobile;

// 判断一下目标字符是不是只含有数字
+ (BOOL)isValidateNumber:(NSString*)str;

// 判断一下目标字符只含有数字和字母
+ (BOOL)isValidateNumberAndAlphabet:(NSString*)str;

// 判断一下目标字符是邮箱
+ (BOOL)isValidateEMail:(NSString*)str;

// 过滤字符串中的特殊字符  类似!@#$%^&*()
+ (NSString*)filterNSStringContext:(NSString *)tagValue;

// 获得设备名称
+ (NSString*)getCurrentDeviceName;

// CFUUID(唯一标识符) 删除程序再安装时，会生成新的UDID
+ (NSString*)uniqueStringCFUUID;

// OpenUDID(唯一标识符) 在系统恢复设置或刷机的情况下会丢失，非苹果原生API
+ (NSString*)uniqueStringOpenUDID;

// md5算法
+ (NSString*)md5:(NSString*)str;

// hmac_md5加密
+ (NSString *)hmac_md5:(NSString *)key text:(NSString *)text;

// 输出日志
+ (void)printLogUrl:(NSURL*)url parameters:(id)parameters;

// 输出日志，带返回值
+ (void)printLogUrl:(NSURL*)url parameters:(id)parameters finalResponseObject:(id)responseObj;

// 验证经纪人编号
+ (BOOL)validateAgentNum:(NSString *)agentNum;

+(BOOL)stringIsBasicNumber:(NSString *)str;

@end
