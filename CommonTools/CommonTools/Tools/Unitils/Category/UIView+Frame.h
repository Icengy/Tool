//
//  UIView+Frame.h
//  DingDingClient
//
//  Created by 刘 鹏 on 15/10/22.
//  Copyright © 2015年 SEU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

@end

@interface UIView (Corner)

/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGFloat)radii;



/// 设置部分圆角、边框(绝对布局)
/// @param corners 圆角位置
/// @param radii 圆角半径
/// @param borderColor 边框颜色
/// @param borderWitdh 边框宽度
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGFloat)radii
          withBorderColor:(UIColor *)borderColor
          withBorderWidth:(CGFloat)borderWitdh;

@end
