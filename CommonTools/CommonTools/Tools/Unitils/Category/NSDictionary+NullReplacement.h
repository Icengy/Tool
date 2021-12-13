//
//  NSDictionary+NullReplacement.h
//  Test
//
//  Created by nero on 15/10/29.
//  Copyright © 2015年 nero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NullReplacement)
- (NSDictionary *)dictionaryByReplacingNullsWithBlanks;
@end

@interface NSArray (NullReplacement)
- (NSArray *)arrayByReplacingNullsWithBlanks; 
@end

