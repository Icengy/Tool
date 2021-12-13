//
//  AMTextView.m
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/12/5.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import "AMTextView.h"

@interface AMTextView () <UITextViewDelegate>

@property (nonatomic ,strong) UILabel *countLabel;

@end

@implementation AMTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self initSubViews];
    }return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self initSubViews];
	}return self;
}

- (void)initSubViews {
	self.delegate = self;
	
    self.tintColor = Color_Grey;
	self.placeholderColor = Color_Grey;
	self.charCount = 0;
	
	[self addSubview:self.countLabel];
}

- (void)layoutSubviews {
	[super layoutSubviews];
    
    if (_charCount != 0) {
        self.countLabel.hidden = NO;
        if (self.text.length > _charCount) {
            self.text = [self.text substringToIndex:_charCount];
        }
        if (self.height < self.contentSize.height) {
            self.countLabel.origin = CGPointMake(self.width-self.countLabel.width-10.0f, self.contentSize.height-self.countLabel.height-10.0f);
        }else {
            self.countLabel.origin = CGPointMake(self.width-self.countLabel.width-10.0f, self.height-self.countLabel.height-10.0f);
        }
    }else {
        self.countLabel.hidden = YES;
    }
}

#pragma mark -
- (void)textViewDidChange:(UITextView *)textView {
    if (_charCount != 0) {
        self.placeholdLabel.hidden = textView.text.length;
        NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage;//键盘输入模式
        if ([lang isEqualToString:@"zh-Hans"]) {// 简体中文输入，包括简体拼音，健体五笔，简体手写
            UITextRange *selectedRange = [textView markedTextRange];
            //获取高亮部分
            UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
            //没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position) {
                if (textView.text.length >_charCount) {
                    textView.text = [textView.text substringToIndex:_charCount];
                }
            }else{ //有高亮选择的字符串，则暂不对文字进行统计和限制
            }
        }else{// 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
            if (textView.text.length >_charCount) {
                textView.text = [textView.text substringToIndex:_charCount];
            }
        }
        self.countLabel.text = [NSString stringWithFormat:@"%@/%@",@(self.text.length), @(_charCount)];
        [self.countLabel sizeToFit];
    }
    if ([self.ownerDelegate respondsToSelector:@selector(amTextViewDidChange:)]) {
        [self.ownerDelegate amTextViewDidChange:self];
    }
    if (_textViewChangedBlock) _textViewChangedBlock(textView.text);
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
	if ([self.ownerDelegate respondsToSelector:@selector(amTextViewShouldEndEditing:)]) {
		return [self.ownerDelegate amTextViewShouldEndEditing:self];
	}
	return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([self.ownerDelegate respondsToSelector:@selector(amTextViewShouldBeginEditing:)]) {
        return [self.ownerDelegate amTextViewShouldBeginEditing:self];
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return YES;
}

#pragma mark -
- (void)setCharCount:(NSInteger)charCount {
	_charCount = charCount;
	if (_charCount != 0) {
		self.countLabel.hidden = NO;
		self.countLabel.text = [NSString stringWithFormat:@"0/%@",@(_charCount)];
		[self.countLabel sizeToFit];
        self.countLabel.origin = CGPointMake(self.width-self.countLabel.width-10.0f, self.height-self.countLabel.height-10.0f);
	}else {
		self.countLabel.hidden = YES;
	}
}

#pragma mark -
- (void)setFont:(UIFont *)font {
	[super setFont:font];
	self.placeholderFont = [UIFont addHanSanSC:font.pointSize - 1 fontType:0];
}

- (void)setText:(NSString *)text {
	[super setText:text];
	
	self.placeholdLabel.hidden = text.length;
	if (_charCount != 0) {
		self.countLabel.hidden = NO;
		self.countLabel.text = [NSString stringWithFormat:@"%@/%@",@(text.length), @(_charCount)];
		[self.countLabel sizeToFit];
	}else {
		self.countLabel.hidden = YES;
	}
}

#pragma mark -
- (UILabel *)countLabel {
	if (!_countLabel) {
		_countLabel = [[UILabel alloc] init];
		
//		_countLabel.text = [NSString stringWithFormat:@"0/%@", @(_charCount)];
		_countLabel.font = [UIFont addHanSanSC:12.0f fontType:0];
		_countLabel.textAlignment = NSTextAlignmentLeft;
		_countLabel.textColor = Color_Grey;
		[_countLabel sizeToFit];
		_countLabel.userInteractionEnabled = NO;
		
	}return _countLabel;
}

@end
