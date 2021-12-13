//
//  NSObject+Y_Copying.m
//  YHJC
//
//  Created by 椰子恋人 on 16/6/23.
//  Copyright © 2016年 椰子恋人. All rights reserved.
//

#import "NSObject+Y_Copying.h"
#import "NSObject+MJClass.h"
#import "NSObject+MJProperty.h"
#import "MJProperty.h"



@interface NSObject ()

@property dispatch_semaphore_t y_copyinglock;


@end



@implementation NSObject (Y_Copying)


- (id)mj_copyWithZone:(NSZone *)zone{
    
    if (!self.y_copyinglock) {
        
        self.y_copyinglock = dispatch_semaphore_create(1);
    }
    
    
    Class clazz = [self class];

    id aNew = [[clazz allocWithZone:zone] init];
    
    dispatch_semaphore_wait(self.y_copyinglock, DISPATCH_TIME_FOREVER);
    
    NSArray *allowedCodingPropertyNames = [clazz mj_totalAllowedCodingPropertyNames];
    NSArray *ignoredCodingPropertyNames = [clazz mj_totalIgnoredCodingPropertyNames];


    [clazz mj_enumerateProperties:^(MJProperty *property, BOOL *stop) {
        // 检测是否被忽略
        if (allowedCodingPropertyNames.count && ![allowedCodingPropertyNames containsObject:property.name]) return;
        if ([ignoredCodingPropertyNames containsObject:property.name]) return;
        
        id value = [property valueForObject:self];
        if (value == nil) return;
        
        [aNew setValue:value forKey:property.name];
    }];
    
    dispatch_semaphore_signal(self.y_copyinglock);
    
    return aNew;
}

- (id)mj_mutableCopyWithZone:(NSZone *)zone{
    
    return [self mj_copyWithZone:zone];
}





- (void)setY_copyinglock:(dispatch_semaphore_t)y_copyinglock{
    
    objc_setAssociatedObject(self, @selector(y_copyinglock), y_copyinglock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (dispatch_semaphore_t)y_copyinglock{
    
    
    return objc_getAssociatedObject(self, @selector(y_copyinglock));

}




@end
