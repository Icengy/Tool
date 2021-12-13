//
//  UIImage+Ext.m
//  ESTicket
//
//  Created by phoenix on 14-10-10.
//  Copyright (c) 2014年 SEU. All rights reserved.
//

#import "UIImage+Ext.h"

@implementation UIImage (IdentifierAddition)

// 截取部分图像
- (UIImage*)getSubImage:(CGRect)rect
{
    //UIGraphicsBeginImageContextWithOptions(r.size, NO, [UIScreen mainScreen].scale);
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    //UIGraphicsBeginImageContextWithOptions(smallBounds.size, NO, [UIScreen mainScreen].scale);
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}

// 等比例缩放
- (UIImage*)scaleToSize:(CGSize)size
{
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1)
    {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }
    else
    {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

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
                         grayscaleRest:(BOOL)grayscaleRest
{
    const int alpha = 0;
    const int RED = 1;
    const int GREEN = 2;
    const int BLUE = 3;
    
    // Create image rectangle with current image width/height
    CGRect imageRect = CGRectMake(0, 0, self.size.width * self.scale, self.size.height * self.scale);
    
    int width = imageRect.size.width;
    int height = imageRect.size.height;
    
    // the pixels will be painted to this array
    uint32_t *pixels = (uint32_t *) malloc(width * height * sizeof(uint32_t));
    
    // clear the pixels so any transparency is preserved
    memset(pixels, 0, width * height * sizeof(uint32_t));
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // create a context with RGBA pixels
    CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, width * sizeof(uint32_t), colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    
    // paint the bitmap to our context which will fill in the pixels array
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [self CGImage]);
    
    int x_origin = vertical ? 0 : width * percentage;
    int y_to = vertical ? height * (1.f -percentage) : height;
    
    for(int y = 0; y < y_to; y++) {
        for(int x = x_origin; x < width; x++) {
            uint8_t *rgbaPixel = (uint8_t *) &pixels[y * width + x];
            
            if (grayscaleRest)
            {
                // convert to grayscale using recommended method: http://en.wikipedia.org/wiki/Grayscale#Converting_color_to_grayscale
                uint32_t gray = 0.3 * rgbaPixel[RED] + 0.59 * rgbaPixel[GREEN] + 0.11 * rgbaPixel[BLUE];
                
                // set the pixels to gray
                rgbaPixel[RED] = gray;
                rgbaPixel[GREEN] = gray;
                rgbaPixel[BLUE] = gray;
            }
            else
            {
                rgbaPixel[alpha] = 0;
                rgbaPixel[RED] = 0;
                rgbaPixel[GREEN] = 0;
                rgbaPixel[BLUE] = 0;
            }
        }
    }
    
    // create a new CGImageRef from our context with the modified pixels
    CGImageRef image = CGBitmapContextCreateImage(context);
    
    // we're done with the context, color space, and pixels
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(pixels);
    
    // make a new UIImage to return
    UIImage *resultUIImage = [UIImage imageWithCGImage:image
                                                 scale:self.scale
                                           orientation:UIImageOrientationUp];
    
    // we're done with image now too
    CGImageRelease(image);
    
    return resultUIImage;
}
//返回一张能自由拉伸的图片
+ (UIImage *)resizableImage:(NSString *)name
{
    return [self resizableImage:name leftRatio:0.5 topRatio:0.5];
}

+ (UIImage *)resizableImage:(NSString *)name leftRatio:(CGFloat)leftRatio topRatio:(CGFloat)topRatio
{
    UIImage *image = [self imageNamed:name];
    CGFloat left = image.size.width * leftRatio;
    CGFloat top = image.size.height * topRatio;
    return [image stretchableImageWithLeftCapWidth:left topCapHeight:top];
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
}

+ (UIImage *)imageWithHashString:(NSString *)hashString displayString:(NSString *)displayString
{
    return [self imageWithColor:[self colorWithString:hashString] string:displayString];
}

