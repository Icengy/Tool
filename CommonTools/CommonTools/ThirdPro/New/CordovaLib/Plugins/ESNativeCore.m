//
//  ESNativeCore.m
//  EduSoho
//
//  Created by Edusoho on 15/6/23.
//  Copyright (c) 2015年 Kuozhi Network Technology. All rights reserved.
//

#import "ESNativeCore.h"
#import "ZLPhotoPickerBrowserViewController.h"
#import "ESBaseWebviewController.h"
#import "ESChatViewController.h"
#import "ESAskQuestionController.h"
#import "ESQuestionViewController.h"
#import "ESMSettingsViewController.h"
#import "ESUserData.h"
#import "ESSocialSDK.h"
#import "ESNetAPIClient.h"
#import "ESLessonDownloadController.h"
#import "ESMessageManager.h"
#import "ESMBalanceController.h"
#import "ESQuestionData.h"
#import "ESCInfoViewController.h"
#import "ESMLoginViewController.h"
#import "RTRootNavigationController.h"
#import "ESCourseData.h"
#import "ESClassroomData.h"
#import "ESCourseViewController.h"
#import "ESPublicCourseDetailViewController.h"
#import "TXLivePlayViewController.h"
#import "ESCoinIAPViewController.h"
#import "ESIAPViewController.h"
#import <StoreKit/StoreKit.h>
#import "NSString+XHMD5.h"

@interface ESNativeCore ()

@property (nonatomic, strong) NSArray *imageURLs;

@end

@implementation ESNativeCore

- (void)openNativeOpenCourseDetailPage:(CDVInvokedUrlCommand *)command {
    
    NSString *courseID = command.arguments[0];
    if (courseID) {
        ESPublicCourseDetailViewController *publicCourseDetailVC = [[ESPublicCourseDetailViewController alloc] initWithCourseID:courseID];
        publicCourseDetailVC.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:publicCourseDetailVC animated:YES];
    }
    
}

- (void)openNativeLivePlay:(CDVInvokedUrlCommand *)command{
	
	NSString *playUrl = command.arguments[0];
	TXLivePlayViewController *livePlayVC = [[TXLivePlayViewController alloc] initWithPlayUrl:playUrl];
	livePlayVC.hidesBottomBarWhenPushed = YES;
	[self.viewController.navigationController pushViewController:livePlayVC animated:YES];
}

- (void)openNativeCourseDetailPage:(CDVInvokedUrlCommand *)command {
    ESCourseData *courseData = [[ESCourseData alloc] init];
    courseData.courseId = command.arguments[0];
    ESCourseViewController *courseVC = [[ESCourseViewController alloc] initWithCourseData:courseData];
    courseVC.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:courseVC animated:YES];
}

- (void)openNativeCoinIAPPage:(CDVInvokedUrlCommand *)command {
//	ESCourseData *courseData = [[ESCourseData alloc] init];
//	courseData.courseId = command.arguments[0];
//	ESCourseViewController *courseVC = [[ESCourseViewController alloc] initWithCourseData:courseData];
//	courseVC.hidesBottomBarWhenPushed = YES;
//	[self.viewController.navigationController pushViewController:courseVC animated:YES];
//	CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
//													  messageAsString:@"jsonString"];
//	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
	
	ESCoinIAPViewController *iapView = [[ESCoinIAPViewController alloc] init];
	iapView.hidesBottomBarWhenPushed = YES;
	iapView.payComplete = ^(BOOL payStatus) {
		CDVPluginResult *pluginResult;
		if(payStatus){
			pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
															  messageAsString:@"YES"];
		}else{
			pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
															  messageAsString:@"NO"];
		}
		[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
	};
	[self.viewController.navigationController pushViewController:iapView animated:YES];
}

