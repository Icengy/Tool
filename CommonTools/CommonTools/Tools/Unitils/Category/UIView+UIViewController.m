//
//  UIView+UIViewController.m
//  DingDing
//
//  Created by 丁丁 on 15/8/17.
//  Copyright (c) 2015年 Adele. All rights reserved.
//

#import "UIView+UIViewController.h"

@implementation UIView (UIViewController)

- (UIViewController *)viewController {
    UIResponder *next = self.nextResponder;
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    } while (next);
    return nil;
}
@end
