//
//  AMPayVirtualCurrencyCell.m
//  ArtMedia2
//
//  Created by icnengy on 2020/7/2.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "AMPayVirtualCurrencyCell.h"

#import "AMPayModel.h"

@interface AMPayVirtualCurrencyCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;

@end


@implementation AMPayVirtualCurrencyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _titleLabel.font = [UIFont addHanSanSC:14.0f fontType:0];
    _valueLabel.font = [UIFont addHanSanSC:14.0 fontType:2];
    _tipsLabel.font = [UIFont addHanSanSC:12.0 fontType:0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(AMPayModel *)model {
    _model = model;
    _titleLabel.text = [ToolUtil isEqualToNonNullKong:_model.titleStr];
    _valueLabel.text = [ToolUtil isEqualToNonNull:_model.subTitleStr replace:@"-"];
    
    if (_model.subTitleStr && _model.needRecharge) {
        _tipsLabel.text = @"(艺币不足)";
        _tipsLabel.hidden = NO;
    }else {
        _tipsLabel.text = @"";
        _tipsLabel.hidden = YES;
    }
}

@end