- (void)openNativeVipIAPPage:(CDVInvokedUrlCommand *)command {
	if ([ESTools shouldLoginFirstByPresentingView:YES]) {
		return;
	}
	UIDevice *myDevice = [UIDevice currentDevice];
	NSString *nickNameWihtUDID = [NSString stringWithFormat:@"游客%@", [[[myDevice identifierForVendor] UUIDString] MD5Hash]];
	if ([nickNameWihtUDID containsString:[ESConfig sharedConfig].userData.nickname]) {
		[UIAlertController showAlertInViewController:self.viewController withTitle:@"警告" message:@"游客帐号充值可能会造成不必要的困扰，建议您注册并使用自己的帐号进行充值" cancelButtonTitle:@"取消" destructiveButtonTitle:@"继续" otherButtonTitles:nil tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
			if (buttonIndex) {
				if ([SKPaymentQueue canMakePayments]) {
					ESIAPViewController *iapView = [[ESIAPViewController alloc] init];
					iapView.hidesBottomBarWhenPushed = YES;
					iapView.payComplete = ^(BOOL payStatus) {
						CDVPluginResult *pluginResult;
						if(payStatus){
							pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
															 messageAsString:@"YES"];
						}else{
							pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
															 messageAsString:@"NO"];
						}
						[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
					};
					[self.viewController.navigationController pushViewController:iapView animated:YES];
				} else {
					[[ESHUDView sharedInstance] showErrorMessage:NSLocalizedString(@"不支持支付", nil) dismissBlock:nil];
				}
			}
		}];
	}else{
		if ([SKPaymentQueue canMakePayments]) {
			ESIAPViewController *iapView = [[ESIAPViewController alloc] init];
			iapView.hidesBottomBarWhenPushed = YES;
			iapView.payComplete = ^(BOOL payStatus) {
				CDVPluginResult *pluginResult;
				if(payStatus){
					pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
													 messageAsString:@"YES"];
				}else{
					pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
													 messageAsString:@"NO"];
				}
				[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
			};
			[self.viewController.navigationController pushViewController:iapView animated:YES];
		} else {
			[[ESHUDView sharedInstance] showErrorMessage:NSLocalizedString(@"不支持支付", nil) dismissBlock:nil];
		}
	}

}

- (void)openNativeClassroomDetailPage:(CDVInvokedUrlCommand *)command {
    ESClassroomData *classroomData = [[ESClassroomData alloc] init];
    classroomData.classroomIdentifier = command.arguments[0];
    ESCourseViewController *classroomVC = [[ESCourseViewController alloc] initWithClassroomData:classroomData];
    classroomVC.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:classroomVC animated:YES];
}

- (void)showImages:(CDVInvokedUrlCommand *)command {
    CDVPluginResult *pluginResult = nil;
    _imageURLs = command.arguments[1];
    NSInteger imageIndex = [command.arguments[0] integerValue];
    if (imageIndex >=0 && _imageURLs && [_imageURLs count]) {
        ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
        pickerBrowser.editing = NO;
        pickerBrowser.status = UIViewAnimationAnimationStatusFade;
        pickerBrowser.currentIndex = imageIndex;
        NSMutableArray *tempData = [NSMutableArray arrayWithCapacity:[_imageURLs count]];
        for (NSString *url in _imageURLs) {
            ZLPhotoPickerBrowserPhoto *photoView = [ZLPhotoPickerBrowserPhoto photoAnyImageObjWith:url];
            [tempData addObject:photoView];
        }
        pickerBrowser.photos = tempData;
        [self.viewController presentViewController:pickerBrowser animated:YES completion:^{
            [[UIApplication sharedApplication] setStatusBarHidden:YES];
        }];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

- (void)openDrawer:(CDVInvokedUrlCommand *)command {
//    CDVPluginResult *pluginResult = nil;
//    if ([command.arguments[0] isEqualToString:@"open"]) {
//        [self.viewController.frostedViewController presentMenuViewController];
//        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
//    } else {
//        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
//    }
//    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getUserToken:(CDVInvokedUrlCommand *)command {
    CDVPluginResult *pluginResult = nil;
    if ([ESConfig sharedConfig].userToken && [ESConfig sharedConfig].userData) {
        [[NSNotificationCenter defaultCenter] addObserver:self.viewController selector:@selector(reloadCurrentWebView:) name:Notification_UserLogout object:nil];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:@{@"token": [ESConfig sharedConfig].userToken, @"user": [[MTLJSONAdapter JSONDictionaryFromModel:[ESConfig sharedConfig].userData error:nil] objectForKey:@"user"]}];
    } else {
        [[NSNotificationCenter defaultCenter] addObserver:self.viewController selector:@selector(reloadCurrentWebView:) name:Notification_UserLogin object:nil];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)saveUserToken:(CDVInvokedUrlCommand *)command {
    NSString *tokenString = command.arguments[1];
    NSDictionary *userDict = command.arguments[0];
    if (!tokenString || !userDict) {
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK]
                                    callbackId:command.callbackId];
    } else {
        NSDictionary *JSONDict = @{@"user": command.arguments[0], @"token": tokenString};
        NSError *error = nil;
        ESUserData *userData = [MTLJSONAdapter modelOfClass:[ESUserData class]
                                         fromJSONDictionary:JSONDict
                                                      error:&error];
        [ESTools userLoginActionWithUserData:userData userToken:tokenString];
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK]
                                    callbackId:command.callbackId];
    }
}

