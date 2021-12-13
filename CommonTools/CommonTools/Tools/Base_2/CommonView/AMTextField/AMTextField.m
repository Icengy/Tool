//
//  AMTextField.m
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/12/5.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import "AMTextField.h"

@interface AMTextField () <UITextFieldDelegate>

@property (nonatomic ,strong) UILabel *countLabel;

@end

@implementation AMTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype) initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0f, self.height)];
        self.leftViewMode = UITextFieldViewModeAlways;
        
        [self addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
        
        if ([ToolUtil isEqualToNonNull:self.placeholder ]) {
            NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName : Color_Grey ,NSFontAttributeName : [UIFont addHanSanSC:(self.font.pointSize - 1) fontType:0]}];
            self.attributedPlaceholder = placeholderString;
        }
    }return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0f, self.height)];
		self.leftViewMode = UITextFieldViewModeAlways;
		
		[self addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
		
		if ([ToolUtil isEqualToNonNull:self.placeholder]) {
			NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName : Color_Grey ,NSFontAttributeName : [UIFont addHanSanSC:(self.font.pointSize - 1) fontType:0]}];
			self.attributedPlaceholder = placeholderString;
		}
	}return self;
}

//- (void)setFont:(UIFont *)font {
//	[super setFont:font];
//	[self setValue:[UIFont addHanSanSC:(font.pointSize - 1) fontType:0] forKeyPath:@"_placeholderLabel.font"];
//	[self setValue:Color_Grey forKeyPath:@"_placeholderLabel.textColor"];
//}

- (void)setPlaceholder:(NSString *)placeholder {
	[super setPlaceholder:placeholder];
	NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName : Color_Grey ,NSFontAttributeName : [UIFont addHanSanSC:(self.font.pointSize - 1) fontType:0]}];
	self.attributedPlaceholder = placeholderString;
}

- (void)textFieldDidChanged:(UITextField *)textField {
    if (_charCount != 0) {
        NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage;//键盘输入模式
        if ([lang isEqualToString:@"zh-Hans"]) {// 简体中文输入，包括简体拼音，健体五笔，简体手写
            UITextRange *selectedRange = [textField markedTextRange];
            //获取高亮部分
            UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
            //没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position) {
                if (textField.text.length > _charCount) {
                    textField.text = [textField.text substringToIndex:_charCount];
                }
            }else{ //有高亮选择的字符串，则暂不对文字进行统计和限制
            }
        }else{// 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
            if (textField.text.length > _charCount) {
                textField.text = [textField.text substringToIndex:_charCount];
            }
        }
        [self setRightText:[NSString stringWithFormat:@"%@/%@",@(textField.text.length), @(_charCount)]];
    }
}

- (void)setCharCount:(NSInteger)charCount {
	_charCount = charCount;
	if (_charCount != 0) {
		[self setRightText:[NSString stringWithFormat:@"0/%@",@(_charCount)]];
		self.rightView = self.countLabel;
		self.rightViewMode = UITextFieldViewModeAlways;
	}else {
		self.rightViewMode = UITextFieldViewModeNever;
	}
}

- (void)setText:(NSString *)text {
	[super setText:text];
	[self setRightText:[NSString stringWithFormat:@"%@/%@",@(text.length),@(_charCount)]];
}

- (void)setRightText:(NSString *)rightStr {
	CGSize size = [rightStr sizeWithFont:self.countLabel.font andMaxSize:CGSizeMake(CGFLOAT_MAX, self.height)];
	self.countLabel.frame = CGRectMake(0, 0, size.width+12.0, size.height);
	self.countLabel.text = rightStr;
}

#pragma mark -
- (UILabel *)countLabel {
	if (!_countLabel) {
		_countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, self.height)];
		
		_countLabel.font = [UIFont addHanSanSC:12.0f fontType:0];
		_countLabel.textAlignment = NSTextAlignmentLeft;
		_countLabel.textColor = Color_Grey;
		[_countLabel sizeToFit];
		
	}return _countLabel;
}

@end

@interface AMSingleInputTextField ()
@property (nonatomic ,strong) UILabel *leftLabel;
@end

@implementation AMSingleInputTextField

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        self.textAlignment = NSTextAlignmentLeft;
    }return self;
}

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        
    }return _leftLabel;
}

- (void)setMainTitle:(NSString *)mainTitle {
    _mainTitle = mainTitle;
    if ([ToolUtil isEqualToNonNull:_mainTitle]) {
        self.leftLabel.text = _mainTitle;
        [self.leftLabel sizeToFit];
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftView = self.leftLabel;
    }
}

- (void)setTitleTextAttributes:(NSDictionary<NSAttributedStringKey,id> *)titleTextAttributes {
    _titleTextAttributes = titleTextAttributes;
    if (_titleTextAttributes && _mainTitle) {
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:_mainTitle];
        [attributedStr setAttributes:_titleTextAttributes range:[_mainTitle rangeOfString:_mainTitle]];
        self.leftLabel.attributedText = attributedStr;
    }
}

@end
