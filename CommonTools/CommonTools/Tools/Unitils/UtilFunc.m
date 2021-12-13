//
//  UtilFunc.m
//  Util
//
//  Created by ljj on 14-8-14.
//
//

#import <Accelerate/Accelerate.h>
#import <CoreLocation/CoreLocation.h>
#import "UtilFunc.h"

#define AMR_MAGIC_NUMBER "#!AMR\n"

static const char* jailbreak_apps[] =
{
    "/Applications/Cydia.app",
    "/Applications/limera1n.app",
    "/Applications/greenpois0n.app",
    "/Applications/blackra1n.app",
    "/Applications/blacksn0w.app",
    "/Applications/redsn0w.app",
    "/Applications/Absinthe.app",
    "/Applications/IAPCrazy.app",
    NULL
};

@implementation UtilFunc

+(BOOL)haveNetwork{
    Reachability *internet = [Reachability reachabilityForInternetConnection];
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    if ((wifi.currentReachabilityStatus != 0) || (internet.currentReachabilityStatus != 0)) {
        return YES;
        
    }
    return NO;
}

+ (BOOL)checkJailBreak
{
    // Now check for known jailbreak apps. If we encounter one, the device is jailbroken.
    for (int i = 0; jailbreak_apps[i] != NULL; ++i)
    {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:jailbreak_apps[i]]])
        {
            NSLog(@"isjailbroken: %s", jailbreak_apps[i]);
            return YES;
        }
    }
    return NO;
}

+ (BOOL)checkIAPFree
{
    BOOL result = NO;
    
    NSString *rootAppPath = @"/Applications";
    NSArray *listApp = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:rootAppPath error:nil];
    
    for (int i = 0; i < [listApp count]; i++)
    {
        NSString * name = [listApp objectAtIndex:i];
        if ([name compare:@"IAPFree.app" options:NSCaseInsensitiveSearch] == NSOrderedSame)
        {
            result = YES;
        }
    }
    
    NSString *substrateAppPath = @"/Library/MobileSubstrate/DynamicLibraries";
    NSArray *substrateListApp = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:substrateAppPath error:nil];
    
    for (int i = 0; i < [substrateListApp count]; i++)
    {
        NSString *name = [substrateListApp objectAtIndex:i];
        if ([name compare:@"iap.dylib" options:NSCaseInsensitiveSearch] == NSOrderedSame)
        {
            result = YES;
        }
    }
    
    return result;
}

+ (VersionChangeState)validateVersionNumber:(NSString *)oldVersionNumber newVersionNumber:(NSString *)newVersionNumber
{
    //默认是相等
    VersionChangeState reslt = VersionChangeStateEqual;
    
    NSArray *oldVersionArr = [oldVersionNumber componentsSeparatedByString:@"."];
    
    NSArray *newVersionArr = [newVersionNumber componentsSeparatedByString:@"."];
    
    NSUInteger oldArrCount = [oldVersionArr count];
    
    NSUInteger newArrCount = [newVersionArr count];

    NSUInteger arrCount = oldArrCount < newArrCount ? oldArrCount : newArrCount;
    
    for (NSUInteger i = 0; i < arrCount; i++) {
        if ([[newVersionArr objectAtIndex:i] intValue] > [[oldVersionArr objectAtIndex:i] intValue]) {
            reslt = VersionChangeStateSmall;
            break;
        } else if ([[newVersionArr objectAtIndex:i] intValue] < [[oldVersionArr objectAtIndex:i] intValue]) {
            reslt = VersionChangeStateLarge;
            break;
        }
    }
    
    if (reslt == VersionChangeStateEqual && newArrCount > oldArrCount) {
        reslt = VersionChangeStateSmall;
    } else if (reslt == VersionChangeStateEqual && newArrCount < oldArrCount) {
        reslt = VersionChangeStateLarge;
    }
    
    return reslt;
}

+ (UIImage*)blurImage:(UIImage*)image withBlurLevel:(CGFloat)blur
{
    if ((blur < 0.0f) || (blur > 1.0f))
    {
        blur = 0.5f;
    }
    
    if (image == nil)
    {
        return nil;
    }
    
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    
    // 第三个中间的缓存区,抗锯齿的效果
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL,
                               0, 0, boxSize, boxSize, NULL,
                               kvImageEdgeExtend);
    vImageBoxConvolve_ARGB8888(&outBuffer, &outBuffer2, NULL,
                               0, 0, boxSize, boxSize, NULL,
                               kvImageEdgeExtend);
    vImageBoxConvolve_ARGB8888(&outBuffer2, &outBuffer, NULL,
                               0, 0, boxSize, boxSize, NULL,
                               kvImageEdgeExtend);
    
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);

    CGImageRelease(imageRef);
    
    return returnImage;
}

