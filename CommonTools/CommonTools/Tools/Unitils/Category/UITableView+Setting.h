//
//  UITableView+Setting.h
//  Gallop_iOS
//
//  Created by icengy on 2021/4/21.
//  Copyright © 2021 homosum. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (Setting)

/// 注册通过xib创建的cell
/// @param cellClass cell Class
- (void)registerNibCell:(Class)cellClass;

/// 注册纯代码创建的cell
/// @param cellClass cell Class
- (void)registerCell:(Class)cellClass;

/// 通过cell类获取cell
/// @param cellClass cellClass
- (id)dequeueReusableCell:(Class)cellClass;


#pragma mark -

- (void)endAllFreshing;

@end


NS_ASSUME_NONNULL_END
