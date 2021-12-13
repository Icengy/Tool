//
//  UIImage+Ext.h
//  ESTicket
//
//  Created by phoenix on 14-10-10.
//  Copyright (c) 2014年 SEU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (IdentifierAddition)

// 截取部分图像
- (UIImage*)getSubImage:(CGRect)rect;

// 等比例缩放
- (UIImage*)scaleToSize:(CGSize)size;

/**
 *  @brief  Create a partially displayed image
 *
 *  @param  percentage  This defines the part to be displayed as original
 *  @param  vertical    If YES, the image is displayed bottom to top; otherwise left to right
 *  @param  grayscaleRest   If YES, the non-displaye part are in grayscale; otherwise in transparent
 *
 *  @return A generated UIImage instance
 */
- (UIImage*)partialImageWithPercentage:(float)percentage
                              vertical:(BOOL)vertical
                         grayscaleRest:(BOOL)grayscaleRest;
/**
 *  返回一张能自由拉伸的图片
 *
 *  @param name 图片名
 */
+ (instancetype)resizableImage:(NSString *)name;

/**
 *  颜色转换成图片
 *
 *  @param color 颜色
 *
 *  @return 转换后的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  根据字符串生成图片
 *
 *  @param hashString    字符串Hash值
 *  @param displayString 展示的字符串
 *
 *  @return 转换后的图片
 */
+ (UIImage *)imageWithHashString:(NSString *)hashString displayString:(NSString *)displayString;

#pragma mark - 图片压缩
/*!
 *  @brief 使图片压缩粗略至指定大小
 *
 *  @param image 当前要压缩的图 maxLength 压缩后的大小
 *
 *  @return 图片对象
 */

+ (NSData *)compressImageSize:(UIImage *)image toByte:(NSUInteger)maxLength;
/*!
 *  @brief 使图片压缩后刚好小于指定大小
 *
 *  @param sourceImage 当前要压缩的图 maxSize 压缩后的大小
 *
 *  @return 图片对象
 */
+ (NSData *)resetSizeOfImageData:(UIImage *)sourceImage maxSize:(NSInteger)maxSize;
@end
