//
//  AuthorizationPart.h
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/10/21.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AuthorizationPart : NSObject


/**
 判断相册权限

 @return YES
 */
+ (BOOL)judgePhotoLibraryAuthorization;

/**
 判断相机权限

 @return YES
 */
+ (BOOL)judgeMediaVideoAuthorization;


+ (void)authorizationErrorShow:(UIViewController *)viewController reason:(NSString *)reason;

@end

NS_ASSUME_NONNULL_END
