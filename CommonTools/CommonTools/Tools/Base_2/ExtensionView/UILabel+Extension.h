//
//  UILabel+Extension.h
//  ArtMedia2
//
//  Created by icnengy on 2020/7/7.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Extension)

- (CGRect)boundingRectForCharacterRange:(NSRange)range;
- (void)topAlignment;
- (void)bottomAlignment;

- (void)addMoreInLastLine:(void (^ __nullable)(CGFloat textHeight))completion;
- (NSDictionary*)textAttributesAtPoint:(CGPoint)pt;

+ (UILabel *)setLabelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor textAliment:(NSTextAlignment)textAliment text:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
