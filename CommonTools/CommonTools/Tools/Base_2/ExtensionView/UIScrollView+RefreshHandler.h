//
//  UIScrollView+RefreshHandler.h
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/10/29.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MJRefresh.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (RefreshHandler)

- (void)addRefreshHeaderWithTarget:(id)target action:(SEL)action;

- (void)addRefreshFooterWithTarget:(id)target action:(SEL)action;
- (void)addRefreshFooterWithTarget:(id)target withTitle:(NSString *_Nullable)title action:(SEL)action;

///更新Footer的状态
- (void)updataFreshFooter:(BOOL)show;
///结束所有Refresh动画
- (void)endAllFreshing;

@end

NS_ASSUME_NONNULL_END
