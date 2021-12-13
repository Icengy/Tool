//
//  NSString.m
//  ArtMedia
//
//  Created by 美术传媒 on 2019/7/15.
//  Copyright © 2019 lcy. All rights reserved.
//

#import "NSString+Size.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5)

+ (NSString *)md5String:(NSString *)str;
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (uint32_t)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)md5
{
    return [NSString md5String:self];
}

@end

@implementation NSString(Size)

- (CGSize)sizeWithFont:(UIFont*)font andMaxSize:(CGSize)size {
    //特殊的格式要求都写在属性字典中
	NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self
																					   attributes:@{NSFontAttributeName:font}];
	
	CGRect rect = [attributeString boundingRectWithSize:size
												options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
												context:nil];
    //返回一个矩形，大小等于文本绘制完占据的宽和高。
	return  rect.size;
}

+ (CGSize)sizeWithString:(NSString*)str andFont:(UIFont*)font  andMaxSize:(CGSize)size{
    NSDictionary*attrs =@{NSFontAttributeName: font};
    return  [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs  context:nil].size;
}


- (CGSize)sizeWithFont:(UIFont*)font andMaxSize:(CGSize)size numberOfLines:(NSInteger)numberOfLines {
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.text = self;
    label.numberOfLines = numberOfLines;
    CGSize constraint = [label sizeThatFits:size];
    return constraint;
}

@end
