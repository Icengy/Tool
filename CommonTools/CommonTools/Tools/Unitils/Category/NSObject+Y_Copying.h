//
//  NSObject+Y_Copying.h
//  YHJC
//
//  Created by 椰子恋人 on 16/6/23.
//  Copyright © 2016年 椰子恋人. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Y_Copying)


- (id)mj_copyWithZone:(NSZone *)zone;



#define MJY_CopyingImplementation \
- (id)copyWithZone:(NSZone *)zone {\
    \
    return [self mj_copyWithZone:zone];\
}\
\
- (id)mutableCopyWithZone:(nullable NSZone *)zone {\
    \
    return [self copyWithZone:zone];\
}\


#define MJExtensionY_CopyingImplementation MJY_CopyingImplementation

@end
