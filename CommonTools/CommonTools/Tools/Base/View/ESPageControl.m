//
//  ESPageControl.M
//  ESTicket
//
//  Created by 鹏 刘 on 15/11/23.
//  Copyright © 2015年 鹏 刘. All rights reserved.
//

#import "ESPageControl.h"

@implementation ESPageControl // 实现部分
@synthesize pointSize;

- (void)setCurrentPage:(NSInteger)page {
    [super setCurrentPage:page];
    if (pointSize.height > 0&&pointSize.width > 0) {
        for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
            UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
            CGSize size;
            size.height = pointSize.height;
            size.width = pointSize.width;
            [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
                                         size.width,size.height)];
        }
    }
}

@end