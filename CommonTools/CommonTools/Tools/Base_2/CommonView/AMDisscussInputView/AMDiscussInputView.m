//
//  AMDiscussInputView.m
//  ArtMedia2
//
//  Created by icnengy on 2020/7/7.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "AMDiscussInputView.h"

@implementation AMDiscussInputView

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
}

@end
