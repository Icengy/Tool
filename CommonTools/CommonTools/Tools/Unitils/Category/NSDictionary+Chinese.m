//
//  NSDictionary+Chinese.m
//  ESTicket
//
//  Created by Homosum on 17/7/31.
//  Copyright © 2017年 鹏 刘. All rights reserved.
//

#import "NSDictionary+Chinese.h"

@implementation NSDictionary (Chinese)


+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        zx_swizzleSelector([self class], @selector(descriptionWithLocale:indent:), @selector(zx_descriptionWithLocale:indent:));
    });
    
}
- (NSString *)stringByReplaceUnicode:(NSString *)unicodeString
{
    NSMutableString *convertedString = [unicodeString mutableCopy];
    [convertedString replaceOccurrencesOfString:@"\\U" withString:@"\\u" options:0 range:NSMakeRange(0, convertedString.length)];
    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
    
    return convertedString;
}
- (NSString *)zx_descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    return [self stringByReplaceUnicode:[self zx_descriptionWithLocale:locale indent:level]];
}
static inline void zx_swizzleSelector(Class theClass, SEL originalSelector, SEL swizzledSelector)
{
    Method originalMethod = class_getInstanceMethod(theClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(theClass, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(theClass,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(theClass,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
