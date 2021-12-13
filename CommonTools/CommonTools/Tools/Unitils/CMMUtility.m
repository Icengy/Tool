//
//  CMMUtility.m
//  JUXIU_iOS
//
//  Created by Homosum on 16/7/20.
//  Copyright © 2016年 JuXiuSheQu. All rights reserved.
//

#import "CMMUtility.h"
#import <SVProgressHUD.h>

#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>


@implementation CMMUtility
+ (void)showNoteWithError:(NSError *)error {
    
    
    
    NSString *errorMsg = [error.userInfo objectForKey:kNetWorErrorMsg];
    NSLog(@"%@",errorMsg);
    
    if (!QM_IS_STR_NIL(errorMsg)) {
        UIAlertView *alertInstance  = [[UIAlertView alloc] initWithTitle:@"提示" message:errorMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertInstance show];
        
        
        
        
    }
}

//不可以购买时显示的错误信息提示
+ (void)showNoteMsgWithError:(NSError *)error {
    NSString *errorMsg = [error.userInfo objectForKey:kNetWorErrorMsg];
    [SVProgressHUD showErrorWithStatus:errorMsg];
}

+(void)showNote:(NSString *)alertContent
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideWaitingAlertView];
           
           UIAlertView *alertInstance  = [[UIAlertView alloc] initWithTitle:@"提示" message:alertContent delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
           [alertInstance show];
    });
   
    
    
    
    
    
}

+(void)showTMPLogin {
    //    [[AppDelegate appDelegate] handleUserNotNotLoginError];
}

+(void)showAlertWith:(NSString *)alertStr target:(id)target tag:(int)tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:alertStr delegate:target cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = tag;
    alertView.delegate = target;
    [alertView show];
}

+ (void)showSuccessMessage:(NSString *)message {
    [SVProgressHUD showSuccessWithStatus:message];
}


+(void)showWaitingAlertView
{
 
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setForegroundColor:ColorAppRed];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD show];
    
}

+(void)hideWaitingAlertView
{
    

    [SVProgressHUD dismiss];
}
+(NSData*)imageConvertToData:(UIImage *)image
{
    NSData*data;
    if (UIImagePNGRepresentation(image) == nil) {
        
        data = UIImageJPEGRepresentation(image, 1);
         NSLog(@"存1data%@",data);
    } else {
        
        data = UIImagePNGRepresentation(image);
         NSLog(@"存2data%@",data);
    }
      NSLog(@"存0data%@",data);
    return data;
}
+(void)saveImage:(UIImage *)image andName:(NSString *)imageName
{
    NSData*data=[self imageConvertToData:image];
    NSString*directioyPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString*dataPath=[directioyPath stringByAppendingString:[NSString stringWithFormat:@"%@.dat",imageName]];
    NSLog(@"datapath1%@",dataPath);
    NSLog(@"存data%@",data);
//   BOOL isSuccess=[data writeToFile:dataPath atomically:YES];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:imageName];
//    NSLog(@"%d",isSuccess);
    
    
}
+(UIImage*)fetchImageWithName:(NSString*)imageName
{
    NSString*directioyPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString*dataPath=[directioyPath stringByAppendingString:[NSString stringWithFormat:@"%@.dat",imageName]];
     NSLog(@"datapath2%@",dataPath);
//    NSData*data=[NSData dataWithContentsOfFile:dataPath];
    NSData*data=[[NSUserDefaults standardUserDefaults] objectForKey:imageName];
//     NSLog(@"取data%@",data);
    return [self dataConvertToImage:data];
}
+(UIImage*)dataConvertToImage:(NSData*)data
{
    return [[UIImage alloc] initWithData:data];
}
+(void)unuseWait
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setForegroundColor:ColorAppRed];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD show];

}
+(void)postWait
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setForegroundColor:ColorAppRed];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
       [SVProgressHUD show];
}
+(void)hodgeWait
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setForegroundColor:ColorAppRed];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD show];

}
+(void)showSucessWith:(NSString *)str
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setForegroundColor:ColorAppRed];
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    [SVProgressHUD showSuccessWithStatus:str];
}
+(void)showFailureWith:(NSString*)str
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
     [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
     [SVProgressHUD setForegroundColor:ColorAppRed];
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    [SVProgressHUD showErrorWithStatus:str];

}
+(UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}
+(CGRect)vvs6SBoundsWithX:(CGFloat)x Y:(CGFloat)y Width:(CGFloat)width Height:(CGFloat)height
{
    return CGRectMake([self vvs6SWidth:x], [self vvs6SHight:y], [self vvs6SWidth:width], [self vvs6SHight:height]);
}
+(CGFloat)vvs6SWidth:(CGFloat)width{
    return width*100/375*kScreen_Width/100;
}
+(CGFloat)vvs6SHight:(CGFloat)hight{
    return hight*100/667*kScreen_Height/100;
}
+(UIImage*)qr_codeToImageWithSize:(CGFloat)size andUrlStr:(NSString *)urlstr
{
    [CMMUtility unuseWait];
    // 1. 实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2. 恢复滤镜的默认属性
    [filter setDefaults];
    
    // 3. 将字符串转换成NSData
    //    NSString *urlStr = @"http://www.ychpay.com/down.html";//测试二维码地址
    NSData *data = [urlstr dataUsingEncoding:NSUTF8StringEncoding];
    // 4. 通过KVO设置滤镜inputMessage数据
    [filter setValue:data forKey:@"inputMessage"];
    
    // 5. 获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    
    // 6. 将CIImage转换成UIImage，并放大显示 (此时获取到的二维码比较模糊,所以需要用下面的createNonInterpolatedUIImageFormCIImage方法重绘二维码)
    UIImage*image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:size];
    
    return image;
    
}

