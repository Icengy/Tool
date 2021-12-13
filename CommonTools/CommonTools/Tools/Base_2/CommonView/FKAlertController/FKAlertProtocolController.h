//
//  FKAlertProtocolController.h
//  ArtMedia2
//
//  Created by 刘洋 on 2020/11/2.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FKAlertProtocolController : UIViewController
- (void)showAlertWithController:(UIViewController *)controller title:(NSString *)title content:(NSString *)content protocolText:(NSString *)protocolText sureClickBlock:(void(^)(BOOL selectProtocol))sureClickBlock sureCompletion:(void(^)(void))sureCompletion;
- (void)showAlertWithController:(UIViewController *)controller title:(NSString *)title content:(NSString *)content protocolText:(NSString *)protocolText cancelButtonTitle:(NSString *)cancelButtonTitle sureButtonTitle:(NSString *)sureButtonTitle sureClickBlock:(void(^)(BOOL selectProtocol))sureClickBlock sureCompletion:(void(^)(void))sureCompletion;
@end

NS_ASSUME_NONNULL_END
