
//  CommonUtils.m
//  DingDingCore
//
//  Created by phoenix on 14-10-10.
//  Copyright (c) 2014年 SEU. All rights reserved.
//

#import "CommonUtils.h"
#import "ESOpenUDID.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>
#import <mach/mach_time.h>
#import <sys/sysctl.h>
//#import <MKNetworkKit/NSData+Base64.h>

static NSString *numbers = @"0123456789";

@implementation CommonUtils

// 判断是否为空串
+ (BOOL)isNull:(id)object
{
    // 判断是否为空串
    if ([object isEqual:[NSNull null]])
    {
        return YES;
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if (object == nil)
    {
        return YES;
    }
    return NO;
}

// 检查返回的字符串是否是"<null>"(return 字符串本身或者""(注意不是nil,是空,字符串里面的货是空))
+ (id)checkNull:(id)object
{
    //通过http请求,后台返回json数据,检查返回的字符串是否是"<null>"
    if([CommonUtils isNull:object] == YES)
    {
        return nil;
    }
    else
    {
        return object;
    }
}

// 把string进行URL编码转换统一成NSUTF8StringEncoding格式
+ (NSString*)encodeURL:(NSString*)string
{
	NSString *urlString = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    
	if(urlString)
    {
		return urlString;
	}
	return @"";
}

//根据1个号得到这个数字的最后一位
+ (int)getLastIndexNum:(int)num
{
    NSString *stringTemp=[NSString stringWithFormat:@"%d",num];
    NSString *returnString=[stringTemp substringFromIndex:[stringTemp length]-1];
    int lastNum=[returnString intValue];
    return lastNum;
}

// 得到当前系统计数器时间
+ (NSTimeInterval)getCurTick
{
    static double scale = 0.0;
    if (0.0 == scale)
    {
        mach_timebase_info_data_t info;
        mach_timebase_info(&info);
        scale = info.numer / info.denom * 1e-9;
    }
    
    return mach_absolute_time() * scale;
}

// 得到当前系统时间，字符串表现形式
+ (NSString *)getSysTime
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* date=[formatter stringFromDate:[NSDate date]];
    return date;
}

// 得到当前系统时间，字符串表现形式
+ (NSString *)getSysTimeSSS
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
    NSString* date=[formatter stringFromDate:[NSDate date]];
    return date;
}

// 得到当前系统时间，字符串表现形式
+ (NSString*)getSysTimeForTimer
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString* date=[formatter stringFromDate:[NSDate date]];
    return date;
}

// 根据一个字符串判断一下这个字符串是不是null或者是空串等等不合法的字符，这些非法的字符都是一些最基本的，和业务逻辑没有关系的
// 后续还会完善
+ (BOOL)stringIsUsefull:(NSString*)string
{
    BOOL result = YES;
    
    if (NULL == string || [string isEqual:nil] || [string isEqual:Nil])
    {
        result = NO;
    }
    else if ([string isEqual:[NSNull null]])
    {
        result = NO;
    }
    else if (0 == [string length] || 0 == [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length])
    {
        result = NO;
    }
    else if([string isEqualToString:@"(null)"])
    {
        result = NO;
    }
    
    return result;
}

// 正则，手机号码校验:判断一下是不是正确的手机格式
+ (BOOL)isValidateMobileNumber:(NSString*)strMobile
{
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    
    /*
     18500041984:       valid
     8618500041984:     valid
     008618500041984:   valid
     +8618500041984:    valid
     08618500041984:    invalid
     ++8618500041984:   invalid
     */
    
    //NSString *reg = @"^((86)|(086)|(0086)|(\\+86)){0,1}((13[0-9])|(15[^4,\\D])|(18[0-9]))\\d{8}$";//Android
    //NSString *mobileRegex = @"^((\\+861)|1)((3[4-9])|(5[0-2|7-9])|(8[7-8])|82|47)[0-9]{8}$";
    //NSString *mobileRegex = @"^((00861)|(\\+861)|(861)|1)(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString *mobileRegex = @"^((00861)|(\\+861)|(861)|1)(3[0-9]|4[0-9]|5[0-9]|6[0-9]|7[0-9]|8[0-9]|9[0-9])\\d{8}$";

    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegex];
    return [mobileTest evaluateWithObject:strMobile];
}

// 得到正确的11位手机号
+ (NSString*)getMobileNumber:(NSString*)mobile
{
    if(mobile && mobile.length >= 11)
    {
        NSString *last11 = [mobile substringFromIndex:mobile.length - 11];
        
        return last11;
    }
    else
    {
        return nil;
    }
}

// 判断一下目标字符是不是只含有数字
+ (BOOL)isValidateNumber:(NSString*)str
{
    NSString *ONLYNUM_REGX=@"^[^0]\\d*$";
    
    NSPredicate *onlyNumPred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@", ONLYNUM_REGX];
    
    return [onlyNumPred evaluateWithObject:str];
}

// 正则,只含有数字和字母
+ (BOOL)isValidateNumberAndAlphabet:(NSString*)str
{
    NSString *REGX = @"^[A-Za-z0-9]+$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", REGX];
    
    return [pred evaluateWithObject:str];
}

// 正则邮箱
+ (BOOL)isValidateEMail:(NSString*)str
{
    NSString *REGX = @"^[A-Z0-9a-z._%+-]+$";

    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", REGX];

    return [pred evaluateWithObject:str];
}

