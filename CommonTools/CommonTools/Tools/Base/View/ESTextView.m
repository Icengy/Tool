//
//  ESTextView.m
//  ESTicket
//
//  Created by 鹏 刘 on 15/11/23.
//  Copyright © 2015年 鹏 刘. All rights reserved.
//

#import "ESTextView.h"

@implementation ESTextView

- (void)dealloc
{
    @try{
        [[NSNotificationCenter defaultCenter]removeObserver:self];//移除通知
    } @catch(id anException) {
        //do nothing, obviously it wasn't attached because an exception was thrown
    }
}

#pragma mark - Setters

- (void)setPlaceholder:(NSString *)placeholder{
    if([placeholder isEqualToString:_placeholder]) {
        return;
    }
    
    _placeholder = placeholder;
    [self setNeedsDisplay];
}

#pragma mark - Text view overrides

- (void)setText:(NSString *)text {
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    [super setContentInset:contentInset];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    [super setTextAlignment:textAlignment];
    [self setNeedsDisplay];
}

#pragma mark - Notifications

- (void)didReceiveTextDidChangeNotification:(NSNotification *)notification {
    [self setNeedsDisplay];
}

#pragma mark - Life cycle

- (void)setup {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveTextDidChangeNotification:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
    
    self.placeholderColor = [UIColor lightGrayColor];
    
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    //    self.contentInset = UIEdgeInsetsMake(-5.0f, 0.0f, -5.0f, 0.0f);
    self.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    self.scrollEnabled = YES;
    self.scrollsToTop = NO;
    self.userInteractionEnabled = YES;
    self.font = GetFont(15);
    self.textColor = [UIColor blackColor];
    self.backgroundColor = [UIColor whiteColor];
    self.keyboardAppearance = UIKeyboardAppearanceDefault;
    self.keyboardType = UIKeyboardTypeDefault;
    self.returnKeyType = UIReturnKeyDefault;
    self.textAlignment = NSTextAlignmentLeft;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if([self.text length] == 0 && self.placeholder) {
        CGRect placeHolderRect = CGRectMake(5.0f,
                                            7.0f,
                                            rect.size.width,
                                            rect.size.height);
        
        [self.placeholderColor set];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        paragraphStyle.alignment = self.textAlignment;
        
        [self.placeholder drawInRect:placeHolderRect
                      withAttributes:@{ NSFontAttributeName : self.font,
                                        NSForegroundColorAttributeName : self.placeholderColor,
                                        NSParagraphStyleAttributeName : paragraphStyle }];
    }
}

@end
