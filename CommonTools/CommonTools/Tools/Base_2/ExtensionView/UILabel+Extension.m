//
//  UILabel+Extension.m
//  ArtMedia2
//
//  Created by icnengy on 2020/7/7.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "UILabel+Extension.h"

#import <CoreText/CoreText.h>

@implementation UILabel (Extension)


- (CGRect)boundingRectForCharacterRange:(NSRange)range {
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:[self attributedText]];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:[self bounds].size];
    textContainer.lineFragmentPadding = 0;
    [layoutManager addTextContainer:textContainer];
    NSRange glyphRange;
    [layoutManager characterRangeForGlyphRange:range actualGlyphRange:&glyphRange];
    return [layoutManager boundingRectForGlyphRange:glyphRange inTextContainer:textContainer];
}

- (CGRect)boundingRectForAllCharacter {
    NSRange range = [self.text rangeOfString:self.text];
    return [self boundingRectForCharacterRange:range];
}

// label顶部对齐
- (void)topAlignment
{
    CGSize size = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil];
    self.numberOfLines = 0;
    NSInteger newLinesToPad = (self.frame.size.height - rect.size.height)/size.height;
    for (NSInteger i = 0; i < newLinesToPad; i ++) {
        self.text = [self.text stringByAppendingString:@"\n "];
    }
}

// label底部对齐
- (void)bottomAlignment
{
    CGSize size = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil];
    self.numberOfLines = 0;
    NSInteger newLinesToPad = (self.frame.size.height - rect.size.height)/size.height;
    for (NSInteger i = 0; i < newLinesToPad; i ++) {
        self.text = [NSString stringWithFormat:@" \n%@",self.text];
    }
}

- (NSArray *)getLinesOfStringInLabel {
    NSString *text = [self text];
    UIFont   *font = [self font];
    CGRect    rect = [self frame];
    
    self.numberOfLines = 0;
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines)
    {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    return (NSArray *)linesArray;
//    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)self.attributedText);
//
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathAddRect(path, NULL, CGRectMake(0, 0, self.width, 1000000));
//
//    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
//
//    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
//    NSMutableArray *_lines = @[].mutableCopy;
//    for (id line in lines) {
//        CTLineRef lineRef = (__bridge CTLineRef)line;
//        CFRange lineRange = CTLineGetStringRange(lineRef);
//        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
//
//        NSString *lineString = [self.text substringWithRange:range];
//        [_lines addObject:lineString];
//    }
//    return _lines.copy;
}

- (void)addMoreInLastLine:(void (^ __nullable)(CGFloat textHeight))completion {
    NSArray *lines = [self getLinesOfStringInLabel];
    NSLog(@"%@  - %@- %@", self.text, self.attributedText,lines);
    if (lines.count > 2) {
        NSString *needStr = @"...展开》";
        NSString *subString = [NSString stringWithFormat:@"%@%@%@",lines[0], lines[1], needStr];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:subString];
        [attr addAttribute:NSFontAttributeName value:self.font range:[subString rangeOfString: subString]];
        
        [attr addAttribute:NSForegroundColorAttributeName value:Color_Red range:[subString rangeOfString:needStr]];
        [attr addAttribute:@"NeedMoreAttributeName" value:needStr range:[subString rangeOfString:needStr]];
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [attr addAttribute:NSParagraphStyleAttributeName value:style range:[subString rangeOfString: subString]];
        self.numberOfLines = 2;
        self.attributedText = attr;
        [self sizeToFit];
        NSLog(@"self.height = %.2f",self.height);
        if (completion) completion(self.height);
    }
}

