//
//  UIWindow+Visible.m
//  ESTicket
//
//  Created by 王帅 on 16/8/16.
//  Copyright © 2016年 鹏 刘. All rights reserved.
//

#import "UIWindow+Visible.h"

@implementation UIWindow (Visible)

- (UIViewController *)visibleViewController {
    UIViewController *rootViewController =[[[[UIApplication sharedApplication] delegate] window] rootViewController];
    return [UIWindow getVisibleViewControllerFrom:rootViewController];
}

+ (UIViewController *) getVisibleViewControllerFrom:(UIViewController *) vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [UIWindow getVisibleViewControllerFrom:[((UINavigationController *) vc) visibleViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [UIWindow getVisibleViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    } else {
        if (vc.presentedViewController) {
            return [UIWindow getVisibleViewControllerFrom:vc.presentedViewController];
        } else {
            return vc;
        }
    }
    
}

@end
