//
//  ESAdjustTextView.m
//  Gallop_iOS
//
//  Created by lixuanye on 2020/6/11.
//  Copyright © 2020 homosum. All rights reserved.
//

#import "ESAdjustTextView.h"

@interface ESAdjustTextView()
/** placeholder的label */
@property (nonatomic,strong) UILabel *placeholderLabel;

@end

@implementation ESAdjustTextView

/** 重写初始化方法 */
- (instancetype)initWithFrame:(CGRect)frame{
	if (self = [super initWithFrame:frame]) {
		[self setupView];
	}
	return self;
}

- (void)setupView {
	// 记录初始高度
	self.clipsToBounds = NO;
	
	// 添加textView
	self.textView = [[UITextView alloc] init];
	[self addSubview:self.textView];
	self.textView.delegate = (id)self;
	self.textView.textColor = RGBCOLOR(58, 58, 58);
	self.textView.backgroundColor = [UIColor clearColor];
	self.textView.scrollEnabled = NO;
	[self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.top.bottom.equalTo(self);
	}];
	
	// 添加placeholderLabel
	self.placeholderLabel = [[UILabel alloc]init];
	[self addSubview:self.placeholderLabel];
	self.placeholderLabel.backgroundColor = [UIColor clearColor];
	self.placeholderLabel.textColor = RGBCOLOR(168, 168, 168);
	[self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self).offset(3);
		make.top.equalTo(self).offset(9);
		make.width.mas_equalTo(200);
	}];
}

// 赋值placeholder
- (void)setPlaceholder:(NSString *)placeholder{
	_placeholder = placeholder;
	self.placeholderLabel.text = placeholder;
}

// 赋值font
- (void)setFont:(UIFont *)font{
	self.textView.font = font;
	self.placeholderLabel.font = font;
}

/** textView文本内容改变时回调 */
- (void)textViewDidChange:(UITextView *)textView{
	// 计算高度
	CGFloat padding = self.textView.textContainer.lineFragmentPadding;
	CGSize size = CGSizeMake(self.textView.frame.size.width - padding * 2, CGFLOAT_MAX);
	NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.textView.font,NSFontAttributeName, nil];
	
	CGFloat curheight = [textView.text boundingRectWithSize:size
													options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
												 attributes:dic
													context:nil].size.height;
	// 如果高度小于初始化时的高度，则不赋值(仍采用最初的高度)
	if (curheight < 36) {
		[self mas_updateConstraints:^(MASConstraintMaker *make) {
			make.height.mas_equalTo(36);
		}];
	}else{
		[self mas_updateConstraints:^(MASConstraintMaker *make) {
			make.height.mas_equalTo(curheight + 23);
		}];
	}
	
	// 如果文本为空，显示placeholder
	if (textView.text.length == 0) {
		self.placeholderLabel.hidden = NO;
	}else{
		self.placeholderLabel.hidden = YES;
	}
	[self.textView scrollRangeToVisible:self.textView.selectedRange];
}

- (void)resize {
	[self textViewDidChange:self.textView];
}

@end
