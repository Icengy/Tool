//
//  UIView+Frame.m
//  DingDingClient
//
//  Created by 刘 鹏 on 15/10/22.
//  Copyright © 2015年 SEU. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}
@end


@implementation UIView (Corner)

///设置部分圆角(绝对布局)
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGFloat)radii {
    
    if (@available(iOS 11.0, *)) {
        self.layer.cornerRadius = radii;
        self.layer.maskedCorners = (CACornerMask)corners;
//        self.layer.masksToBounds = YES;
        self.clipsToBounds = YES;
    } else {
        UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radii, radii)];
        CAShapeLayer* shape = [[CAShapeLayer alloc] init];
        shape.frame = self.bounds;
        [shape setPath:rounded.CGPath];
        
        self.layer.mask = shape;
    }
}


///设置部分圆角、边框(绝对布局)
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGFloat)radii
          withBorderColor:(UIColor *)borderColor
          withBorderWidth:(CGFloat)borderWitdh {
    
    if (@available(iOS 11.0, *)) {
        self.layer.cornerRadius = radii;
        self.layer.maskedCorners = (CACornerMask)corners;
        self.layer.borderColor = borderColor.CGColor;
        self.layer.borderWidth = borderWitdh;
//        self.layer.masksToBounds = YES;
        self.clipsToBounds = YES;
    } else {
        UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radii, radii)];
        CAShapeLayer* shape = [[CAShapeLayer alloc] init];
        shape.frame = self.bounds;
        [shape setPath:rounded.CGPath];
        [shape setBorderColor:borderColor.CGColor];
        [shape setBorderWidth:borderWitdh];
        
        self.layer.mask = shape;
    }
}

@end
