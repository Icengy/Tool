//
//  AMTableBankDialogCell.m
//  ArtMedia2
//
//  Created by icnengy on 2020/6/3.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "AMTableBankDialogCell.h"

@interface AMTableBankDialogCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *markIV;

@end

@implementation AMTableBankDialogCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _nameLabel.font = [UIFont addHanSanSC:16.0 fontType:0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    self.markIV.hidden = !selected;
    self.nameLabel.textColor = selected? Color_MainBg:[UIColor blackColor];
    
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setBankInfo:(NSDictionary *)bankInfo {
    _bankInfo = bankInfo;
    _nameLabel.text = [ToolUtil isEqualToNonNullKong:[bankInfo objectForKey:@"bank_name"]];
}

@end
