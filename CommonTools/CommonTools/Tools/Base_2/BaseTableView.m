//
//  BaseTableView.m
//  ArtMedia2
//
//  Created by icnengy on 2020/6/12.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype) initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        self.alwaysBounceVertical = YES;
        self.bgColorStyle = AMBaseBackgroundColorStyleDetault;
    }return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.alwaysBounceVertical = YES;
        self.bgColorStyle = AMBaseBackgroundColorStyleDetault;
    }return self;
}

- (void)setBgColorStyle:(AMBaseTableViewBackgroundColorStyle)bgColorStyle {
    _bgColorStyle = bgColorStyle;
    if (_bgColorStyle == AMBaseTableViewBackgroundColorStyleDetault) {
        self.backgroundColor = UIColor.clearColor;
    }
    if (_bgColorStyle == AMBaseTableViewBackgroundColorStyleWhite) {
        self.backgroundColor = UIColor.whiteColor;
    }
    if (_bgColorStyle == AMBaseTableViewBackgroundColorStyleGray) {
        self.backgroundColor = RGB(247, 247, 247);
    }
}


/**
 同时识别多个手势

 @param gestureRecognizer gestureRecognizer description
 @param otherGestureRecognizer otherGestureRecognizer description
 @return return value description
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return self.multipleGestureEnable;
}


@end