- (NSDictionary*)textAttributesAtPoint:(CGPoint)pt {
    // Locate the attributes of the text within the label at the specified point
    NSDictionary* dictionary =nil;
    // First, create a CoreText framesetter
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)self.attributedText);
    CGMutablePathRef framePath =CGPathCreateMutable();
    CGPathAddRect(framePath,NULL,CGRectMake(0,0, self.frame.size.width, self.frame.size.height));
    // Get the frame that will do the rendering.
    CFRange currentRange =CFRangeMake(0,0);
    CTFrameRef frameRef =CTFramesetterCreateFrame(framesetter, currentRange, framePath,NULL);
    CGPathRelease(framePath);
    // Get each of the typeset lines
    NSArray*lines = (__bridge id)CTFrameGetLines(frameRef);
    CFIndex linesCount = [lines count];
    CGPoint *lineOrigins = (CGPoint *)malloc(sizeof(CGPoint) * linesCount);
    CTFrameGetLineOrigins(frameRef,CFRangeMake(0, linesCount), lineOrigins);
    CTLineRef line = NULL;
    CGPoint lineOrigin = CGPointZero;
    // Correct each of the typeset lines (which have origin (0,0)) to the correct orientation (typesetting offsets from the bottom of the frame)
    CGFloat bottom = self.frame.size.height;
    for (CFIndex i = 0; i < linesCount; ++i) {
        lineOrigins[i].y = self.frame.size.height- lineOrigins[i].y;
        bottom = lineOrigins[i].y;
    }
    // Offset the touch point by the amount of space between the top of the label frame and the text
    pt.y -= (self.frame.size.height - bottom) / 2;
    // Scan through each line to find the line containing the touch point y position
    for(CFIndex i = 0; i < linesCount; ++i) {
        line = (__bridge CTLineRef)[lines objectAtIndex:i];
        lineOrigin = lineOrigins[i];
        CGFloat descent, ascent;
        CGFloat width = CTLineGetTypographicBounds(line, &ascent, &descent,nil);
        if(pt.y < (floor(lineOrigin.y) + floor(descent))) {
            // Cater for text alignment set in the label itself (not in the attributed string)
            if(self.textAlignment == NSTextAlignmentCenter) {
                pt.x -= (self.frame.size.width - width) / 2;
            } else if (self.textAlignment == NSTextAlignmentRight) {
                pt.x -= (self.frame.size.width - width);
            }
            // Offset the touch position by the actual typeset line origin. pt is now the correct touch position with the line bounds
            pt.x -= lineOrigin.x;
            pt.y -= lineOrigin.y;
            // Find the text index within this line for the touch position
            CFIndex i =CTLineGetStringIndexForPosition(line, pt);
            // Iterate through each of the glyph runs to find the run containing the character index
            NSArray* glyphRuns = (__bridge id)CTLineGetGlyphRuns(line);
            CFIndex runCount = [glyphRuns count];
            for (CFIndex run = 0; run < runCount; ++ run) {
                CTRunRef glyphRun = (__bridge CTRunRef)[glyphRuns objectAtIndex:run];
                CFRange range = CTRunGetStringRange(glyphRun);
                if(i >= range.location && i<= range.location+range.length) {
                    dictionary = (__bridge NSDictionary*)CTRunGetAttributes(glyphRun);
                    break;
                }
            }
            if(dictionary) {
                break;
            }
        }
    }
    free(lineOrigins);
    CFRelease(frameRef);
    CFRelease(framesetter);
    return dictionary;
}
+ (UILabel *)setLabelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor textAliment:(NSTextAlignment)textAliment shadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)shadowOffset numberOfLines:(NSInteger)numberOfLines text:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.frame = frame;
    label.textAlignment = textAliment;
    label.text = text;
    label.numberOfLines = numberOfLines;
    label.shadowColor = shadowColor;
    label.shadowOffset = shadowOffset;
    if (backgroundColor == nil) {
        label.backgroundColor = [UIColor clearColor];
    } else {
        label.backgroundColor = backgroundColor;
    }
    label.font = font;
    label.textColor = textColor;
    
    return label;
}

+ (UILabel *)setLabelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor textAliment:(NSTextAlignment)textAliment shadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)shadowOffset text:(NSString *)text {
    
    return [UILabel setLabelWithFrame:frame font:font textColor:textColor backgroundColor:backgroundColor textAliment:textAliment shadowColor:shadowColor shadowOffset:shadowOffset numberOfLines:1 text:text];
}

+ (UILabel *)setLabelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor textAliment:(NSTextAlignment)textAliment text:(NSString *)text {
    
    return [UILabel setLabelWithFrame:frame font:font textColor:textColor backgroundColor:backgroundColor textAliment:textAliment shadowColor:nil shadowOffset:CGSizeZero text:text];
}

+ (UILabel *)setLabelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor textAliment:(NSTextAlignment)textAliment text:(NSString *)text {
    return [UILabel setLabelWithFrame:frame font:font textColor:textColor backgroundColor:[UIColor clearColor] textAliment:textAliment text:text];
}

@end
