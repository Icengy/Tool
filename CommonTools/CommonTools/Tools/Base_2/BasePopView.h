//
//  BaseView.h
//  ArtMedia2
//
//  Created by icnengy on 2020/9/12.
//  Copyright © 2020 翁磊. All rights reserved.
//
// popView
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BasePopView : UIView

+ (instancetype)shareInstance;
- (void)show;
- (void)hide;
- (void)hide:(void (^ __nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
