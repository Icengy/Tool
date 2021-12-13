//
//  AMIconView.m
//  ArtMedia2
//
//  Created by icnengy on 2020/12/15.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "AMIconView.h"

@implementation AMIconView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self setup];
    }return self;
}

- (void)setup {
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    [self addSubview:self.view];
    self.view.frame = self.bounds;
    self.backgroundColor = UIColor.clearColor;
    self.view.backgroundColor = UIColor.clearColor;
}

//- (instancetype)initWithFrame:(CGRect)frame {
//    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = UIColor.clearColor;
//        [self initSubView];
//    }return self;
//}
//
//- (void)initSubView {
//
//}

@end
