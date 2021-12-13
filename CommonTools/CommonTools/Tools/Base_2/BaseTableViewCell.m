//
//  BaseTableViewCell.m
//  ArtMedia2
//
//  Created by icnengy on 2020/10/26.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame {
    if (!CGSizeEqualToSize(self.cornersRadii, CGSizeZero)) {
        [self addRoundedCorners:self.corners withRadii:self.cornersRadii];
    }
    frame.origin.x += _insets.left;
    frame.size.width -= (_insets.left+_insets.right);
    
    [super setFrame:frame];
}

@end
