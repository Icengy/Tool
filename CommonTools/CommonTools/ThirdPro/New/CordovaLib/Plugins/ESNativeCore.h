//
//  ESNativeCore.h
//  EduSoho
//
//  Created by Edusoho on 15/6/23.
//  Copyright (c) 2015年 Kuozhi Network Technology. All rights reserved.
//

#import "CDVPlugin.h"

@interface ESNativeCore : CDVPlugin

- (void)showImages:(CDVInvokedUrlCommand *)command;
- (void)openDrawer:(CDVInvokedUrlCommand *)command;
- (void)getUserToken:(CDVInvokedUrlCommand *)command;
- (void)saveUserToken:(CDVInvokedUrlCommand *)command;
- (void)clearUserToken:(CDVInvokedUrlCommand *)command;
- (void)openWebView:(CDVInvokedUrlCommand *)command;
- (void)closeWebView:(CDVInvokedUrlCommand *)command;
- (void)backWebView:(CDVInvokedUrlCommand *)command;
- (void)share:(CDVInvokedUrlCommand *)command;
- (void)pay:(CDVInvokedUrlCommand *)command;
- (void)showDownLesson:(CDVInvokedUrlCommand *)command;
- (void)post:(CDVInvokedUrlCommand *)command;
- (void)openPlatformLogin:(CDVInvokedUrlCommand *)command;
- (void)showInput:(CDVInvokedUrlCommand *)command;
- (void)updateUser:(CDVInvokedUrlCommand *)command;
- (void)showKeyInput:(CDVInvokedUrlCommand *)command;
- (void)redirect:(CDVInvokedUrlCommand *)command;
- (void)getThirdConfig:(CDVInvokedUrlCommand *)command;
- (void)startAppView:(CDVInvokedUrlCommand *)command;
- (void)sendNativeMessage:(CDVInvokedUrlCommand *)command;
- (void)originalLogin:(CDVInvokedUrlCommand *)command;
- (void)openNativeCourseDetailPage:(CDVInvokedUrlCommand *)command;
- (void)openNativeLivePlay:(CDVInvokedUrlCommand *)command;
- (void)openNativeClassroomDetailPage:(CDVInvokedUrlCommand *)command;

@end