/**
 * 根据CIImage生成指定大小的UIImage
 *
 * @param image CIImage
 * @param size 图片宽度
 */
+(UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    [CMMUtility hideWaitingAlertView];
    return [UIImage imageWithCGImage:scaledImage];
}
+(NSString *)timeStringFromTimestamp:(NSString *)timestamp{
    //时间戳转时间的方法
    NSDate *timeData = [NSDate dateWithTimeIntervalSince1970:([timestamp longLongValue]*0.001)];
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strTime = [dateFormatter stringFromDate:timeData];
    return strTime;
}
//获取当前的时间
+(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}
/**
 * 数字变色处理
 */
+(void)changeNumsLabel:(UILabel*)label withColor:(UIColor*)color
{
    NSArray *number = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"."];
    NSString*content = label.text;
    UIFont *font = label.font;
     NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:content];
    for (int i = 0; i < content.length; i ++) {
        NSString *a = [content substringWithRange:NSMakeRange(i, 1)];
        if ([number containsObject:a]) {
            [attributeString setAttributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:font,NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleNone]} range:NSMakeRange(i, 1)];
        }
    }
    label.attributedText = attributeString;
}

/**
 * 时间戳转时间
 * timeFormat @"yyyy-MM-dd HH:mm:ss"
 **/
+(NSString*)timeConvertWithTimeStamp:(NSString *)timestamp andTimeFormat:(NSString*)timeFormat
{
    NSDate *timeData = [NSDate dateWithTimeIntervalSince1970:([timestamp longLongValue]*0.001)];
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:timeFormat];
    NSString *strTime = [dateFormatter stringFromDate:timeData];
    return strTime;
}
/**
 * 时间转时间戳
 * timeFormat @"yyyy-MM-dd HH:mm:ss"
 **/

+(NSString*)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)timeFormat{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:timeFormat]; //(@"YYYY-MM-dd HH:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:formatTime];
   
    
    //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return [NSString stringWithFormat:@"%ld",timeSp];
    
}



/**
 * 时间比较 yes:未过期 no:已过期
 **/
+(BOOL)timeCompareWithNow:(NSString*)timestamp
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *dat = [formatter stringFromDate:datenow];
    
    
    NSString *timeStringNow = [CMMUtility timeSwitchTimestamp:dat andFormatter:@"yyyy-MM-dd HH:mm:ss"];
    if ([timeStringNow integerValue]<[timestamp integerValue]) {
        return YES;//未过期
    }else{
        return NO;
    }
}

/**
 *  获取时间差值  截止时间-当前时间
 *  nowDateStr : 当前时间
 *  deadlineStr : 截止时间
 *  @return 时间戳差值
 */
+ (NSInteger)getDateDifferenceWithNowDateStr:(NSString*)nowDateStr deadlineStr:(NSString*)deadlineStr {
    
    NSInteger timeDifference = 0;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *nowDate = [formatter dateFromString:nowDateStr];
    NSDate *deadline = [formatter dateFromString:deadlineStr];
    NSTimeInterval oldTime = [nowDate timeIntervalSince1970];
    NSTimeInterval newTime = [deadline timeIntervalSince1970];
    timeDifference = newTime - oldTime;
    
    return timeDifference;
}

+ (NSInteger)getDayDifferenceWithStr:(NSString *)timeStr {
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:timeStr];
    NSString *currentTimeStr = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *currentDate = [dateFormatter dateFromString:currentTimeStr];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *startDate = [[NSDate alloc] init];
    NSDate *endDate = [[NSDate alloc] init];
    if ([date compare:[NSDate date]] == NSOrderedAscending) {
        startDate = date;
        endDate = currentDate;
    } else {
        startDate = currentDate;
        endDate  = date;
    }
    NSDateComponents *comp = [calendar components:NSCalendarUnitDay
                                             fromDate:startDate
                                           toDate:endDate
                                          options:NSCalendarWrapComponents];
    return comp.day;
}

+(NSDictionary *)dictionaryWithUrlString:(NSString *)urlStr
{
    
     NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
    NSArray *paramArray = [urlStr componentsSeparatedByString:@"&"];
    for (NSString *param in paramArray) {
        if (param && param.length) {
            NSArray *parArr = [param componentsSeparatedByString:@"="];
            if (parArr.count == 2) {
                [paramsDict setObject:parArr[1] forKey:parArr[0]];
            }
        }
    }
    return paramsDict;
    //
   
}
+(void)showToastWithText:(NSString*)msg{
    [SVProgressHUD dismiss];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setImageViewSize:CGSizeMake(0, -1)];
    [SVProgressHUD showImage:[UIImage new] status:msg];
    [SVProgressHUD dismissWithDelay:2 completion:^{
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
        [SVProgressHUD setImageViewSize:CGSizeMake(28, 28)];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    }];
}
+(void)showToastWithText:(NSString*)msg duration:(CGFloat)second{
    [SVProgressHUD dismiss];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setImageViewSize:CGSizeMake(0, -1)];
    [SVProgressHUD showImage:[UIImage new] status:msg];
    [SVProgressHUD dismissWithDelay:second completion:^{
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
        [SVProgressHUD setImageViewSize:CGSizeMake(28, 28)];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    }];
}
@end
