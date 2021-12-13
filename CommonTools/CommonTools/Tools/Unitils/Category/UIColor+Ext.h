//
//  UIColor+Ext.h
//  ESTicket
//
//  Created by phoenix on 15/10/23.
//  Copyright © 2015年 SEU. All rights reserved.
//

@interface UIColor (IdentifierAddition)

+ (instancetype)colorFromSelectorString:(NSString*)str;

+ (UIColor*)colorWithCSS:(NSString*)css;
+ (UIColor*)colorWithHex:(NSUInteger)hex;

- (uint)hex;
- (NSString*)hexString;
- (NSString*)cssString;

@end
