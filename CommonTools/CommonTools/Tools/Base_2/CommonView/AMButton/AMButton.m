//
//  AMButton.m
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/10/18.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import "AMButton.h"

#import "UIControl+AMButtonQuickLimit.h"

@implementation AMButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		self.acceptEventInterval = 0.5f;
	}return self;
}

- (instancetype) initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		self.acceptEventInterval = 0.5f;
	}return self;
}

@end

#pragma mark -
@implementation AMReverseButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.imageView sizeToFit];
    [self.titleLabel sizeToFit];
    
    CGFloat imgW = self.imageView.width;
    CGFloat imgH = self.imageView.height;
    CGFloat titleW = self.titleLabel.width;
    
    self.imageView.frame = CGRectMake(self.width- imgW-4.0f, self.imageView.y , imgW, imgH);
    self.titleLabel.frame = CGRectMake(CGRectGetMinX(self.imageView.frame)- titleW-4.0f, self.titleLabel.y, titleW, self.titleLabel.height);
}

@end

#pragma mark -
@implementation GradientButton

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userInteractionEnabled = NO;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = {0,1};
    
    UIColor *fromColor = self.fromColor?self.fromColor:[RGB(0, 0, 0) colorWithAlphaComponent:0.0];
    UIColor *toColor = self.toColor?self.toColor:[RGB(0, 0, 0) colorWithAlphaComponent:0.5];
    
    NSArray *colors = @[(__bridge id)fromColor.CGColor, (__bridge id)toColor.CGColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef) colors, locations);
    CGColorSpaceRelease(colorSpace);
    
    CGPoint startPoint = CGPointMake(self.width/2, 0.0);
    CGPoint endPoint = CGPointMake(self.width/2, self.height);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    CGGradientRelease(gradient);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.centerY = self.titleLabel.centerY;
}

@end

#pragma mark -
@implementation SearchButton

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.imageView sizeToFit];
    [self.titleLabel sizeToFit];
    
    CGFloat imgW = self.imageView.width;
    CGFloat margin = 8.0f;
    CGFloat titleW = self.width-margin-imgW - 12.0f - 15.0f;
    
    self.imageView.frame = CGRectMake(self.width-imgW-12.0f, self.imageView.y , imgW, self.imageView.height);
    self.titleLabel.frame = CGRectMake(15.0f, self.titleLabel.y, titleW, self.titleLabel.height);
}

@end

#pragma mark -
@implementation ImproveImageButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.imageView sizeToFit];
    [self.titleLabel sizeToFit];
    
    CGFloat imgW = self.imageView.width;
    CGFloat imgH = self.imageView.height;
    CGFloat titleW = self.titleLabel.width;
    CGFloat titleH = self.titleLabel.height;
    CGFloat margin = (self.height-(titleH+imgH+4.0f))/2;
    
    self.imageView.frame = CGRectMake((self.width - imgW)/2 ,margin , imgW, self.imageView.height);
    self.titleLabel.frame = CGRectMake((self.width-titleW)/2, self.imageView.y+self.imageView.height+4.0f, titleW, titleH);
}

@end

#pragma mark -
@interface PersonalMenuItemButton ()
@property (nonatomic ,strong) UILabel *numLabel;
@end

