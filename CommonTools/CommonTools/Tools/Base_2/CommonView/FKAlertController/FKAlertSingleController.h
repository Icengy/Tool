//
//  FKAlertSingleController.h
//  ArtMedia2
//
//  Created by 刘洋 on 2020/11/2.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FKAlertSingleController : UIViewController
- (void)showAlertWithController:(UIViewController *)controller title:(NSString *)title content:(NSString *)content sureClickBlock:(void(^)(void))sureClickBlock sureCompletion:(void(^)(void))sureCompletion;
- (void)showAlertWithController:(UIViewController *)controller title:(NSString *)title content:(NSString *)content sureButtonTitle:(NSString *)sureButtonTitle sureClickBlock:(void(^)(void))sureClickBlock sureCompletion:(void(^)(void))sureCompletion;
@end

NS_ASSUME_NONNULL_END
