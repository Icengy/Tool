//
//  UIImageView+AMWebCache.h
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/11/15.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (AMWebCache)


#pragma mark - 使用原图
- (void)am_setImageWithURL:(nullable NSString *)urlStr;
- (void)am_setImageWithURL:(nullable NSString *)urlStr
               contentMode:(UIViewContentMode)contentMode;

- (void)am_setImageWithURL:(nullable NSString *)urlStr
          placeholderImage:(nullable UIImage *)placeholder;
- (void)am_setImageWithURL:(nullable NSString *)urlStr
          placeholderImage:(nullable UIImage *)placeholder
               contentMode:(UIViewContentMode)contentMode;

- (void)am_setImageWithURL:(nullable NSString *)urlStr
          placeholderImage:(nullable UIImage *)placeholder
                 completed:(nullable SDExternalCompletionBlock)completedBlock;
- (void)am_setImageWithURL:(nullable NSString *)urlStr
          placeholderImage:(nullable UIImage *)placeholder
               contentMode:(UIViewContentMode)contentMode
                 completed:(nullable SDExternalCompletionBlock)completedBlock;
#pragma mark - 使用缩略图<默认尺寸为（K_Width x K_Width）>
- (void)am_setDetaultThumbnailImageWithURL:(nullable NSString *)urlStr
                          placeholderImage:(nullable UIImage *)placeholder
                               contentMode:(UIViewContentMode)contentMode;

#pragma mark - 全功能
/// 全功能加载网络图片
/// @param urlStr 图片地址(未拼接)
/// @param placeholder 占位符
/// @param thumbnailSize 缩略图尺寸
/// @param contentMode 填充模式
/// @param completedBlock 完成block
- (void)am_setImageWithURL:(nullable NSString *)urlStr
          placeholderImage:(nullable UIImage *)placeholder
             thumbnailSize:(CGSize)thumbnailSize
               contentMode:(UIViewContentMode)contentMode
                 completed:(nullable SDExternalCompletionBlock)completedBlock;

#pragma mark - 按固定宽度压缩图片
- (void)am_setImageByCompress:(CGFloat)compressWidth withURL:(nullable NSString *)urlStr placeholderImage:(nullable UIImage *)placeholder contentMode:(UIViewContentMode)contentMode;

- (void)am_setImageByDefaultCompressWithURL:(nullable NSString *)urlStr placeholderImage:(nullable UIImage *)placeholder;
- (void)am_setImageByDefaultCompressWithURL:(nullable NSString *)urlStr placeholderImage:(nullable UIImage *)placeholder contentMode:(UIViewContentMode)contentMode;

@end

NS_ASSUME_NONNULL_END
