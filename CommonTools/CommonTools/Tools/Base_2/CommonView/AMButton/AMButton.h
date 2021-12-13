//
//  AMButton.h
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/10/18.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 正序按钮(文字左 图片右)
@interface AMButton : UIButton

@end
/// 正序按钮(文字右 图片左)
@interface AMReverseButton : AMButton

@end

@interface GradientButton : AMButton

@property (nonatomic ,strong ,nullable) UIColor *fromColor;
@property (nonatomic ,strong ,nullable) UIColor *toColor;

@end

@interface SearchButton : AMButton

@end

@interface  ImproveImageButton : AMButton

@end



@interface PersonalMenuItemButton : AMButton
@property (nonatomic ,assign) NSInteger badgeNum;
@property (nonatomic ,assign) BOOL isAddRight;
@property (nonatomic ,assign) BOOL needPlus;
@end

#define kDefaultBtnHeight  ADAPTATIONRATIOVALUE(100.0f)
#define kDefaultTinkColor  RGB(255, 193, 45)

#define kDefaultBorderColor RGB(90,92,102)
#define kDefaultCornerRadius 4.0f

#define kDefaultBgAlphaColor [RGB(0, 0, 0) colorWithAlphaComponent:0.6]

@interface AMVideoItemButton : AMButton

@end


/// 右图左字 图片有缩小
@interface IRTLButton : AMButton

@end

/// 送花按钮
@interface AMVideoGiftButton : AMVideoItemButton
//@property (nonatomic ,strong) CABasicAnimation *animation;
- (void)startAnimation;
@end

@interface AMBadgePointButton : AMButton
@property (nonatomic ,strong) UIView *badgeView;
@end


typedef NS_ENUM(NSUInteger, AMBadgeNumberStyle) {
    AMBadgeNumberStyleVertical = 0,            //水平布局（默认）
    AMBadgeNumberStyleHorizontal         //垂直布局
};

@interface AMBadgeNumberButton : AMButton
//@property (nonatomic ,assign) AMBadgeNumberStyle style;
@property (nonatomic ,assign) NSInteger badgeNum;
@end


NS_ASSUME_NONNULL_END
