//
//  UIFont+changeFont.m
//  JUXIU_iOS
//
//  Created by Homosum on 17/5/9.
//  Copyright © 2017年 JuXiuSheQu. All rights reserved.
//

#import "UIFont+changeFont.h"
#import <objc/runtime.h>
@implementation UIFont (changeFont)
+(void)load
{
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //
        Method oldMethod=class_getClassMethod([self class], @selector(systemFontOfSize:));
        Method newMethod=class_getClassMethod([self class], @selector(__nickyfontchanger_hyqiheiFontOfSize:));
        method_exchangeImplementations(oldMethod, newMethod);
    });
}
+ (UIFont *)__nickyfontchanger_hyqiheiFontOfSize:(CGFloat)fontSize{
    UIFont *font;
//    if (SCREEN_HEIGHT == 568) {
//        font = [UIFont fontWithName:@"HYQiHei-55S.otf" size:(fontSize-1)];
//    }else{
//    font = [UIFont fontWithName:@"HYQiHei-55S.otf" size:fontSize];
//    }
    if (!font)return SCREEN_HEIGHT <= 568?[self __nickyfontchanger_hyqiheiFontOfSize:(fontSize-2)]:[self __nickyfontchanger_hyqiheiFontOfSize:(fontSize)];
//    if(!font){
//        if (SCREEN_HEIGHT == 568) {
//            return [self __nickyfontchanger_hyqiheiFontOfSize:(fontSize-1)];
//        }else{
//            if (fontSize == 12) {
//                return [self __nickyfontchanger_hyqiheiFontOfSize:(fontSize+1)];
//            }
//            return font;
//        }
//    }
    return font;
}
@end
