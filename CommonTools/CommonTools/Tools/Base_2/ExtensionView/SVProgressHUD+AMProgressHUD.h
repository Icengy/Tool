//
//  SVProgressHUD+AMProgressHUD.h
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/12/24.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface SVProgressHUD (AMProgressHUD)

+ (void)showSuccess:(nullable NSString *)status;
+ (void)showSuccess:(nullable NSString *)status completion:(nullable SVProgressHUDDismissCompletion)completion;

+ (void)showError:(nullable NSString *)status;
+ (void)showError:(nullable NSString *)status completion:(nullable SVProgressHUDDismissCompletion)completion;

+ (void)showMsg:(nullable NSString *)status;
+ (void)showMsg:(nullable NSString *)status completion:(nullable SVProgressHUDDismissCompletion)completion;

@end

NS_ASSUME_NONNULL_END
