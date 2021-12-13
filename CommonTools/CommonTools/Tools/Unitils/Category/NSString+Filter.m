//
//  NSString+Filter.m
//  ESTicket
//
//  Created by What on 15/07/2017.
//  Copyright © 2017 鹏 刘. All rights reserved.
//

#import "NSString+Filter.h"

@implementation NSString (Filter)
- (NSArray*)rangesOfNumbers {
    
    NSMutableArray *resutls = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < self.length; i ++) {
        
        if (([self characterAtIndex:i] >= '0' && [self characterAtIndex:i] <= '9') || [self characterAtIndex:i] == '-' ) {
            [resutls addObject: NSStringFromRange(NSMakeRange(i, 1))];
        }
    }
    return resutls;
}
@end
