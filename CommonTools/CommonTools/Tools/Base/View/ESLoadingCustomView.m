//
//  ESLoadingCustomView.m
//  ESTicket
//
//  Created by 王帅 on 16/4/14.
//  Copyright © 2016年 鹏 刘. All rights reserved.
//

#import "ESLoadingCustomView.h"

#define kWidthAndHeight 30

@interface ESLoadingCustomView ()

@property (nonatomic, strong) UIImageView *imageView;

@end



@implementation ESLoadingCustomView


- (id)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kWidthAndHeight+15, kWidthAndHeight+15);
        [self setupView];
    }
    return self;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (void)setupView
{
    __weak ESLoadingCustomView *weakSelf = self;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(kWidthAndHeight, kWidthAndHeight));
    }];
    
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=24; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_%zd", i]];
        [refreshingImages addObject:image];
    }
    
    self.imageView.animationImages = refreshingImages;
    self.imageView.animationDuration = 2.5;
    self.imageView.animationRepeatCount=999999;
    [self.imageView startAnimating];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