/*
1、获取一个随机整数范围在：[0,100)包括0，不包括100
               
    int x = arc4random() % 100;
               
2、获取一个随机数范围在：[500,1000），包括500，不包括1000
                               
    int y = (arc4random() % 500) + 500;
 
3、获取一个随机数范围在：[500,1000），包括500，包括1000
 
    int y = (arc4random() % 501) + 500;
*/

// 获取一个随机整数,范围在[from, to], 包括from, 包括to
+ (int)getRandomNumberFrom:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}

/**
 *  根据音频文件二进制流判断是否是amr格式音频
 *
 *  @param audioPath 音频文件路径
 *
 *  @return BOOL
 */
+ (BOOL)isAMR:(NSString*)audioPath
{
    NSData* data = [NSData dataWithContentsOfFile:audioPath];
    const char* rfile = [data bytes];
    
    // 检查amr文件头
    if (strncmp(rfile, AMR_MAGIC_NUMBER, strlen(AMR_MAGIC_NUMBER)) == 0)
    {
        return YES;
    }
    
    return NO;
}

/**
 *  去掉字符串里面尖括号所表示的一些html tag(一般表示超文本链接等)
 *
 *  @param NSString 需要去除这些tag的字符串
 *
 *  @return NSString 去除以后的新字符串
 */
+ (NSString*)deleteBracketInString:(NSString*)str
{
    NSMutableString *string = [NSMutableString stringWithString:str];
    
    // 正则表达式: * 0次或多次, \\S 表示字符串
    NSString *parten1 = @"<a>\\S*</a>";
    NSString *parten2 = @"<a href=\\'\\S*\\'>";
    NSString *parten3 = @"</a>";
    NSString *parten4 = @"<br/>";
    NSError* error = NULL;
    
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:parten1
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:&error];
    NSString* replacedText = [reg stringByReplacingMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, [string length]) withTemplate:@""];
    
    reg = [NSRegularExpression regularExpressionWithPattern:parten2
                                                    options:NSRegularExpressionCaseInsensitive
                                                      error:&error];
    replacedText = [reg stringByReplacingMatchesInString:replacedText options:NSMatchingReportProgress range:NSMakeRange(0, [replacedText length]) withTemplate:@""];
    
    reg = [NSRegularExpression regularExpressionWithPattern:parten3
                                                    options:NSRegularExpressionCaseInsensitive
                                                      error:&error];
    replacedText = [reg stringByReplacingMatchesInString:replacedText options:NSMatchingReportProgress range:NSMakeRange(0, [replacedText length]) withTemplate:@""];
    
    reg = [NSRegularExpression regularExpressionWithPattern:parten4
                                                    options:NSRegularExpressionCaseInsensitive
                                                      error:&error];
    replacedText = [reg stringByReplacingMatchesInString:replacedText options:NSMatchingReportProgress range:NSMakeRange(0, [replacedText length]) withTemplate:@""];
    
    return replacedText;
}

/**
 *  把一长串文本放在指定宽度的矩形框里面所规范出来的大小
 *
 *  @param size 指定宽度的矩形框
 *  @param text 一长串文本
 *  @param font 文本对应的字体
 *
 *  @return BOOL
 */
+ (CGSize)boundingRectWithSize:(CGSize)size withText:(NSString*)text withFont:(UIFont*)font
{
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
    
    NSDictionary *attributes = @{ NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle };
    CGSize retSize = [text boundingRectWithSize:size options:options attributes:attributes context:nil].size;
    
    return retSize;
}

/**
 *  根据经纬度算出两点之间的距离
 *
 *  @param lat1 纬度1
 *  @param lng1 经度1
 *  @param lat2 纬度2
 *  @param lng2 经度2
 *
 *  @return double
 */
+ (double)getDistance:(double)lat1 withLng1:(double)lng1 withLat2:(double)lat2 withLng2:(double)lng2
{
    CLLocation *orig = [[CLLocation alloc] initWithLatitude:lat1 longitude:lng1];
    CLLocation* dist = [[CLLocation alloc] initWithLatitude:lat2 longitude:lng2];
    
    CLLocationDistance kilometers = [orig distanceFromLocation:dist] / 1000;
    
    //UI_LOG(@"kilometers = %f", kilometers);
    
    return kilometers;
}

/**
 *  要返回的距离字符串
 *
 *  @param distance 距离
 *
 *  @return NSString
 */
