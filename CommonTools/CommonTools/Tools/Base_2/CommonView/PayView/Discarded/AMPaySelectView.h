//
//  AMPaySelectView.h
//  ArtMedia2
//
//  Created by icnengy on 2020/5/21.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AMPayManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface AMPaySelectView : UIView

@property(nonatomic,copy) void(^payBlock)(AMPayWay payWay);

@property(nonatomic,copy) NSString *priceStr;
/// 唤醒模式
@property(nonatomic, assign) AMAwakenPayStyle payStyle;

+ (AMPaySelectView *)shareInstance;
//+ (AMPaySelectView *)shareInstanceWithStyle:(AMAwakenPayStyle)style;

- (void)show;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
