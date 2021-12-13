//
//  AMShareViewCell.m
//  ArtMedia2
//
//  Created by 美术传媒 on 2020/1/10.
//  Copyright © 2020 lcy. All rights reserved.
//

#import "AMShareViewCell.h"

@implementation AMShareViewModel

@end

#pragma mark -
@interface AMShareViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *contentIV;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation AMShareViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
	
	_contentIV.userInteractionEnabled = NO;
	
	_contentLabel.font = [UIFont addHanSanSC:12.0f fontType:0];
	_contentLabel.textColor = Color_Black;
}

- (void)setModel:(AMShareViewModel *)model {
    _model = model;
    _contentIV.image = [UIImage scale:ImageNamed([ToolUtil isEqualToNonNullKong:_model.image]) toSize:CGSizeMake(_contentIV.width*0.75, _contentIV.width*0.75)];
    _contentLabel.text = [ToolUtil isEqualToNonNullKong:_model.title];
	[_contentLabel sizeToFit];
}

@end
