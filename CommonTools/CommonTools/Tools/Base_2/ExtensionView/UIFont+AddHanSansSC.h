//
//  UIFont+AddHanSansSC.h
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/10/14.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HanSansSCType) {
	HanSansSCTypeRegular,      // 细体
	HanSansSCTypeMedium,    // 中体
	HanSansSCTypeBold,     // 粗体
    HanSansSCTypeItalic     // 斜体
};

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (AddHanSansSC)

+ (UIFont *)addHanSanSC:(CGFloat)fontSize fontType:(HanSansSCType)type;

@end

NS_ASSUME_NONNULL_END