- (void)clearUserToken:(CDVInvokedUrlCommand *)command {
    [ESTools userLogoutActionWithUserData:[ESConfig sharedConfig].userData
                                userToken:[ESConfig sharedConfig].userToken
                                 callback:nil];
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK]
                                callbackId:command.callbackId];
}

- (void)originalLogin:(CDVInvokedUrlCommand *)command {
    ESMLoginViewController *loginView = [[ESMLoginViewController alloc] init];
    RTRootNavigationController *nav = [[RTRootNavigationController alloc] initWithRootViewController:loginView];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
}

- (void)openWebView:(CDVInvokedUrlCommand *)command {
    NSString *webViewURL = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                       (CFStringRef)command.arguments[0],
                                                                                       (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                                                       NULL,
                                                                                       kCFStringEncodingUTF8));
    ESBaseWebviewController *webView = [[ESBaseWebviewController alloc] init];
    webView.hidesBottomBarWhenPushed = YES;
    webView.startPage = webViewURL;
    [self.viewController.navigationController pushViewController:webView animated:YES];
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK]
                                callbackId:command.callbackId];
}

- (void)closeWebView:(CDVInvokedUrlCommand *)command {
    if (self.viewController.presentingViewController) {
        [self.viewController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.viewController.navigationController popViewControllerAnimated:YES];
    }
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK]
                                callbackId:command.callbackId];
}

- (void)backWebView:(CDVInvokedUrlCommand *)command {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else if (self.viewController.presentingViewController) {
        [self.viewController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.viewController.navigationController popViewControllerAnimated:YES];
    }
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK]
                                callbackId:command.callbackId];
}

- (void)share:(CDVInvokedUrlCommand *)command {
    NSMutableArray *shareData = [NSMutableArray arrayWithArray:command.arguments]; // url;title;about;pic;
    [shareData addObject:self.webView.request.URL.absoluteString];
    NSString *decodedTitle = [shareData[1] gtm_stringByUnescapingFromHTML];
    NSString *decodedAbout = [shareData[2] gtm_stringByUnescapingFromHTML];
    [shareData replaceObjectAtIndex:1 withObject:decodedTitle];
    [shareData replaceObjectAtIndex:2 withObject:decodedAbout];
    [[ESSocialSDK sharedClient] showShareActivityViewIn:self.viewController withActivityItems:shareData];
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK]
                                callbackId:command.callbackId];
}

- (void)pay:(CDVInvokedUrlCommand *)command {
    NSString *courseName = command.arguments[0];
    NSString *payURL = command.arguments[1];
    ESBaseWebviewController *payView = [[ESBaseWebviewController alloc] init];
    payView.title = courseName;
	payView.title = @"购买";
    payView.startPage = [payURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.viewController.navigationController pushViewController:payView animated:YES];
}

- (void)showDownLesson:(CDVInvokedUrlCommand *)command {
    NSString *courseID = command.arguments[0];
    DLog(@" %@", courseID);
    ESLessonDownloadController *downloadView = [[ESLessonDownloadController alloc] initWithCourseID:courseID];
    RTRootNavigationController *nav = [[RTRootNavigationController alloc] initWithRootViewController:downloadView];
    [self.viewController presentViewController:nav animated:YES completion:nil];
}

