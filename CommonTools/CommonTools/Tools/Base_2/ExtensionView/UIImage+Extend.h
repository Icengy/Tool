//
//  UIImage+Extend.h
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/11/21.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GradientType) {
	GradientFromTopToBottom = 1,            //从上到下
	GradientFromLeftToRight,                //从做到右
	GradientFromLeftTopToRightBottom,       //从上到下
	GradientFromLeftBottomToRightTop        //从上到下
};

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extend)

+ (CGSize)getImageSizeWithURLForUnDownload:(NSString *)urlStr;

+ (CGSize)getImageSizeWithURL:(NSString *)urlStr;

+ (UIImage *)compressImageWith:(UIImage *)image byCompress:(CGFloat)compressWidth;

//改变图片大小
+ (UIImage *)scale:(UIImage *)image toSize:(CGSize)size;

/// 添加高斯模糊 blur：模糊度
+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

@end

NS_ASSUME_NONNULL_END
