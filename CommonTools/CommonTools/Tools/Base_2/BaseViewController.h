//
//  BaseViewController.h
//  ArtMedia
//
//  Created by 美术传媒 on 2018/9/27.
//  Copyright © 2018年 lcy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MainNavigationController.h"

typedef NS_ENUM(NSInteger, AMBaseBackgroundColorStyle) {
    /// 白色底 whiteColor
    AMBaseBackgroundColorStyleDetault                                  = 0,
    /// 灰色底 RGB(247, 247, 247)
    AMBaseBackgroundColorStyleGray,
    /// 黑色底 blackColor
    AMBaseBackgroundColorStyleBlack,
    /// 无色底 clearColor
    AMBaseBackgroundColorStyleClear
};

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

@property (nonatomic ,assign) AMBaseBackgroundColorStyle bgColorStyle;
@property (nonatomic ,assign) AMNavigationBarStyle navigationBarStyle;

@property (nonatomic ,assign) UIStatusBarStyle barStyle;
@property (nonatomic ,assign) BOOL barHidden;

@property (nonatomic,strong)NSMutableArray *HK_dataArr;
@property (nonatomic,assign)NSInteger pageIndex;

- (void)jumpToLoginWithBlock:(void(^ __nullable)(id __nullable data))loginBlock;
- (void)showMessageWithStr:(NSString*)str withType:(int)type;
- (void)reloadCurrent:(NSNotification *)notification;

/// 移除导航栈中的控制器，传类
- (void)removePreviousViewController:(Class)removeClass;

@end

NS_ASSUME_NONNULL_END
