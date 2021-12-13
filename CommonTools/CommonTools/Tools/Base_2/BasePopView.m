//
//  BaseView.m
//  ArtMedia2
//
//  Created by icnengy on 2020/9/12.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "BasePopView.h"

static BOOL _hadInstance = NO;

@implementation BasePopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)shareInstance {
    if (!_hadInstance) {
        _hadInstance = YES;
        NSArray *objArray = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
        for (id obj in objArray) {
            if ([obj isKindOfClass:self]) {
                return obj;
            }
        }
    }
    return nil;
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^ {
    } completion:nil];
}

- (void)hide {
    [UIView animateWithDuration:0.4f delay:0.0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^ {
    }completion:^(BOOL finished) {
        _hadInstance = NO;
        [self removeFromSuperview];
    }];
}

- (void)hide:(void (^ __nullable)(void))completion {
    [UIView animateWithDuration:0.4f delay:0.0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^ {
    }completion:^(BOOL finished) {
        _hadInstance = NO;
        if (completion)  completion();
        [self removeFromSuperview];
    }];
}

@end
