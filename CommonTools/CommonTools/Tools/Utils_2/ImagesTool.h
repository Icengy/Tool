//
//  ImagesTool.h
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/10/30.
//  Copyright © 2019年 lcy. All rights reserved.
//
// 图片压缩
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImagesTool : NSObject


/**
 将图片压缩至指定大小

 @param image image
 @param size 指定大小（KB）
 @return 压缩后的imageData
 */
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size;

/**
 改变图片的大小

 @param image image
 @param targetWidth 指定宽度，高度等比
 @return image
 */
+ (UIImage *)compressOriginalImage:(UIImage *)image toWidth:(CGFloat)targetWidth;

/**
 将网络图片压缩至指定大小

 @param imageStr 图片链接
 @param size size 指定大小（KB）
 @return 压缩后的imageData
 */
+ (NSData *)compressOriginalNetImage:(NSString *)imageStr toMaxDataSizeKBytes:(CGFloat)size;

/**
 将网络图片压缩至指定大小--分享(32KB)

 @param imageStr 图片链接
 @return 压缩后的imageData
 */
+ (NSData *)compressOriginalImageForShare:(NSString *)imageStr;

@end

NS_ASSUME_NONNULL_END
