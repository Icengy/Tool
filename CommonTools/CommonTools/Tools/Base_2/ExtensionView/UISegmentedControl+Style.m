//
//  UISegmentedControl+Style.m
//  ArtMedia2
//
//  Created by 美术传媒 on 2020/1/7.
//  Copyright © 2020 lcy. All rights reserved.
//

#import "UISegmentedControl+Style.h"

//#import <AppKit/AppKit.h>

@implementation UISegmentedControl (Style)

- (void)ensureiOS12Style {
    // UISegmentedControl has changed in iOS 13 and setting the tint
    // color now has no effect.
    if (isiOS13) {
        UIColor *tintColor = [self tintColor];
        UIImage *tintColorImage = [UIImage imageWithColor:tintColor];
        // Must set the background image for normal to something (even clear) else the rest won't work
        [self setBackgroundImage:[UIImage imageWithColor:self.backgroundColor ? self.backgroundColor : [UIColor clearColor]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [self setBackgroundImage:tintColorImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        [self setBackgroundImage:[UIImage imageWithColor:[tintColor colorWithAlphaComponent:0.2]] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [self setBackgroundImage:tintColorImage forState:UIControlStateSelected|UIControlStateSelected barMetrics:UIBarMetricsDefault];
        [self setDividerImage:tintColorImage forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    }
}


@end
