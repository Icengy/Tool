//
//  AMPayViewController.h
//  ArtMedia2
//
//  Created by icnengy on 2020/7/2.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "BaseViewController.h"

#import "AMPayManager.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AMPayDelegate <NSObject>

@optional
- (void)payViewController:(BaseViewController *)payViewController didSelectPayForWay:(AMPayWay)payWay;
- (void)payViewController:(BaseViewController *)payViewController didSelectPayVirtualWithNeedRecharge:(BOOL)needRecharge;

@end

@interface AMPayViewController : BaseViewController

@property (weak, nonatomic) id <AMPayDelegate> delegate;

@property(nonatomic,assign) BOOL limitTouchBlank;
@property(nonatomic,copy) NSString *priceStr;
/// 唤醒模式
@property(nonatomic, assign) AMAwakenPayStyle payStyle;

@end

NS_ASSUME_NONNULL_END
