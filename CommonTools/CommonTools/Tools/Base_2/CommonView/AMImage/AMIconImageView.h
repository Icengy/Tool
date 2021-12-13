//
//  AMIconImageView.h
//  ArtMedia2
//
//  Created by icnengy on 2020/6/15.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AMIconImageView : UIImageView

@property (nonatomic ,assign) CGFloat borderWidth;
@property (nonatomic ,strong ,nullable) UIColor * borderColor;

- (void)addBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *_Nullable)borderColor;

@end

NS_ASSUME_NONNULL_END
