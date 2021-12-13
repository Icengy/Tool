//
//  ESTitleInputTableViewCell.m
//  ESTicket
//
//  Created by 鹏 刘 on 16/1/7.
//  Copyright © 2016年 鹏 刘. All rights reserved.
//

#import "ESTitleInputTableViewCell.h"

@implementation ESTitleInputTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier ]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([self respondsToSelector:@selector(setSeparatorInset:)])
        {
            [self setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([self respondsToSelector:@selector(setLayoutMargins:)])
        {
            [self setLayoutMargins:UIEdgeInsetsZero];
        }
        [self setupView];
        
        [self.inputTextField addTarget:self action:@selector(textFieldValueDidChange:) forControlEvents:UIControlEventValueChanged];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldValueDidChange:) name:UITextFieldTextDidChangeNotification object:self.inputTextField];
        
    }
    return self;
}

- (void)setupView
{
    @weakify(self)
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.mas_equalTo(self.contentView.mas_left).offset(SCREEN_LeftOffSet);
        make.centerY.equalTo(self.contentView);
    }];
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(105);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-SCREEN_LeftOffSet);
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(@(30));
    }];
    
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = GetFont(16.0f);
        _titleLabel.textColor = ColorTitle;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UITextField *)inputTextField
{
    if (!_inputTextField) {
        _inputTextField = [[UITextField alloc] init];
        _inputTextField.font = GetFont(15.0f);
        _inputTextField.textColor = ColorSubTitle;
        _inputTextField.secureTextEntry = YES;
        [self.contentView addSubview:_inputTextField];
    }
    return _inputTextField;
}

//监听输入框输入变化
- (void)textFieldValueDidChange:(NSNotification*)notifice{
    UITextField *textField=[notifice object];
    if (self.delegate && [self.delegate respondsToSelector:@selector(resetTitleInputTableViewCell:textFieldValueDidChange:)]) {
        [self.delegate resetTitleInputTableViewCell:self textFieldValueDidChange:textField];
    }
    
    if (self.textFieldValueDidChange) {
        self.textFieldValueDidChange(textField);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