+ (NSString*)getDistanceString:(double)distance
{
    NSString* str = nil;
    if (distance <= 0)
    {
        str = @"保密";
    }
    if (distance > 1)
    {
        int zoomValue = (int)distance;
        if (zoomValue < 500)
        {
            str = [NSString stringWithFormat:@"%dkm", zoomValue];
        }
        else
        {
            str = @"保密";
        }
    }
    else
    {
        int zoomValue = (int) (distance * 1000);
        if (zoomValue <= 10)
        {
            str = @"10m";
        }
        else
        {
            int theValue = zoomValue / 10 * 10;
            str = [NSString stringWithFormat:@"%dm", theValue];
        }
    }
    
    return str;
}

+ (NSString*)distanceString:(double)lat1 withLng1:(double)lng1 withLat2:(double)lat2 withLng2:(double)lng2
{
    double distance = [UtilFunc getDistance:lat1 withLng1:lng1 withLat2:lat2 withLng2:lng2];
    
    return [UtilFunc getDistanceString:distance];
}

// 倒计时(GCD实现)
+ (void)countDown:(NSTimeInterval)second complete:(void(^)())completeBlock progress:(void(^)(id time))progressBlock
{
    __block int timeout = second;//倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);//每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout <= 0)
        {
            // 倒计时结束,关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示,根据自己需求设置
                completeBlock();
            });
        }
        else
        {
            //int minutes = timeout / 60;
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            if(timeout == second)
            {
                strTime = [NSString stringWithFormat:@"%.2d", timeout];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示,根据自己需求设置
                NSLog(@"____%@", strTime);
                progressBlock(strTime);
                
            });

            timeout--;
        }
    });
    
    dispatch_resume(_timer);
}
+ (void)drawDottedLineWithView:(UIView *)view
                    beginPoint:(CGPoint)beginPoint
                      endPoint:(CGPoint)endPoint
               lineDashPattern:(NSArray *)lineDashPattern {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineJoin = kCALineJoinBevel;
    shapeLayer.fillColor   = [[UIColor whiteColor] CGColor];
    shapeLayer.lineWidth   = 0.5f;
    shapeLayer.strokeEnd   = 0.0f;
    [view.layer addSublayer:shapeLayer];
    
    [shapeLayer setLineJoin:kCALineJoinRound];

    [shapeLayer setLineDashPattern:
     lineDashPattern];
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:beginPoint];
    [path setLineWidth:0.5f];
    [path setLineCapStyle:kCGLineCapRound];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path addLineToPoint:endPoint];
    
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor=[RGBCOLORV(0xD1D1D1) CGColor];
    shapeLayer.strokeEnd = 1.0;
}
/**
 *  身份证号码格式化6-4-4-4格式
 *
 *  @param idCard 输入正常身份证
 *
 *  @return 格式化后的
 */
+  (NSString *)idCardFormat:(NSString *)idCard {
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[idCard substringToIndex:6]];
    [array addObject:[idCard substringWithRange:NSMakeRange(6, 4)]];
    [array addObject:[idCard substringWithRange:NSMakeRange(10, 4)]];
    [array addObject:[idCard substringWithRange:NSMakeRange(14, 4)]];
    return [NSString stringWithFormat:@"%@ %@ %@ %@",array[0],array[1],array[2],array[3]];

}
/**
 *  银行卡格式化
 *
 *  @param originalCardNumber originalCardNumber description
 *
 *  @return return value description
 */
+ (NSString *)creditCardFormat:(NSString *)originalCardNumber {
    
    NSString *newString = @"";
    while (originalCardNumber.length > 0) {
        NSString *subString = [originalCardNumber substringToIndex:MIN(originalCardNumber.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        originalCardNumber = [originalCardNumber substringFromIndex:MIN(originalCardNumber.length, 4)];
    }
    
    return newString;

}

/**
 *  // 验证是固话或者手机号
 *
 *  @param mobileNum 手机号
 *
 *  @return 是否
 */
+ (BOOL)isMobilePhoneOrtelePhone:(NSString *)mobileNum {
    if (mobileNum==nil || mobileNum.length ==0) {
        return NO;
    }
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^((13)|(14)|(15)|(16)|(17)|(18)|(19))\\d{9}$";// @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    NSString * PHS = @"^((0\\d{2,3}-?)\\d{7,8}(-\\d{2,5})?)$";// @"^0(10|2[0-5789]-|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)
        || ([regextestPHS evaluateWithObject:mobileNum]==YES)) {
        return YES;
    }else{
        return NO;
    }

}

+ (NSString*)bytesToString:(NSInteger)bytes
{
    if(bytes < 1024)
    {
        // B
        return [NSString stringWithFormat:@"%ldB", bytes];
    }
    
    else if(bytes >= 1024 && bytes < 1024 * 1024)
    {
        // KB
        return [NSString stringWithFormat:@"%.1fKB", (double)bytes / 1024];
    }
    
    else if(bytes >= 1024 * 1024 && bytes < 1024 * 1024 * 1024)
    {
        // MB
        return [NSString stringWithFormat:@"%.2fMB", (double)bytes / (1024 * 1024)];
    }
    
    else
    {
        // GB
        return [NSString stringWithFormat:@"%.3fGB", (double)bytes / (1024 * 1024 * 1024)];
    }
}

+ (CGFloat)getWidthFromString:(NSString *)string font:(CGFloat)font
{
    CGRect tagRect = [string boundingRectWithSize:CGSizeMake(10000, 20) options:NSStringDrawingUsesLineFragmentOrigin  attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName, nil] context:nil];
    return tagRect.size.width;
}