- (void)showCourseSetting:(CDVInvokedUrlCommand *)command {
    NSString *courserID = command.arguments[0];
    NSString *type = command.arguments[1];
    BOOL isCourse = [type isEqualToString:@"course"];
    DLog(@" %@",courserID);
    ESCInfoViewController *courseInfoView = [[ESCInfoViewController alloc] initWithClassId:courserID Type:(isCourse)?ESChatRoomTypeCourse:ESChatRoomTypeClass];
    [self.viewController.navigationController pushViewController:courseInfoView animated:YES];
}

- (void)post:(CDVInvokedUrlCommand *)command {
    NSString *postPath = command.arguments[0];
    NSDictionary *postHeader = command.arguments[1];
    NSDictionary *postParams = command.arguments[2];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    for (NSString *headerKey in postHeader.allKeys) {
        [manager.requestSerializer setValue:postHeader[headerKey] forHTTPHeaderField:headerKey];
    }
    [manager POST:postPath parameters:postParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nonnull responseObject) {
        NSError *error = nil;
        responseObject = [NSJSONSerialization JSONObjectWithData:responseObject
                                                         options:NSJSONReadingAllowFragments
                                                           error:&error];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                      messageAsDictionary:responseObject];
        [self.commandDelegate sendPluginResult:pluginResult
                                    callbackId:command.callbackId];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[ESHUDView sharedInstance] showErrorMessage:NSLocalizedString(@"请求失败", nil) dismissBlock:nil];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)openPlatformLogin:(CDVInvokedUrlCommand *)command {
    NSString *platformType = command.arguments[0];
    if ([platformType isEqualToString:@"Wechat"]) {
        [[ESSocialSDK sharedClient] weChatLogin:^(NSDictionary *userInfo) {
            [self bindOpenLoginWithUserInfo:userInfo];
        }];
    } else if ([platformType isEqualToString:@"QQ"]) {
        [[ESSocialSDK sharedClient] tencentLogin:^(NSDictionary *userInfo) {
            [self bindOpenLoginWithUserInfo:userInfo];
        }];
    } else if ([platformType isEqualToString:@"SinaWeibo"]) {
        [[ESSocialSDK sharedClient] weiboLogin:^(NSDictionary *userInfo) {
            [self bindOpenLoginWithUserInfo:userInfo];
        }];
    }
    
}

- (void)showInput:(CDVInvokedUrlCommand *)command {
    NSString *title = command.arguments[0];
    NSString *content = command.arguments[1];
    NSString *type = command.arguments[2];
    UIAlertController *inputAlert = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    [inputAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.secureTextEntry = [type isEqualToString:@"password"];
    }];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil)
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                          messageAsString:inputAlert.textFields[0].text];
        [self.commandDelegate sendPluginResult:pluginResult
                                    callbackId:command.callbackId];
    }];
    [inputAlert addAction:confirm];
    [inputAlert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil)
                                                   style:UIAlertActionStyleCancel
                                                 handler:nil]];
    [self.viewController presentViewController:inputAlert animated:YES completion:nil];
}

- (void)uploadImage:(CDVInvokedUrlCommand *)command {
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)) {
        return;
    }
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.bk_didFinishPickingMediaBlock = ^(UIImagePickerController *picker, NSDictionary *info) {
        ESNetAPIClient *client = [ESNetAPIClient sharedClient];
        [client.requestSerializer setValue:[ESConfig sharedConfig].userToken forHTTPHeaderField:@"token"];
        [client POST:@"mapi_v2/User/uploadAvatar" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            UIImage *image = info[UIImagePickerControllerOriginalImage];
            NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
            if ((float)imageData.length / 1024 > 1000) {
                imageData = UIImageJPEGRepresentation(image, 1024 * 1000.0 / (float)imageData.length);
            }
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"avatar.jpeg" mimeType:@"image/jpeg"];
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                              messageAsString:jsonString];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            [ESHUDView dismiss];
        }];
        [picker dismissViewControllerAnimated:YES completion:^{
            [ESHUDView showLoading];
        }];
    };
    mediaUI.bk_didCancelBlock = ^(UIImagePickerController *picker) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    };
    [self.viewController presentViewController:mediaUI animated:YES completion:nil];
}

