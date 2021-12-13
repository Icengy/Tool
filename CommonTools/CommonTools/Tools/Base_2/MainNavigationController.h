//
//  MainNavigationController.h
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/10/24.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AMNavigationBarStyle) {
    /// 黑色 blackColor 白底黑字
    AMNavigationBarStyleDetault                                  = 0,
    /// 白色 whiteColor 蓝底白字
    AMNavigationBarStyleWhite,
    /// 透明底
    AMNavigationBarStyleTransparent
};

NS_ASSUME_NONNULL_BEGIN

@interface MainNavigationController : UINavigationController

@property (nonatomic ,assign) AMNavigationBarStyle barStyle;

- (void)getBadge:(id)sender;
//- (void)updateDefaultSetting;

@end

NS_ASSUME_NONNULL_END
