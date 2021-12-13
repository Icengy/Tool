//
//  NSMutableAttributedString+Size.m
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/12/2.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import "NSAttributedString+Size.h"

@implementation NSAttributedString (Size)

- (CGSize)sizeWithFont:(UIFont*)font andMaxSize:(CGSize)size {
	//特殊的格式要求都写在属性字典中
	CGRect rect = [self boundingRectWithSize:size
												options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
												context:nil];
	//返回一个矩形，大小等于文本绘制完占据的宽和高。
	return  rect.size;
}

//+ (CGSize)sizeWithString:(NSMutableString *)str andFont:(UIFont*)font  andMaxSize:(CGSize)size{
//	NSDictionary*attrs =@{NSFontAttributeName: font};
//	return  [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs  context:nil].size;
//}

/**
 *  return 动态返回字符串size大小
 *
 *  @param size   指定size
 *  @return CGSize
 */
- (CGSize)getStringRectWithMaxSize:(CGSize)size {
	NSMutableAttributedString *atrString = [[NSMutableAttributedString alloc] initWithAttributedString:self];
	NSRange range = NSMakeRange(0, atrString.length);
	
	//获取指定位置上的属性信息，并返回与指定位置属性相同并且连续的字符串的范围信息。
	NSDictionary* dic = [atrString attributesAtIndex:0 effectiveRange:&range];
	//不存在段落属性，则存入默认值
	NSMutableParagraphStyle *paragraphStyle = dic[NSParagraphStyleAttributeName];
	if (!paragraphStyle || nil == paragraphStyle) {
		paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
		paragraphStyle.lineSpacing = 0.0;//增加行高
		paragraphStyle.headIndent = 0;//头部缩进，相当于左padding
		paragraphStyle.tailIndent = 0;//相当于右padding
		paragraphStyle.lineHeightMultiple = 0;//行间距是多少倍
		paragraphStyle.alignment = NSTextAlignmentLeft;//对齐方式
		paragraphStyle.firstLineHeadIndent = 0;//首行头缩进
		paragraphStyle.paragraphSpacing = 0;//段落后面的间距
		paragraphStyle.paragraphSpacingBefore = 0;//段落之前的间距
		[atrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
	}
	
	//设置默认字体属性
	UIFont *font = dic[NSFontAttributeName];
	if (!font || nil == font) {
		font = [UIFont addHanSanSC:12.0f fontType:0];
		[atrString addAttribute:NSFontAttributeName value:font range:range];
	}
	
	NSMutableDictionary *attDic = [NSMutableDictionary dictionaryWithDictionary:dic];
	[attDic setObject:font forKey:NSFontAttributeName];
	[attDic setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
	
	CGSize strSize = [[self string] boundingRectWithSize:size
													options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
												 attributes:attDic
													context:nil].size;
	
	size = CGSizeMake(ceilf(strSize.width), ceilf(strSize.height));
	return size;
}

@end