// 过滤字符串中的特殊字符  类似!@#$%^&*()
+ (NSString*)filterNSStringContext:(NSString*)tagValue
{
    NSString*bStr =(__bridge_transfer NSString *)(CFURLCreateStringByAddingPercentEscapes (kCFAllocatorDefault, (CFStringRef)tagValue,NULL,CFSTR(":/?#[]@!$&’()*+,;=%^<>.|\\\"_-+'"), kCFStringEncodingUTF8));
    return bStr;
}

// 获得设备名称
+ (NSString*)getCurrentDeviceName
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]
        || [platform isEqualToString:@"iPhone3,2"]
        || [platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]
        || [platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]
        || [platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]
        || [platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    
    if ([platform hasPrefix:@"iPhone"])
    {
        return @"iPhone";
    }
    
    // iPod
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    if ([platform hasPrefix:@"iPod"])
    {
        return @"iPod";
    }
    
    // iPad
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad 1G";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,6"])      return @"iPad Mini 2G";
    
    if ([platform hasPrefix:@"iPad"])
    {
        return @"iPad";
    }
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
    
}

// url字串编码
+ (NSString*)urlEncode:(NSString*)url encoding:(NSStringEncoding)stringEncoding
{
	NSArray *escapeChars = [NSArray arrayWithObjects:/*@";", @"/", @"?", @":",*/
							/*@"@", @"&", @"=", */@"+", /*@"$", @",", @"!",
                                                         @"'", @"(", @")", @"*", @"-",*/ nil];
	
	NSArray *replaceChars = [NSArray arrayWithObjects:/*@"%3B", @"%2F", @"%3F", @"%3A",*/
							 /*@"%40", @"%26", @"%3D",*/@"%2B", /*@"%24", @"%2C", @"%21",
                                                                 @"%27", @"%28", @"%29", @"%2A", @"%2D",*/ nil];
	int len = (int)[escapeChars count];
	NSString *tempStr = [url stringByAddingPercentEscapesUsingEncoding:stringEncoding];
	if (tempStr == nil) {
		return nil;
	}
	NSMutableString *temp = [tempStr mutableCopy];
	int i;
	for (i = 0; i < len; i++)
    {
		[temp replaceOccurrencesOfString:[escapeChars objectAtIndex:i]
							  withString:[replaceChars objectAtIndex:i]
								 options:NSLiteralSearch
								   range:NSMakeRange(0, [temp length])];
	}
	NSString *outStr = [NSString stringWithString: temp];
	return outStr;
}

// dictionary对象转json字串
+ (NSString*)dictionaryToJsonString:(NSDictionary*)dic
{
    NSString *str = nil;
    
    NSError *error = nil;
    NSData * jasonData = nil;
    if ([NSJSONSerialization isValidJSONObject:dic])
    {
        jasonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&error];
    }
    
    if (jasonData)
    {
        str = [[NSString alloc] initWithData:jasonData encoding:NSUTF8StringEncoding];
    }
    
    return str;
}

// CFUUID(唯一标识符) 删除程序再安装时，会生成新的UDID
+ (NSString*)uniqueStringCFUUID
{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    NSString* uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return uuidString;
}

// OpenUDID(唯一标识符) 在系统恢复设置或刷机的情况下会丢失，非苹果原生API
+ (NSString*)uniqueStringOpenUDID
{
    /*
     同一台设备上使用OpenUDID的所有程序其获取到的UDID都是相同的
     没有用到取MAC地址等可能被苹果禁用的API
    */
    NSString* openUDID = [ESOpenUDID value];
    
    return openUDID;
}

// md5算法
+ (NSString*)md5:(NSString*)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int) strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (NSString *)hmac_md5:(NSString *)key text:(NSString *)text{
    //第1步------ MD5 ------
    const char *cStr = [text UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int) strlen(cStr), result);
    
    //第2步------ hmac ------

    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    
    char cHMAC[CC_MD5_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgMD5, cKey, strlen(cKey), result, sizeof(result), cHMAC);
    
    //第3步------ hexstring ------
    //下面是Byte 转换为16进制。
    NSString *hexStr = @"";
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x", cHMAC[i]&0xff];//16进制数
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

// 输出日志
+ (void)printLogUrl:(NSURL*)url parameters:(id)parameters
{
    NSLog(@"========================================\nrequestUrl:\n%@\n==================================\nparameters:\n%@\n=========================================\n\n\n\n",url,parameters);
}

// 输出日志，带返回值
+ (void)printLogUrl:(NSURL*)url parameters:(id)parameters finalResponseObject:(id)responseObj
{
    NSLog(@"\n========================================\nrequestUrl:\n%@\n==================================\nparameters:\n%@\n==================================\nresponseObj:\n%@\n=========================================\n\n\n\n", url, [parameters JSONString], [responseObj JSONString]);
}
//dict zhuan json

+ (NSString*)convertToJSONData:(id)infoDict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:infoDict
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    NSString *jsonString = @"";
    
    if (! jsonData)
    {
        NSLog(@"Got an error: %@", error);
    }else
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    
    [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return jsonString;
}
// 验证经纪人编号
+ (BOOL)validateAgentNum:(NSString *)agentNum
{
    NSString *regex = @"^[0-9]{8}|[0-9]{11}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:agentNum];
}

+ (BOOL)stringIsBasicNumber:(NSString *)str{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:numbers]invertedSet];
    NSString *filtered = [[str componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
    BOOL isBasic = [str isEqualToString:filtered];
    
    return isBasic;
}

@end
