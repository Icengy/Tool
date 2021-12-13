//
//  FKAlertController.h
//  ArtMedia2
//
//  Created by 刘洋 on 2020/10/23.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FKAlertController : UIViewController

- (void)showAlertWithController:(UIViewController *)controller title:(NSString *)title content:(NSString *)content sureClickBlock:(void(^)(void))sureClickBlock sureCompletion:(void(^)(void))sureCompletion;
- (void)showAlertWithController:(UIViewController *)controller title:(NSString *)title content:(NSString *)content cancelButtonTitle:(NSString *)cancelButtonTitle sureButtonTitle:(NSString *)sureButtonTitle sureClickBlock:(void(^)(void))sureClickBlock sureCompletion:(void(^)(void))sureCompletion;
@end

NS_ASSUME_NONNULL_END
