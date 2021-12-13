//
//  AMIconImageView.m
//  ArtMedia2
//
//  Created by icnengy on 2020/6/15.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "AMIconImageView.h"

@implementation AMIconImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        self.clipsToBounds = YES;
        self.contentMode = UIViewContentModeScaleAspectFit;
    }return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        self.contentMode = UIViewContentModeScaleAspectFit;
    }return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = self.height/2;
    self.layer.borderColor = self.borderColor?self.borderColor.CGColor:UIColor.clearColor.CGColor;
    self.layer.borderWidth = (self.borderWidth > 0.0)?self.borderWidth:0.0f;
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    self.layer.borderColor = borderColor?borderColor.CGColor:UIColor.clearColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    self.layer.borderWidth = (borderWidth > 0.0)?borderWidth:0.0f;
}

- (void)addBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *_Nullable)borderColor {
    self.borderWidth = borderWidth;
    self.borderColor = borderColor;
}

@end
