//
//  AMPaySelectViewCell.m
//  ArtMedia2
//
//  Created by icnengy on 2020/5/21.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "AMPaySelectViewCell.h"

#import "AMPaySelectView.h"

#import "AMPayModel.h"

@interface AMPaySelectViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectIV;

@end

@implementation AMPaySelectViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _titleLabel.font = [UIFont addHanSanSC:14.0f fontType:0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    _selectIV.hidden = !selected;
}


- (void)setModel:(AMPayModel *)model {
    _model = model;
    if ([ToolUtil isEqualToNonNull:_model.iconStr]) {
        _iconIV.image = ImageNamed(_model.iconStr);
    }
    _titleLabel.text = [ToolUtil isEqualToNonNullKong:_model.titleStr];
    _selectIV.hidden = !_model.isSelected;
}


@end
