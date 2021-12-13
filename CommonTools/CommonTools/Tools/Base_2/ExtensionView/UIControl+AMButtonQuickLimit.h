//
//  UIControl+AMButtonQuickLimit.h
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/10/18.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (AMButtonQuickLimit)

// 间隔多少秒才能响应事件
@property(nonatomic, assign) NSTimeInterval  acceptEventInterval;
//是否能执行方法
@property(nonatomic, assign) BOOL ignoreEvent;

@end

NS_ASSUME_NONNULL_END
