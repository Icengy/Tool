//
//  AMPayPriceHeader.h
//  ArtMedia2
//
//  Created by icnengy on 2020/5/21.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AMPayPriceHeader;
NS_ASSUME_NONNULL_BEGIN

@protocol AMPayPriceHeaderDelegate <NSObject>
@optional
- (void)payHeader:(AMPayPriceHeader *)header didClickToDismiss:(id _Nullable)sender;

@end

@interface AMPayPriceHeader : UIView

@property (nonatomic ,weak) id <AMPayPriceHeaderDelegate> delegate;

@property(nonatomic, copy) NSString *priceStr;
/// 唤醒模式
@property(nonatomic, assign) AMAwakenPayStyle payStyle;

@end

NS_ASSUME_NONNULL_END
