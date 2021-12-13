//
//  WTCIntroduceView.m
//  ESTicket
//
//  Created by Homosum on 2018/2/8.
//  Copyright © 2018年 九辰_王添诚. All rights reserved.
//

#import "WTCIntroduceView.h"
@interface WTCIntroduceView ()
{
    UIImageView*imageView;
}
@end
@implementation WTCIntroduceView
-(id)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.backgroundColor = RGBACOLOR(1, 1, 1, 0.3);
        self.alpha = 0;
        self.hidden = YES;
        [APP_DELEGATE.window addSubview:self];
        [self setupView];
    }
     return self;
}
- (void)setupView
{
    imageView = [[UIImageView alloc] init];
}
-(void)hidden
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
//        self.backDownView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, kBackViewHeight);
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self removeFromSuperview];
    }];
}
-(void)image:(UIImage *)image andFrame:(CGRect)frame
{
    
    [imageView setFrame:frame];
    imageView.image = image;
    [self addSubview:imageView];
    self.alpha = 1;
    self.hidden = NO;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    UITouch *touch = [touches anyObject];
//    if (touch.view == self) {
        [self hidden];
//    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