+ (CGFloat)getHeightFromString:(NSString *)string font:(CGFloat)font width:(CGFloat)width
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin  attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName, nil] context:nil];
    return rect.size.height;
}

+ (CGRect)leftRect:(CGRect)rect width:(float)width offset:(float)offset
{
    return CGRectMake(rect.origin.x + offset,
                      rect.origin.y,
                      width,
                      rect.size.height);
}

+ (CGRect)rightRect:(CGRect)rect width:(float)width offset:(float)offset
{
    return CGRectMake(rect.origin.x + rect.size.width - width - offset,
                      rect.origin.y,
                      width,
                      rect.size.height);
}

+ (CGRect)topRect:(CGRect)rect height:(float)height offset:(float)offset
{
    return CGRectMake(rect.origin.x,
                      rect.origin.y + offset,
                      rect.size.width,
                      height);
}

+ (CGRect)bottomRect:(CGRect)rect height:(float)height offset:(float)offset
{
    return CGRectMake(rect.origin.x,
                      rect.origin.y + rect.size.height - height - offset,
                      rect.size.width,
                      height);
}

+ (CGRect)leftTopRect:(CGRect)rect width:(float)width height:(float)height
{
    return CGRectMake(rect.origin.x,
                      rect.origin.y,
                      width,
                      height);
}

+ (CGRect)leftCenterRect:(CGRect)rect width:(float)width height:(float)height offset:(float)offset
{
    return CGRectMake(rect.origin.x + offset,
                      rect.origin.y + (rect.size.height - height) / 2,
                      width,
                      height);
}

+ (CGRect)leftBottomRect:(CGRect)rect width:(float)width height:(float)height
{
    return CGRectMake(rect.origin.x,
                      rect.origin.y + rect.size.height - height,
                      width,
                      height);
}

+ (CGRect)rightTopRect:(CGRect)rect width:(float)width height:(float)height
{
    return CGRectMake(rect.origin.x + rect.size.width - width,
                      rect.origin.y,
                      width,
                      height);
}

+ (CGRect)rightCenterRect:(CGRect)rect width:(float)width height:(float)height offset:(float)offset
{
    return CGRectMake(rect.origin.x + rect.size.width - offset - width,
                      rect.origin.y + (rect.size.height - height) / 2,
                      width,
                      height);
}

+ (CGRect)rightBottomRect:(CGRect)rect width:(float)width height:(float)height
{
    return CGRectMake(rect.origin.x + rect.size.width - width,
                      rect.origin.y + rect.size.height - height,
                      width,
                      height);
}

+ (CGRect)topCenterRect:(CGRect)rect width:(float)width height:(float)height offset:(float)offset
{
    return CGRectMake(rect.origin.x + (rect.size.width - width) / 2,
                      rect.origin.y + offset,
                      width,
                      height);
}

+ (CGRect)centerRect:(CGRect)rect width:(float)width height:(float)height
{
    CGPoint point = {rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height / 2};
    return CGRectMake(point.x - width/2,
                      point.y - height/2,
                      width,
                      height);

}

+ (CGRect)bottomCenterRect:(CGRect)rect width:(float)width height:(float)height offset:(float)offset
{
    return CGRectMake(rect.origin.x + (rect.size.width - width) / 2,
                      rect.origin.y + rect.size.height - offset - height,
                      width,
                      height);
}

//DeflateRectXY

+(CGRect)deflateRectXY:(CGRect)rect X:(float)x Y:(float)y
{
    return CGRectMake(rect.origin.x + x,
                      rect.origin.y + y ,
                      rect.size.width - x - x,
                      rect.size.height - y - y);
}

@end
