//
//  AuthorizationPart.m
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/10/21.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import "AuthorizationPart.h"

#import <Photos/Photos.h>

@implementation AuthorizationPart

+ (BOOL)judgePhotoLibraryAuthorization {
	/*
	 * PHAuthorizationStatusNotDetermined = 0, // 默认还没做出选择
	 * PHAuthorizationStatusRestricted,        // 此应用程序没有被授权访问的照片数据
	 * PHAuthorizationStatusDenied,            // 用户已经明确否认了这一照片数据的应用程序访问
	 * PHAuthorizationStatusAuthorized         //  用户已经授权应用访问照片数据
	 */
	PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
	if (status == PHAuthorizationStatusRestricted ||
		status == PHAuthorizationStatusDenied) {
		//无权限
		return NO;
	}
	return YES;
}

+ (BOOL)judgeMediaVideoAuthorization {
	/*
	 * AVAuthorizationStatusNotDetermined = 0,// 用户尚未做出选择这个应用程序的问候
	 * AVAuthorizationStatusRestricted,// 此应用程序没有被授权访问的照片数据。
	 * AVAuthorizationStatusDenied,// 用户已经明确否认了这一照片数据的应用程序访问
	 * AVAuthorizationStatusAuthorized// 用户已经授权应用访问照片数据
	 */
	AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
	if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
		//无权限
		return NO;
	}
	return YES;
}

+ (void)authorizationErrorShow:(UIViewController *)viewController reason:(NSString *)reason {
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:reason message:nil preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		[alert dismissViewControllerAnimated:YES completion:nil];
	}];
	[alert addAction:ok];
	[viewController presentViewController:alert animated:YES completion:nil];
}

@end