- (void)updateUser:(CDVInvokedUrlCommand *)command {
    [ESUserData requestUserDataByID:[ESConfig sharedConfig].userData.userIdentifier callback:^(ESUserData *userData, NSError *error) {
        [ESHUDView dismiss];
        if (userData) {
            [ESConfig sharedConfig].userData = userData;
            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_updateUserInfo object:nil];
        }
    }];
    
}

- (void)showKeyInput:(CDVInvokedUrlCommand *)command {
    // KeyboardDisplayRequiresUserAction = NO
}

- (void)redirect:(CDVInvokedUrlCommand *)command {
    NSDictionary *contentDict = command.arguments[0];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:contentDict options:0 error:nil];
    [[ESMessageManager sharedManager] transpondMessageContent:[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]
                                                         type:@"multi"
                                                   controller:self.viewController];
}

- (void)getThirdConfig:(CDVInvokedUrlCommand *)command {
    NSMutableArray *thirdArray = [NSMutableArray arrayWithCapacity:3];
    if (![kWechatID isEqualToString:@""]) {
        [thirdArray addObject:@"Wechat"];
    }
    if (![kTencentID isEqualToString:@""]) {
        [thirdArray addObject:@"QQ"];
    }
    if (![kWeiboID isEqualToString:@""]) {
        [thirdArray addObject:@"SinaWeibo"];
    }
    if (![ESSocialSDK sharedClient].isWechatAppInstalled) {
        [thirdArray removeObject:@"Wechat"];
    }
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                       messageAsArray:thirdArray];
    [self.commandDelegate sendPluginResult:pluginResult
                                callbackId:command.callbackId];
}

