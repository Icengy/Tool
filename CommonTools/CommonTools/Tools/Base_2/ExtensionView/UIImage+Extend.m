//
//  UIImage+Extend.m
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/11/21.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import "UIImage+Extend.h"

#import <Accelerate/Accelerate.h>

@implementation UIImage (Extend)

+ (CGSize)getImageSizeWithURLForUnDownload:(NSString *)urlStr {
    if (![ToolUtil isEqualToNonNull:urlStr ]) {
        return CGSizeZero;
    }
    NSURL *url = nil;
    if ([urlStr hasPrefix:@"https://"] || [urlStr hasPrefix:@"http://"]) {
        url = [NSURL URLWithString:urlStr];
    }else
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", IMAGE_HOST ,urlStr]];
    
    CGImageSourceRef imageSourceRef =     CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    CGFloat width = 0, height = 0;
    if (imageSourceRef) {
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL);
        if (imageProperties != NULL) {
            CFNumberRef widthNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
#if defined(__LP64__) && __LP64__
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
            }
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
            }
#else
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat32Type, &width);
            }
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat32Type, &height);
            }
#endif
            CFRelease(imageProperties);
        }
    }
    return CGSizeMake(width, height);
}

+ (CGSize)getImageSizeWithURL:(NSString *)urlStr {
    if (![ToolUtil isEqualToNonNull:urlStr ]) {
        return CGSizeZero;
    }
    NSURL *url = nil;
    if ([urlStr hasPrefix:@"https://"] || [urlStr hasPrefix:@"http://"]) {
        url = [NSURL URLWithString:urlStr];
    }else
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", IMAGE_HOST ,urlStr]];
    
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:imageData];
    return image.size;
}

+ (UIImage *)compressImageWith:(UIImage *)image byCompress:(CGFloat)compressWidth {
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    float height = image.size.height/(image.size.width/compressWidth);
    float widthScale = imageWidth /compressWidth;
    float heightScale = imageHeight /height;
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(compressWidth, height));
    
    if (widthScale > heightScale) {
        [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }else {
        [image drawInRect:CGRectMake(0, 0, compressWidth , imageHeight /widthScale)];
    }
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)scale:(UIImage *)image toSize:(CGSize)size; {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

#pragma mark -
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark -
+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur {
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = image.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);

    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,outBuffer.width,outBuffer.height,outBuffer.rowBytes,outBuffer.rowBytes ,colorSpace,kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    return returnImage;
}

@end
