//
//  UIImageView+AMWebCache.m
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/11/15.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import "UIImageView+AMWebCache.h"

#import <UIImageView+WebCache.h>

@implementation UIImageView (AMWebCache)

#pragma mark -
- (void)am_setImageWithURL:(nullable NSString *)urlStr {
	[self am_setImageWithURL:urlStr placeholderImage:nil];
}

- (void)am_setImageWithURL:(nullable NSString *)urlStr contentMode:(UIViewContentMode)contentMode {
	[self am_setImageWithURL:urlStr placeholderImage:nil contentMode:contentMode completed:nil];
}

- (void)am_setImageWithURL:(nullable NSString *)urlStr placeholderImage:(nullable UIImage *)placeholder {
	[self am_setImageWithURL:urlStr placeholderImage:placeholder contentMode:UIViewContentModeScaleToFill completed:nil];
}

- (void)am_setImageWithURL:(nullable NSString *)urlStr placeholderImage:(nullable UIImage *)placeholder contentMode:(UIViewContentMode)contentMode {
	[self am_setImageWithURL:urlStr placeholderImage:placeholder contentMode:contentMode completed:nil];
}

- (void)am_setImageWithURL:(nullable NSString *)urlStr placeholderImage:(nullable UIImage *)placeholder completed:(nullable SDExternalCompletionBlock)completedBlock {
	[self am_setImageWithURL:urlStr placeholderImage:placeholder contentMode:UIViewContentModeScaleAspectFit completed:completedBlock];
}

- (void)am_setImageWithURL:(nullable NSString *)urlStr placeholderImage:(nullable UIImage *)placeholder contentMode:(UIViewContentMode)contentMode completed:(nullable SDExternalCompletionBlock)completedBlock {
    [self am_setImageWithURL:urlStr placeholderImage:placeholder thumbnailSize:CGSizeZero contentMode:contentMode completed:completedBlock];
}

- (void)am_setDetaultThumbnailImageWithURL:(nullable NSString *)urlStr placeholderImage:(nullable UIImage *)placeholder contentMode:(UIViewContentMode)contentMode {
    [self am_setImageWithURL:urlStr placeholderImage:placeholder thumbnailSize:CGSizeMake(K_Width, K_Width) contentMode:contentMode completed:nil];
}

#pragma mark -
- (void)am_setImageWithURL:(nullable NSString *)urlStr
          placeholderImage:(nullable UIImage *)placeholder
             thumbnailSize:(CGSize)thumbnailSize
               contentMode:(UIViewContentMode)contentMode
                 completed:(nullable SDExternalCompletionBlock)completedBlock {
    if ([placeholder isEqual:ImageNamed(@"logo")]) {
        self.contentMode = UIViewContentModeScaleAspectFit;
    }else {
        self.contentMode = UIViewContentModeCenter;
    }
    NSString *urlString = [ToolUtil getNetImageURLStringWith:urlStr];
    NSURL *url = [NSURL URLWithString:urlString];
    if (urlString && !CGSizeEqualToSize(thumbnailSize, CGSizeZero)) {
        NSString *new_urlStr = [NSString stringWithFormat:@"%@_%@x%@.%@",urlString.stringByDeletingPathExtension, @((NSInteger)thumbnailSize.width), @((NSInteger)thumbnailSize.height), urlString.pathExtension];
        url = [NSURL URLWithString:new_urlStr];
    }
    //        NSLog(@"url.absoluteString = %@",url.absoluteString);
    [self sd_setImageWithURL:url placeholderImage:placeholder completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!error) {
            self.contentMode = contentMode;
        }
        if (completedBlock) completedBlock(image, error, cacheType, imageURL);
    }];
}



#pragma mark - 按固定宽度压缩图片
- (void)am_setImageByCompress:(CGFloat)compressWidth withURL:(nullable NSString *)urlStr placeholderImage:(nullable UIImage *)placeholder contentMode:(UIViewContentMode)contentMode {
	__block CGFloat width = compressWidth;
	[self am_setImageWithURL:urlStr placeholderImage:placeholder contentMode:contentMode completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
		width = (width == 0)?720.0f:width;
		if (image) {
			self.image = [UIImage compressImageWith:image byCompress:compressWidth];
		}else
			self.image = placeholder;
	}];
}

- (void)am_setImageByDefaultCompressWithURL:(nullable NSString *)urlStr placeholderImage:(nullable UIImage *)placeholder {
	[self am_setImageByCompress:720.0f withURL:urlStr placeholderImage:placeholder contentMode:UIViewContentModeScaleAspectFit];
}

- (void)am_setImageByDefaultCompressWithURL:(nullable NSString *)urlStr placeholderImage:(nullable UIImage *)placeholder contentMode:(UIViewContentMode)contentMode {
	[self am_setImageByCompress:720.0f withURL:urlStr placeholderImage:placeholder contentMode:contentMode];
}

@end
