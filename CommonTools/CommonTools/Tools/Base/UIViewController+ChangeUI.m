//
//  UIViewController+ChangeUI.m
//  Gallop_iOS
//
//  Created by lixuanye on 2019/10/28.
//  Copyright © 2019 homosum. All rights reserved.
//

#import "UIViewController+ChangeUI.h"

@implementation UIViewController (ChangeUI)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod([self class], @selector(presentViewController:animated:completion:)), class_getInstanceMethod([self class], @selector(myPresentViewController:animated:completion:)));
    });
}

- (void)myPresentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    //设置满屏，不需要小卡片
    if(@available(iOS 13.0, *)) {
		if (viewControllerToPresent.modalPresentationStyle != UIModalPresentationCustom) {
			viewControllerToPresent.modalPresentationStyle = UIModalPresentationOverCurrentContext;
		}
    }
    [self myPresentViewController:viewControllerToPresent animated:flag completion:completion];
}
@end
