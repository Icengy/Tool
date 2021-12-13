//
//  UtilFunc.h
//  Util
//
//  Created by ljj on 14-8-14.
//
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    VersionChangeStateNone = 0,//
    VersionChangeStateSmall,//自己的版本号比较小，标明有更新
    VersionChangeStateEqual,//相等
    VersionChangeStateLarge,//自己的比新的大表示自己的版本是较新的
} VersionChangeState;

@interface UtilFunc : NSObject

//判断是否有网络
+(BOOL)haveNetwork;


/**
 *  检查手机是否越狱
 *
 *  @param nil
 *
 *  @return BOOL
 */
+ (BOOL)checkJailBreak;

/**
 *  检查是否安装了IAP Free内购破解软件
 *
 *  @param nil
 *
 *  @return BOOL
 */
+ (BOOL)checkIAPFree;


/**
 *  校验版本号，默认自己的版本号是老的，
 *
 *  @param oldVersionNumber  老的版本号   传送自己的版本号
 *  @param newVersionNumber  新的版本号   要比对的版本号，可能是从自己的server获取，或者从app store获得
 *
 *  @return
 */
+ (VersionChangeState)validateVersionNumber:(NSString *)oldVersionNumber newVersionNumber:(NSString *)newVersionNumber;

/**
 *  模糊图片
 *
 *  @param image 源图片
 *  @param blur  模糊值 0~1
 *
 *  @return 模糊以后的图片
 */
+ (UIImage*)blurImage:(UIImage*)image withBlurLevel:(CGFloat)blur;

/**
 *  获取一个随机整数,范围在[from, to], 包括from, 包括to
 *
 *  @param from [from
 *  @param from  to]
 *
 *  @return 随机整数
 */
+ (int)getRandomNumberFrom:(int)from to:(int)to;


/**
 *  根据音频文件二进制流判断是否是amr格式音频
 *
 *  @param audioPath 音频文件路径
 *
 *  @return BOOL
 */
+ (BOOL)isAMR:(NSString*)audioPath;

/**
 *  去掉字符串里面尖括号所表示的一些html tag(一般表示超文本链接等)
 *
 *  @param NSString 需要去除这些tag的字符串
 *
 *  @return NSString 去除以后的新字符串
 */
+ (NSString*)deleteBracketInString:(NSString*)str;

/**
 *  把一长串文本放在指定宽度的矩形框里面所规范出来的大小
 *
 *  @param size 指定宽度的矩形框
 *  @param text 一长串文本
 *  @param font 文本对应的字体
 *
 *  @return BOOL
 */
+ (CGSize)boundingRectWithSize:(CGSize)size withText:(NSString*)text withFont:(UIFont*)font;

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
+ (double)getDistance:(double)lat1 withLng1:(double)lng1 withLat2:(double)lat2 withLng2:(double)lng2;

/**
 *  要返回的距离字符串
 *
 *  @param distance 距离
 *
 *  @return NSString
 */
+ (NSString*)getDistanceString:(double)distance;

/**
 *  要返回的距离字符串根据两点的经纬度
 *
 *  @param lat1 纬度1
 *  @param lng1 经度1
 *  @param lat2 纬度2
 *  @param lng2 经度2
 *
 *  @return NSString
 */
+ (NSString*)distanceString:(double)lat1 withLng1:(double)lng1 withLat2:(double)lat2 withLng2:(double)lng2;

/**
 *  倒计时(GCD实现)
 *
 *  @param second 倒计时时间
 *  @param completeBlock 倒计时完成block
 *  @param progressBlock 每秒钟一次回调
 *
 *  @return None
 */
+ (void)countDown:(NSTimeInterval)second complete:(void(^)())completeBlock progress:(void(^)(id time))progressBlock;
/**
 *  画虚线的
 *
 *  @param view            具体我也不太会用   你项目中全局搜索下  或者问洪帅 他应该用过
 *  @param beginPoint      beginPoint description
 *  @param endPoint        endPoint description
 *  @param lineDashPattern lineDashPattern description
 */
+ (void)drawDottedLineWithView:(UIView *)view
                    beginPoint:(CGPoint)beginPoint
                      endPoint:(CGPoint)endPoint
               lineDashPattern:(NSArray *)lineDashPattern;

/**
 *  身份证号码格式化6-4-4-4格式
 *
 *  @param idCard 输入正常身份证
 *
 *  @return 格式化后的
 */
+ (NSString *)idCardFormat:(NSString *)idCard;
/**
 *  银行卡格式化
 *
 *  @param originalCardNumber originalCardNumber description
 *
 *  @return return value description
 */
+ (NSString *)creditCardFormat:(NSString *)originalCardNumber;

/**
 *  // 验证是固话或者手机号
 *
 *  @param mobileNum 手机号
 *
 *  @return 是否
 */
+ (BOOL)isMobilePhoneOrtelePhone:(NSString *)mobileNum;

/**
 *  把bytes转换成一般人能理解的字符串
 *
 *  @param bytes 比特数
 *
 *  @return NSString
 */
+ (NSString*)bytesToString:(NSInteger)bytes;

/**
 *  根据文本内容和字体求文本总宽度
 *
 *  @param string 传入的文本内容
 *  @param font   传入的字体大小
 *
 *  @return CGFloat
 */
+ (CGFloat)getWidthFromString:(NSString *)string font:(CGFloat)font;

/**
 *  根据文本的固定宽度 文本大小及内容求文本所占的高度
 *
 *  @param string 传入的文本内容
 *  @param font   传入的字体大小
 *  @param width  传入的固定宽度
 *
 *  @return CGFloat
 */
+ (CGFloat)getHeightFromString:(NSString *)string font:(CGFloat)font width:(CGFloat)width;

/**
 *  Rect计算辅助函数,方便代码布局用
 */
+ (CGRect)leftRect:(CGRect)rect width:(float)width offset:(float)offset;
+ (CGRect)rightRect:(CGRect)rect width:(float)width offset:(float)offset;
+ (CGRect)topRect:(CGRect)rect height:(float)height offset:(float)offset;
+ (CGRect)bottomRect:(CGRect)rect height:(float)height offset:(float)offset;

+ (CGRect)leftTopRect:(CGRect)rect width:(float)width height:(float)height;
+ (CGRect)leftCenterRect:(CGRect)rect width:(float)width height:(float)height offset:(float)offset;
+ (CGRect)leftBottomRect:(CGRect)rect width:(float)width height:(float)height;

+ (CGRect)rightTopRect:(CGRect)rect width:(float)width height:(float)height;
+ (CGRect)rightCenterRect:(CGRect)rect width:(float)width height:(float)height offset:(float)offset;
+ (CGRect)rightBottomRect:(CGRect)rect width:(float)width height:(float)height;

+ (CGRect)topCenterRect:(CGRect)rect width:(float)width height:(float)height offset:(float)offset;
+ (CGRect)centerRect:(CGRect)rect width:(float)width height:(float)height;
+ (CGRect)bottomCenterRect:(CGRect)rect width:(float)width height:(float)height offset:(float)offset;

+(CGRect)deflateRectXY:(CGRect)rect X:(float)x Y:(float)y;

@end
