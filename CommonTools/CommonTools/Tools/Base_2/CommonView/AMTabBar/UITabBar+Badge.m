//
//  UITabBar+Badge.m
//  ArtMedia2
//
//  Created by icnengy on 2020/5/25.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "UITabBar+Badge.h"

#define TabbarItemNums 5.0

@implementation UITabBar (Badge)

// 显示红点
- (void)showBadgeOnItemIndex:(NSInteger)index {
    
    [self removeBadgeOnItemIndex:index];
    // 新建小红点
    UIView *bview = [[UIView alloc]init];
    bview.tag = 888 + index;
    bview.layer.cornerRadius = 3.0f;
    bview.clipsToBounds = YES;
    bview.backgroundColor = RGB(219, 17, 17);
    
    CGRect tabFram = self.frame;
    float percentX = (index+0.5) / TabbarItemNums;
    
    CGFloat x = ceilf(percentX * tabFram.size.width + 10.0f);
    CGFloat y = ceilf(0.1 * tabFram.size.height);
    bview.frame = CGRectMake(x, y, 6.0f, 6.0f);
    [self addSubview:bview];
    [self bringSubviewToFront:bview];
}

// 隐藏红点
- (void)hideBadgeOnItemIndex:(NSInteger)index {
    [self removeBadgeOnItemIndex:index];
}

// 移除控件
- (void)removeBadgeOnItemIndex:(NSInteger)index {
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888 + index) {
            [subView removeFromSuperview];
        }
    }
}

@end
