//
//  SVProgressHUD+AMProgressHUD.m
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/12/24.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import "SVProgressHUD+AMProgressHUD.h"

@implementation SVProgressHUD (AMProgressHUD)

+ (void)showSuccess:(nullable NSString *)status completion:(nullable SVProgressHUDDismissCompletion)completion {
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD setHapticsEnabled:YES];
        [SVProgressHUD showSuccessWithStatus:status];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD dismissWithDelay:1 completion:completion];
    });
}

+ (void)showSuccess:(nullable NSString *)status {
	[SVProgressHUD showSuccess:status completion:nil];
}

+ (void)showError:(nullable NSString *)status completion:(nullable SVProgressHUDDismissCompletion)completion {
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD setHapticsEnabled:YES];
        [SVProgressHUD showErrorWithStatus:status];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD dismissWithDelay:1 completion:completion];
    });
}

+ (void)showError:(nullable NSString *)status {
	[SVProgressHUD showError:status completion:nil];
}

+ (void)showMsg:(nullable NSString *)status completion:(nullable SVProgressHUDDismissCompletion)completion {
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD setHapticsEnabled:YES];
        [SVProgressHUD showInfoWithStatus:status];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD dismissWithDelay:1 completion:completion];
    });
}

+ (void)showMsg:(nullable NSString *)status {
	[SVProgressHUD showMsg:status completion:nil];
}

@end
