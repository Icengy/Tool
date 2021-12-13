//
//  AMSegment.h
//  ArtMedia2
//
//  Created by icnengy on 2020/6/9.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AMSegmentStyle) {
    AMSegmentStyleNone = 0,            //默认，不带下划线，无底色
    AMSegmentStyleCoverView,          //不带下划线，有底色
    AMSegmentStyleProgressView      // 带下划线，无底色
};

@class AMSegment;
NS_ASSUME_NONNULL_BEGIN

@protocol AMSegmentDelegate <NSObject>
@required
- (void)segment:(AMSegment *)seg switchSegmentIndex:(NSInteger)index;

@end

@interface AMSegment : UIView

@property (weak, nonatomic) id <AMSegmentDelegate> delegate;

- (instancetype)initWithItemArray:(NSArray *_Nullable)items segStyle:(AMSegmentStyle)segStyle;

@property (nonatomic ,assign) AMSegmentStyle segStyle;
@property (nonatomic, strong, nonnull) NSArray *items;
@property (nonatomic, strong, nonnull) NSArray *badges;
@property (nonatomic, strong) UIColor *itemBackgroundColor;
@property (nonatomic, strong) UIColor *sliderColor;

@property (nonatomic,assign) NSInteger selectedSegmentIndex;
@property (nonatomic, strong, nonnull) NSDictionary <NSAttributedStringKey,id> * normalItemTextAttributes;
@property (nonatomic, strong, nonnull) NSDictionary <NSAttributedStringKey,id>*selectedItemTextAttributes;



//@property (nonatomic,copy) void  (^segmentSwitchBlock) (NSInteger selectedSegmentIndex);

@end

NS_ASSUME_NONNULL_END
