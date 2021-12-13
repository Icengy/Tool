//
//  UIFont+AddHanSansSC.m
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/10/14.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import "UIFont+AddHanSansSC.h"

@implementation UIFont (AddHanSansSC)


//SourceHanSansSC-Bold-Alphabetic
+ (UIFont *)addHanSanSC:(CGFloat)fontSize fontType:(HanSansSCType)type {
	CGFloat newFontSize = fontSize * (K_Width / 414.0f);

	switch (type) {
		case HanSansSCTypeRegular:
			return [UIFont fontWithName:@"PingFangSC-Regular" size:newFontSize];
			break;
		case HanSansSCTypeMedium:
			return [UIFont fontWithName:@"PingFangSC-Medium" size:newFontSize];
			break;
		case HanSansSCTypeBold:
			return [UIFont fontWithName:@"PingFangSC-Semibold" size:newFontSize];
			break;
        case HanSansSCTypeItalic:
            return [UIFont fontWithName:@"KlavikaMedium-Italic" size:newFontSize];
            break;
		default:
			break;
	}
	return [UIFont systemFontOfSize:fontSize];
}

@end