- (void)startAppView:(CDVInvokedUrlCommand *)command {
    NSString *viewName = command.arguments[0];
    NSDictionary *viewData = command.arguments[1];
    if ([viewName isEqualToString:@"threadDiscuss"]) {
        [ESHUDView showLoading];
        if ([viewData[@"targetType"] isEqualToString:@"course"]) {
            [ESQuestionData requestThreadDataWithParams:@{@"courseId" : viewData[@"targetId"], @"threadId" : viewData[@"threadId"]} userToken:[ESConfig sharedConfig].userToken callback:^(ESQuestionData *threadData, NSError *error) {
                if (error) {
                    [[ESHUDView sharedInstance] showErrorMessage:NSLocalizedString(@"获取失败", nil) dismissBlock:nil];
                } else {
                    [ESHUDView dismiss];
                    ESQuestionViewController *questionView = [[ESQuestionViewController alloc] initWithQuestionType:@"course" question:threadData];
                    [self.viewController.navigationController pushViewController:questionView animated:YES];
                }
            }];
        } else {
            [ESQuestionData requestClassThreadDataWithUserToken:[ESConfig sharedConfig].userToken ThreadId:viewData[@"threadId"] callback:^(ESQuestionData *threadData, NSError *error) {
                if (error) {
                    [[ESHUDView sharedInstance] showErrorMessage:NSLocalizedString(@"获取失败", nil) dismissBlock:nil];
                } else {
                    [ESHUDView dismiss];
                    ESQuestionViewController *questionView = [[ESQuestionViewController alloc] initWithQuestionType:@"classroom" question:threadData];
                    [self.viewController.navigationController pushViewController:questionView animated:YES];
                }
            }];
        }
    } else if ([viewName isEqualToString:@"courseConsult"]) {
        ESUserData *userData = [MTLJSONAdapter modelOfClass:[ESUserData class]
                                         fromJSONDictionary:@{@"user" : @{@"id" : viewData[@"userId"]}}
                                                      error:nil];
        ESChatViewController *consultView = [[ESChatViewController alloc] initWithUser:userData];
        [self.viewController.navigationController pushViewController:consultView animated:YES];
    } else if ([viewName isEqualToString:@"setting"]) {
        ESMSettingsViewController *settingsView = [[ESMSettingsViewController alloc] init];
        self.viewController.navigationController.navigationBarHidden = NO;
        [self.viewController.navigationController pushViewController:settingsView animated:NO];
    } else if ([viewName isEqualToString:@"sooonerLivePlayer"]) {
        [[ESHUDView sharedInstance] showInfoMessage:@"不支持该直播" dismissBlock:nil];
//        EPlayerData *playerData = [[EPlayerData alloc] init];
//        playerData.liveClassroomId = viewData[@"liveClassroomId"];
//        playerData.validateStr = viewData[@"exStr"];
//        playerData.customer = @"edusoho";
//        playerData.loginType = EPlayerLoginTypeAuthReverse;
//        playerData.playModel = [viewData[@"replayState"] boolValue] ? EPlayerPlayModelTypePlayback : EPlayerPlayModelTypeLive;
//        EPlayerPluginViewController *eplayerView = [[EPlayerPluginViewController alloc] initPlayer:playerData];
//#ifdef DEBUG
//        [EPlayerPluginParma setLogEnabled:YES];
//#endif
//        [self.viewController.navigationController pushViewController:eplayerView animated:YES];
    } else if ([viewName isEqualToString:@"threadCreate"]) {
        ESPublishSource source = [viewData[@"targetType"] isEqualToString:@"course"] ? ESPublishSourceCourse : ESPublishSourceClassroom;
        ESPublishType type = [viewData[@"type"] isEqualToString:@"question"] ? ESPublishTypeQuestion : ESPublishTypeDiscussion;
        ESAskQuestionController *questionChat = [[ESAskQuestionController alloc] initWithTargetID:viewData[@"targetId"] publishSource:source publishType:type];
        questionChat.dismissBlock = ^{
            [self.webView stringByEvaluatingJavaScriptFromString:@"jsBridgeAdapter.sendEvent(\'createThreadEvent\')"];
        };
        [self.viewController.navigationController pushViewController:questionChat animated:YES];
    } else if ([viewName isEqualToString:@"rechargeCoin"]) {
        ESMBalanceController *myBalance = [[ESMBalanceController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:myBalance];
        [self.viewController presentViewController:navi animated:YES completion:nil];
    }
    
}

- (void)sendNativeMessage:(CDVInvokedUrlCommand *)command {
    NSString *messageType = command.arguments[0];
    if ([messageType isEqualToString:@"token_lose"]) {
        [ESTools userLogoutActionWithUserData:[ESConfig sharedConfig].userData
                                    userToken:[ESConfig sharedConfig].userToken
                                     callback:nil];
        [UIAlertController showAlertInViewController:self.viewController withTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"登录信息失效，或已在别处登录\n请重新登录", nil) cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@[NSLocalizedString(@"确定", nil)] tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
            [ESTools shouldLoginFirstByPresentingView:YES];
        }];
    }
    if ([messageType isEqualToString:@"pay_success"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_CoursePaySuccess object:nil];
    }
}

#pragma mark - private

- (void)bindOpenLoginWithUserInfo:(NSDictionary *)userInfo {
    if (!userInfo) {
        [[ESHUDView sharedInstance] showErrorMessage:NSLocalizedString(@"获取用户信息失败", nil) dismissBlock:nil];
        return;
    }
    [ESUserData bindOpenLoginParameters:userInfo callback:^(ESUserData *userData, NSString *token, NSError *error) {
        if (userData) {
            [ESTools userLoginActionWithUserData:userData userToken:token];
            [[ESHUDView sharedInstance] showSuccessMessage:NSLocalizedString(@"登录成功", nil) dismissBlock:^{
                if (self.viewController.presentingViewController) {
                    [self.viewController dismissViewControllerAnimated:YES completion:nil];
                } else {
                    [self.viewController.navigationController popViewControllerAnimated:YES];
                }
            }];
        } else {
            [[ESHUDView sharedInstance] showErrorMessage:NSLocalizedString(@"登录出错", nil) dismissBlock:nil];
        }
    }];
}

@end
