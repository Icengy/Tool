//
//  NSDate+Ext.m
//  ESTicket
//
//  Created by phoenix on 14-10-10.
//  Copyright (c) 2014年 SEU. All rights reserved.
//

#import "NSDateFormatter+Ext.h"

@implementation NSDateFormatter (IdentifierAddition)

+ (id)dateFormatter
{
    return [[self alloc] init];
}

+ (id)dateFormatterWithFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[self alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

+ (id)defaultDateFormatter
{
    return [self dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

@end

