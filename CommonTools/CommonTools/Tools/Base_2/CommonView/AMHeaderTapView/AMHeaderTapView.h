//
//  AMHeaderTapView.h
//  ArtMedia2
//
//  Created by icnengy on 2020/7/6.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AMHeaderTapView;
NS_ASSUME_NONNULL_BEGIN
@protocol AMHeaderTapDelegate <NSObject>

@optional
- (void)tapView:(AMHeaderTapView *)tapView didSwipe:(id)sender;

@end

@interface AMHeaderTapView : UIView

//- (void)addSwipeGestureRecognizerWithTarget:(nullable UIScrollView *)target action:(nullable SEL)action;
@property (weak ,nonatomic) id <AMHeaderTapDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
