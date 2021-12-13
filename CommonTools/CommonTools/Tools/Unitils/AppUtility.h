//
//  AppUtility.h
//  ESTicket
//
//  Created by 鹏 刘 on 15/11/26.
//  Copyright © 2015年 鹏 刘. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESViewController.h"

@class AppUtility;

@protocol AppUtilityDelegate <NSObject>
@optional
//photo
- (void)getPhotoImageSuccessWithImage:(id)image;

- (void)completePhotoImageSuccessWithImage:(UIImage *)image;

- (void)completePhotoImageFaild;

- (void)getPhotoImageSuccessWithImageArr:(NSArray *)array;

//video
- (void)getVideoSuccessWithData:(NSData *)data url:(NSString *)url shotImage:(UIImage *)shotImage;

- (void)completeVideoImageFaild;
@end

#define App_Utility [AppUtility getInstance]



@interface ESCurrentUser : NSObject

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSNumber *level;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSNumber *gallopAccountAmount;
@property (nonatomic, strong) NSNumber *couponAmount;
@property (nonatomic, strong) NSNumber *pushMessageCount;
@property (nonatomic, strong) NSNumber *interactMessageCount;
@property (nonatomic, strong) NSNumber *messageCount;
@property (nonatomic, strong) NSNumber *feedbackMessageCount;
@property (nonatomic, strong) NSNumber *gallopIndex;
@property (nonatomic, strong) NSNumber *allRedIndex;
@property (nonatomic, strong) NSNumber *hasUnreadMessage;
@property (nonatomic, strong) NSNumber *notPayedOrderCount;
@property (nonatomic, strong) NSNumber *notConsignedOrderCount;
@property (nonatomic, strong) NSNumber *consignedOrderCount;
@property (nonatomic, strong) NSNumber *cartSkuCount;
@property (nonatomic, strong) NSString *signature;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSNumber *role;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *customerServiceTel;
@end

@interface AppUtility : NSObject

@property (nonatomic, strong) ESCurrentUser* currentUser;

@property (nonatomic, weak) id<AppUtilityDelegate> delegate;

@property (nonatomic, strong) UIImageView *edittingImageV;

@property (nonatomic, assign) int seletedImageCount;//已选择图片数量

@property (nonatomic, assign) int completeImage;//0为默认传需要切割的头像；非零为传不需要切割的图片，其中1为申请理由组图，2为身份证照片 3为论坛图片

+ (AppUtility*)getInstance;

// 检查当前用户是否存在
- (BOOL)checkCurrentUser;
// 保存当前用户
- (void)saveCurrentUser;
// 注销当前用户
- (void)clearCurrentUser;

//弹出登录
- (void)showLoginViewController;

//弹出一个VC
-(void)presentVC:(UIViewController*)vc;

/** 调用系统相机*/
- (void)usePhotoForGetImage;
/** 调用系统视频*/
- (void)usePhotoForGetVideo;

#pragma mark -
/**  */
+ (BOOL)isEqualToNonNull:(id)value;
+ (NSString *)isEqualToNonNull:(id)value replace:(id)replace;

@end
