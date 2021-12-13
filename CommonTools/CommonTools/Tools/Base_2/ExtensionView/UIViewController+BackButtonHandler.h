//
//  UIViewController+BackButtonHandler.h
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/10/24.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BackButtonHandlerProtocol <NSObject>
@optional
// 重写下面的方法以拦截导航栏返回按钮点击事件，返回 YES 则 pop，NO 则不 pop
- (BOOL)navigationShouldPopOnBackButton;
@end

@interface UIViewController (BackButtonHandler) <BackButtonHandlerProtocol>

@end

NS_ASSUME_NONNULL_END
