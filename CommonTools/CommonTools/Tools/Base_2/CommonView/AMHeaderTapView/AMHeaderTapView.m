//
//  AMHeaderTapView.m
//  ArtMedia2
//
//  Created by icnengy on 2020/7/6.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "AMHeaderTapView.h"

@interface AMHeaderTapView () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *view;

@end

@implementation AMHeaderTapView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }return self;
}

- (void)setup {
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    [self addSubview:self.view];
    self.view.frame = self.bounds;
    self.view.backgroundColor = UIColor.clearColor;
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(clickToSwipe:)];
    swipe.numberOfTouchesRequired = 1;
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipe];
}

- (void)clickToSwipe:(UISwipeGestureRecognizer *)gesture {
    if (gesture.direction == UISwipeGestureRecognizerDirectionDown && self.delegate && [self.delegate respondsToSelector:@selector(tapView:didSwipe:)]) {
        [self.delegate tapView:self didSwipe:gesture];
    }
}

@end
