//
//  NSString+WSString.m
//  ESTicket
//
//  Created by 王帅 on 16/3/10.
//  Copyright © 2016年 鹏 刘. All rights reserved.
//

#import "NSString+WSString.h"
#import "objc/runtime.h"

@implementation NSString (WSString)

+ (void)load {
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method fromMethod = class_getInstanceMethod(objc_getClass("__NSCFString"), @selector(substringFromIndex:));
        Method toMethod = class_getInstanceMethod(objc_getClass("__NSCFString"), @selector(ws_substringFromIndex:));
        method_exchangeImplementations(fromMethod, toMethod);
    });
}

- (id)ws_substringFromIndex:(NSUInteger)index {
    if (self.length-1 < index || self.length == 0) {
        // 这里做一下异常处理，不然都不知道出错了。
        @try {
            return [self ws_substringFromIndex:index];
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
        return [self ws_substringFromIndex:index];
    }
}

@end
