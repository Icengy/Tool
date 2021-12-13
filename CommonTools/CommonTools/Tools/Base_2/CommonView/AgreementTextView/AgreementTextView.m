//
//  AgreementTextView.m
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/11/18.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import "AgreementTextView.h"

@interface AgreementTextView () <UITextViewDelegate>

@end

@implementation AgreementTextView {
	clickToLinkBlock _clickBlock;
	NSString *_linkKey;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		self.editable = NO;
		self.scrollEnabled = NO;
		self.delegate = self;
		self.backgroundColor = [UIColor clearColor];
		self.textContainer.lineFragmentPadding = 0;
		self.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);

	}return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        self.editable = NO;
        self.scrollEnabled = NO;
        self.delegate = self;
        self.backgroundColor = [UIColor clearColor];
        self.textContainer.lineFragmentPadding = 0;
        self.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);

    }return self;
}

- (void)setAllText:(NSString *)allStr
		   allFont:(UIFont *_Nullable)allFont
	  allTextColor:(UIColor *_Nullable)allTextColor
		  linkText:(NSString *_Nullable)linkText
		   linkKey:(NSString *_Nullable)linkKey
		  linkFont:(UIFont *_Nullable)linkFont
	 linkTextColor:(UIColor *_Nullable)linkTextColor
			 block:(clickToLinkBlock)clickBlock; {
	
	_clickBlock = clickBlock;
	_linkKey = linkKey;
	
	self.linkTextAttributes = @{NSForegroundColorAttributeName:linkTextColor?:RGB(17, 103, 219)};
	
	NSMutableParagraphStyle *pargaraph = [[NSMutableParagraphStyle alloc] init];
	pargaraph.lineSpacing = 1.0f;
	pargaraph.alignment = NSTextAlignmentCenter;
	NSDictionary *attributes = @{NSForegroundColorAttributeName:allTextColor?:RGB(135, 138, 153),
								 NSParagraphStyleAttributeName:pargaraph,
								 NSFontAttributeName:allFont? :[UIFont addHanSanSC:12.0f fontType:0]
								 };
	
	NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:allStr attributes:attributes];
    [attributedString addAttribute:NSFontAttributeName value:linkFont? :allFont range:[allStr rangeOfString:linkText]];
	//给需要 点击事件的部分添加链接
	if (linkText.length) {
		[attributedString addAttribute:NSLinkAttributeName value:[NSString stringWithFormat:@"%@://", linkKey?:@"linkPrivacy"] range:[allStr rangeOfString:linkText]];
	}
	self.attributedText = attributedString;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
	if ([[URL scheme] isEqualToString:_linkKey?:@"linkPrivacy"]) {
		if (_clickBlock) _clickBlock(_linkKey?:nil);
	}
	return YES;
}

@end