@implementation PersonalMenuItemButton

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] init];
        
        _numLabel.frame = CGRectMake(0, 0, 0, 16.0f);
        _numLabel.backgroundColor = RGB(219, 17, 17);
        
        _numLabel.clipsToBounds = YES;
        
        _numLabel.textColor =  Color_Whiter;
        _numLabel.font = [UIFont addHanSanSC:11.0f fontType:0];
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.hidden = YES;
        
    }return _numLabel;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        self.backgroundColor = UIColor.clearColor;
        [self addSubview:self.numLabel];
    }return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.clearColor;
        [self addSubview:self.numLabel];
    }return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.font = [UIFont addHanSanSC:13.0f fontType:0];
    [self.imageView sizeToFit];
    [self.titleLabel sizeToFit];
    
    CGFloat imgW = self.imageView.width;
    CGFloat titleW = self.titleLabel.width;
    CGFloat imgH = self.imageView.height;
    CGFloat titleH = self.titleLabel.height;
    CGFloat margin = (self.height - imgH - titleH)/3;
    
    self.imageView.frame = CGRectMake((self.width- imgW)/2, margin*1.2, imgW, imgH);
    self.titleLabel.frame = CGRectMake((self.width- titleW)/2, CGRectGetMaxY(self.imageView.frame) + margin*0.6, titleW, self.titleLabel.height);
    
    self.numLabel.center = CGPointMake(CGRectGetMaxX(self.imageView.frame), CGRectGetMinY(self.imageView.frame));
    self.numLabel.layer.cornerRadius = _numLabel.height/2;
}

- (void)setBadgeNum:(NSInteger)badgeNum {
    _badgeNum = badgeNum;
    if (_badgeNum) {
        self.numLabel.hidden = NO;
        if (self.isAddRight) {
            self.numLabel.text = [NSString stringWithFormat:@"%@%@",@(_badgeNum),_needPlus?@"+":@""];
            if (_badgeNum > 99) {
                self.numLabel.text = @"99+";
            }
        }else {
            self.numLabel.text = [NSString stringWithFormat:@"%@%@", _needPlus?@"+":@"",@(_badgeNum)];
            if (_badgeNum > 99) {
                self.numLabel.text = @"+99";
            }
        }
        [self.numLabel sizeToFit];
        CGFloat width = [self.numLabel.text sizeWithFont:self.numLabel.font andMaxSize:self.size].width + 8.0f;
        if (width < self.numLabel.height) width = self.numLabel.height;
        CGRect frame = self.numLabel.frame;
        frame.size.width = width;
        self.numLabel.frame = frame;
    }else {
        self.numLabel.hidden = YES;
    }
}

@end

#pragma mark -
@implementation AMVideoItemButton

- (instancetype)init {
    if (self = [super init]) {
        
//        self.backgroundColor = kDefaultBgAlphaColor;
//        self.layer.cornerRadius = kDefaultCornerRadius;
//        self.layer.borderColor = kDefaultBorderColor.CGColor;
//        self.layer.borderWidth = 0.5;
        
        [self setTitleColor:Color_Whiter forState:UIControlStateNormal];
//        [self setTitleColor:kDefaultTinkColor forState:UIControlStateSelected];
        [self setTitleColor:UIColorFromRGB(0xDA5326) forState:UIControlStateSelected];
        [self setTitleColor:Color_Grey forState:UIControlStateDisabled];
        self.titleLabel.font = [UIFont addHanSanSC:12.0f fontType:0];
        
    }return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        
//        self.backgroundColor = kDefaultBgAlphaColor;
//        self.layer.cornerRadius = kDefaultCornerRadius;
//        self.layer.borderColor = kDefaultBorderColor.CGColor;
//        self.layer.borderWidth = 0.5;
        
        [self setTitleColor:Color_Whiter forState:UIControlStateNormal];
//        [self setTitleColor:kDefaultTinkColor forState:UIControlStateSelected];
        [self setTitleColor:UIColorFromRGB(0xDA5326) forState:UIControlStateSelected];
        [self setTitleColor:Color_Grey forState:UIControlStateDisabled];
        self.titleLabel.font = [UIFont addHanSanSC:12.0f fontType:0];
        
    }return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.cornerRadius = 4.0f;
    
    [self.imageView sizeToFit];
    [self.titleLabel sizeToFit];
    
    CGFloat width = self.frame.size.width;
    
    CGFloat imgW = self.imageView.frame.size.width;
    CGFloat imgH = self.imageView.frame.size.height;
    
    CGFloat titleW = self.titleLabel.frame.size.width;
    CGFloat titleH = self.titleLabel.frame.size.height;
    
    CGFloat margin = (self.height-(titleH+imgH+4.0f))/2;
    
    self.imageView.frame = CGRectMake((width - imgH) / 2, margin, imgW, imgH);
    
    self.titleLabel.frame = CGRectMake((width - titleW) / 2, margin+imgH+4.0f, titleW, titleH);
}

