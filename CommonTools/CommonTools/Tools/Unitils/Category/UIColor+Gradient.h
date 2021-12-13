//
//  UIColor+Gradient.h
//  Gallop_iOS
//
//  Created by lixuanye on 2019/7/18.
//  Copyright © 2019 homosum. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,ZQGradientChangeDirection) {
    ZQGradientChangeDirectionLevel, //水平方向渐变
    ZQGradientChangeDirectionVertical,  //垂直方向渐变
    ZQGradientChangeDirectionUpwardDiagonalLine,    //主对角线方向渐变
    ZQGradientChangeDirectionDownDiagonalLine,  //副对角线方向渐变
};

@interface UIColor (Gradient)
/*
 size:渐变区域的尺寸
 direction:渐变方向
 startColor:开始颜色
 endColor:结束颜色
 */
+ (instancetype)bm_colorGradientChangeWithSize:(CGSize)size
                                     direction:(ZQGradientChangeDirection)direction
                                    startColor:(UIColor*)startcolor
                                      endColor:(UIColor*)endColor;
@end

NS_ASSUME_NONNULL_END
