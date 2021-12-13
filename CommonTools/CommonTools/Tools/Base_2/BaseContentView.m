//
//  BaseContentView.m
//  ArtMedia2
//
//  Created by icnengy on 2020/10/20.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "BaseContentView.h"

@implementation BaseContentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)shareInstance {
    NSArray *objArray = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    for (id obj in objArray) {
        if ([obj isKindOfClass:self]) {
            return obj;
        }
    }
    return objArray.lastObject;
}

@end