@end

#pragma mark -
@implementation IRTLButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.imageView sizeToFit];
    [self.titleLabel sizeToFit];
    
    CGFloat imgW = self.imageView.width *0.8;
    CGFloat imgH = self.imageView.height *0.8;
    CGFloat titleW = self.titleLabel.width;
    
    self.imageView.frame = CGRectMake(self.width- imgW, 0 , imgW, imgH);
    self.titleLabel.frame = CGRectMake(CGRectGetMinX(self.imageView.frame)- titleW, self.titleLabel.y, titleW, self.titleLabel.height);
    self.imageView.centerY = self.titleLabel.centerY;
}

@end

#pragma mark -
@implementation AMVideoGiftButton

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self startAnimation];
}

- (void)startAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI *0.9, 0.0, 0.0, 1.0)];
    animation.duration = 3;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
//    _animation = animation;
    
    [self.imageView.layer addAnimation:animation forKey:nil];
}

@end

@implementation AMBadgePointButton

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.badgeView];
    }return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self addSubview:self.badgeView];
    }
    return self;
}
- (UIView *)badgeView {
    if (!_badgeView) {
        _badgeView = [[UIView alloc] init];
        
        _badgeView.backgroundColor = RGB(219, 17, 17);
        _badgeView.frame = CGRectMake(0, 0, 6.0, 6.0);
        _badgeView.clipsToBounds = YES;
        _badgeView.layer.cornerRadius = _badgeView.width/2;
        _badgeView.hidden = YES;
        
        [self bringSubviewToFront:_badgeView];
        
    }return _badgeView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _badgeView.frame = CGRectMake(self.width - 10.0f, 0, 6.0, 6.0);
}

@end

@interface AMBadgeNumberButton ()
@property (nonatomic ,strong) UILabel *numLabel;
@end

@implementation AMBadgeNumberButton

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] init];
        
        _numLabel.frame = CGRectMake(0, 0, 0, 16.0f);
        _numLabel.backgroundColor = RGB(219, 17, 17);
        
        _numLabel.clipsToBounds = YES;
        
        _numLabel.textColor =  Color_Whiter;
        _numLabel.font = [UIFont addHanSanSC:11.0f fontType:0];
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.hidden = YES;
        
    }return _numLabel;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.numLabel];
    }return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.numLabel];
    }return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_badgeNum) {
        CGRect frame = self.numLabel.frame;
        
        if (self.titleLabel.text.length > 0) {
            frame.origin.x = CGRectGetMaxX(self.titleLabel.frame) + 4.0f;
        }else{
            frame.origin.x = CGRectGetMaxX(self.imageView.frame)-10.0f;
        }
        self.numLabel.frame = frame;
//        if (self.titleLabel.text.length > 0){
//            self.numLabel.centerY = self.titleLabel.centerY;
//        }else{
//            self.numLabel.centerY = self.imageView.centerY;
//        }
        self.numLabel.centerY = self.titleLabel.centerY;
        _numLabel.layer.cornerRadius = _numLabel.height/2;
    }
}

- (void)setBadgeNum:(NSInteger)badgeNum {
    _badgeNum = badgeNum;
    if (_badgeNum) {
        self.numLabel.hidden = NO;
        self.numLabel.text = [NSString stringWithFormat:@"+%@", @(_badgeNum)];
        if (_badgeNum > 99) {
            self.numLabel.text = @"+99";
        }
        [self.numLabel sizeToFit];
        CGFloat width = [self.numLabel.text sizeWithFont:self.numLabel.font andMaxSize:self.size].width + 8.0f;
        if (width < self.numLabel.height) width = self.numLabel.height;
        CGRect frame = self.numLabel.frame;
        frame.size.width = width;
        self.numLabel.frame = frame;
    }else {
        self.numLabel.hidden = YES;
    }
}

@end