#pragma mark - Util
+ (UIColor *)colorWithString:(NSString *)string
{
    NSInteger length = string.length;
    NSInteger partLength = length / 3;
    NSString *part1, *part2, *part3;
    part1 = [string substringWithRange:NSMakeRange(0, partLength)];
    part2 = [string substringWithRange:NSMakeRange(partLength, partLength)];
    part3 = [string substringWithRange:NSMakeRange(partLength * 2, partLength)];
    CGFloat hue = [self hashNumberFromString:part3] % 256 / 256.0;
    CGFloat saturation = [self hashNumberFromString:part2] % 128 / 256.0 + 0.5;
    CGFloat brightness = [self hashNumberFromString:part1] % 128 / 256.0 + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

+ (UIImage *)imageWithColor:(UIColor *)color string:(NSString *)string
{
    CGSize size = CGSizeMake(50, 50);
    CGFloat radius = 4;
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [[UIBezierPath bezierPathWithRoundedRect:rect
                                cornerRadius:radius] addClip];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIFont *font = [UIFont systemFontOfSize:30];
    CGFloat yOffset = (rect.size.height - font.pointSize) / 2.0 - 3;
    CGRect textRect = CGRectMake(0, yOffset, rect.size.width, rect.size.height - yOffset);
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    if (string.length != 0) {
        [string drawInRect:textRect withAttributes:@{ NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle, NSForegroundColorAttributeName:[UIColor whiteColor] }];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (NSUInteger)hashNumberFromString:(NSString *)string
{
    NSInteger hash = string.hash;
    if (hash < 0) {
        return -hash;
    }
    else {
        return hash;
    }
}

+ (NSData *)compressImageSize:(UIImage *)image toByte:(NSUInteger)maxLength{
	NSData *data = UIImageJPEGRepresentation(image, 1);
	if (data.length < maxLength) return data;
	
	CGFloat compression = 230400.0 / data.length;
	
	data = UIImageJPEGRepresentation(image, compression);
	
	return data;
}

+ (UIImage *)newSizeImage:(CGSize)size image:(UIImage *)sourceImage {
	CGSize newSize = CGSizeMake(sourceImage.size.width, sourceImage.size.height);
	
	CGFloat tempHeight = newSize.height / size.height;
	CGFloat tempWidth = newSize.width / size.width;
	
	if (tempWidth > 1.0 && tempWidth > tempHeight) {
		newSize = CGSizeMake(sourceImage.size.width / tempWidth, sourceImage.size.height / tempWidth);
	} else if (tempHeight > 1.0 && tempWidth < tempHeight) {
		newSize = CGSizeMake(sourceImage.size.width / tempHeight, sourceImage.size.height / tempHeight);
	}
	
	UIGraphicsBeginImageContext(newSize);
	[sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

+ (NSData *)halfFuntion:(NSArray *)arr image:(UIImage *)image sourceData:(NSData *)finallImageData maxSize:(NSInteger)maxSize {
	NSData *tempData = [NSData data];
	NSUInteger start = 0;
	NSUInteger end = arr.count - 1;
	NSUInteger index = 0;
	
	NSUInteger difference = NSIntegerMax;
	while(start <= end) {
		index = start + (end - start)/2;
		
		finallImageData = UIImageJPEGRepresentation(image,[arr[index] floatValue]);
		
		NSUInteger sizeOrigin = finallImageData.length;
		NSUInteger sizeOriginKB = sizeOrigin / 1024;
		NSLog(@"当前降到的质量：%ld", (unsigned long)sizeOriginKB);
		NSLog(@"\nstart：%zd\nend：%zd\nindex：%zd\n压缩系数：%lf", start, end, (unsigned long)index, [arr[index] floatValue]);
		
		if (sizeOriginKB > maxSize) {
			start = index + 1;
		} else if (sizeOriginKB < maxSize) {
			if (maxSize-sizeOriginKB < difference) {
				difference = maxSize-sizeOriginKB;
				tempData = finallImageData;
			}
			if (index<=0) {
				break;
			}
			end = index - 1;
		} else {
			break;
		}
	}
	return tempData;
}

+ (NSData *)resetSizeOfImageData:(UIImage *)sourceImage maxSize:(NSInteger)maxSize {
	//先判断当前质量是否满足要求，不满足再进行压缩
	__block NSData *finallImageData = UIImageJPEGRepresentation(sourceImage,1.0);
	NSUInteger sizeOrigin   = finallImageData.length;
	NSUInteger sizeOriginKB = sizeOrigin / 1024;
	
	if (sizeOriginKB <= maxSize) {
		return finallImageData;
	}
	
	//获取原图片宽高比
	CGFloat sourceImageAspectRatio = sourceImage.size.width/sourceImage.size.height;
	//先调整分辨率
	CGSize defaultSize = CGSizeMake(1024, 1024/sourceImageAspectRatio);
	UIImage *newImage = [self newSizeImage:defaultSize image:sourceImage];
	
	finallImageData = UIImageJPEGRepresentation(newImage,1.0);
	
	//保存压缩系数
	NSMutableArray *compressionQualityArr = [NSMutableArray array];
	CGFloat avg   = 1.0/250;
	CGFloat value = avg;
	for (int i = 250; i >= 1; i--) {
		value = i*avg;
		[compressionQualityArr addObject:@(value)];
	}
	
	/*
	 调整大小
	 说明：压缩系数数组compressionQualityArr是从大到小存储。
	 */
	//思路：使用二分法搜索
	finallImageData = [self halfFuntion:compressionQualityArr image:newImage sourceData:finallImageData maxSize:maxSize];
	//如果还是未能压缩到指定大小，则进行降分辨率
	while (finallImageData.length == 0) {
		//每次降100分辨率
		CGFloat reduceWidth = 100.0;
		CGFloat reduceHeight = 100.0/sourceImageAspectRatio;
		if (defaultSize.width-reduceWidth <= 0 || defaultSize.height-reduceHeight <= 0) {
			break;
		}
		defaultSize = CGSizeMake(defaultSize.width-reduceWidth, defaultSize.height-reduceHeight);
		UIImage *image = [self newSizeImage:defaultSize
									  image:[UIImage imageWithData:UIImageJPEGRepresentation(newImage,[[compressionQualityArr lastObject] floatValue])]];
		finallImageData = [self halfFuntion:compressionQualityArr image:image sourceData:UIImageJPEGRepresentation(image,1.0) maxSize:maxSize];
	}
	return finallImageData;
}

@end
