//
//  AMTableMenuDialogCell.m
//  ArtMedia2
//
//  Created by icnengy on 2020/6/3.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "AMTableMenuDialogCell.h"

@interface AMTableMenuDialogCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation AMTableMenuDialogCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _titleLabel.font = [UIFont addHanSanSC:16.0 fontType:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMenuTitle:(NSString *)menuTitle {
    _menuTitle = menuTitle;
    NSString *imageStr = [NSString stringWithFormat:@"%@_Menu",_menuTitle];
    _iconIV.image = ImageNamed(imageStr);
    _titleLabel.text = _menuTitle;
}

@end
