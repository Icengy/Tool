//
//  AMPayPriceFooter.h
//  ArtMedia2
//
//  Created by icnengy on 2020/7/2.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AMPayPriceFooter;
NS_ASSUME_NONNULL_BEGIN

@protocol AMPayPriceFooterDelegate <NSObject>
@optional
- (void)payFooter:(AMPayPriceFooter *)footer didClickToAddNewBank:(id _Nullable)sender;

@end

@interface AMPayPriceFooter : UIView

@property (weak, nonatomic) id <AMPayPriceFooterDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
