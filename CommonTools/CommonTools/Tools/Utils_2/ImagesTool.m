//
//  ImagesTool.m
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/10/30.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import "ImagesTool.h"

@implementation ImagesTool

#pragma mark - 压图片
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size {
	UIImage *OriginalImage = image;
	
	// 执行这句代码之后会有一个范围 例如500m 会是 100m～500k
	NSData * data = UIImageJPEGRepresentation(image, 1.0);
	CGFloat dataKBytes = data.length/1000.0;
	CGFloat maxQuality = 0.9f;
	
	// 执行while循环 如果第一次压缩不会小雨100k 那么减小尺寸在重新开始压缩
	while (dataKBytes > size)
	{
		while (dataKBytes > size && maxQuality > 0.1f)
		{
			maxQuality = maxQuality - 0.1f;
			data = UIImageJPEGRepresentation(image, maxQuality);
			dataKBytes = data.length / 1000.0;
			if(dataKBytes <= size)
			{
				return data;
			}
		}
		OriginalImage =[ImagesTool compressOriginalImage:OriginalImage toWidth:OriginalImage.size.width * 0.1];
		image = OriginalImage;
		data = UIImageJPEGRepresentation(image, 1.0);
		dataKBytes = data.length / 1000.0;
		maxQuality = 0.9f;
	}
	NSLog(@"compressOriginalImage = %.2f",data.length/1000.0);
	return data;
}

//+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size withObjectSize:(CGSize)imagesize {
//	UIImage *OriginalImage = image;
//
//	// 执行这句代码之后会有一个范围 例如500m 会是 100m～500k
//	NSData * data = UIImageJPEGRepresentation(image, 1.0);
//	CGFloat dataKBytes = data.length/1000.0;
//	CGFloat maxQuality = 0.9f;
//
//	// 执行while循环 如果第一次压缩不会小雨100k 那么减小尺寸在重新开始压缩
//	while (dataKBytes > size)
//	{
//		while (dataKBytes > size && maxQuality > 0.1f)
//		{
//			maxQuality = maxQuality - 0.1f;
//			data = UIImageJPEGRepresentation(image, maxQuality);
//			dataKBytes = data.length / 1000.0;
//			if(dataKBytes <= size)
//			{
//				return data;
//			}
//		}
//		OriginalImage =[ImagesTool compressOriginalImage:OriginalImage toWidth:OriginalImage.size.width * 0.1];
//		image = OriginalImage;
//		data = UIImageJPEGRepresentation(image, 1.0);
//		dataKBytes = data.length / 1000.0;
//		maxQuality = 0.9f;
//	}
//	NSLog(@"compressOriginalImage = %.2f",data.length/1000.0);
//	return data;
//}

#pragma mark - 改变图片的大小
+ (UIImage *)compressOriginalImage:(UIImage *)image toWidth:(CGFloat)targetWidth
{
	CGSize imageSize = image.size;
	CGFloat Originalwidth = imageSize.width;
	CGFloat Originalheight = imageSize.height;
	CGFloat targetHeight = Originalheight / Originalwidth * targetWidth;
	UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
	[image drawInRect:CGRectMake(0,0,targetWidth,  targetHeight)];
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

#pragma mark - 将网络图片压缩至指定大小
+ (NSData *)compressOriginalNetImage:(NSString *)imageStr toMaxDataSizeKBytes:(CGFloat)size {
	
	if (imageStr && imageStr.length && ![imageStr hasPrefix:@"http"]) {
		imageStr = [NSString stringWithFormat:@"%@%@",IMAGE_HOST, imageStr];
	}
	
	UIImage *result;
	NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageStr]];
	result = [UIImage imageWithData:data];
	if (data && data.length) {
		return [ImagesTool compressOriginalImage:result toMaxDataSizeKBytes:size];
	}
	NSLog(@"UIImagePNGRepresentation = %.2f",UIImagePNGRepresentation(ImageNamed(@"logo")).length/1000.0);
	return UIImagePNGRepresentation(ImageNamed(@"logo"));
}

+ (NSData *)compressOriginalImageForShare:(NSString *)imageStr {
	return [ImagesTool compressOriginalNetImage:imageStr toMaxDataSizeKBytes:32.0f];
}

@end
