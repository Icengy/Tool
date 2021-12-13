//
//  NSArray+WSArray.m
//  ESTicket
//
//  Created by 王帅 on 16/3/10.
//  Copyright © 2016年 鹏 刘. All rights reserved.
//

#import "NSArray+WSArray.h"

@implementation NSArray (WSArray)

+ (void)load {
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
        Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(ws_objectAtIndex:));
        method_exchangeImplementations(fromMethod, toMethod);
    });
}

- (id)ws_objectAtIndex:(NSUInteger)index {
    if (self.count-1 < index || self.count == 0) {
        // 这里做一下异常处理，不然都不知道出错了。
        @try {
            return [self ws_objectAtIndex:index];
        }
        @catch (NSException *exception) {
            [CMMUtility showToastWithText:@"数据出现异常"];
            // 在崩溃后会打印崩溃信息，方便我们调试。
            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            NSLog(@"%@", [exception callStackSymbols]);
            return nil;
        }
        @finally {}
    } else {
        return [self ws_objectAtIndex:index];
    }
}


@end
