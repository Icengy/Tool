//
//  NSDate+Ext.h
//  ESTicket
//
//  Created by phoenix on 14-10-10.
//  Copyright (c) 2014年 SEU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (IdentifierAddition)

+ (id)dateFormatter;
+ (id)dateFormatterWithFormat:(NSString *)dateFormat;
+ (id)defaultDateFormatter;/*yyyy-MM-dd HH:mm:ss*/


@end
