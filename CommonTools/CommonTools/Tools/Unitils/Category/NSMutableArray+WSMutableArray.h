//
//  NSMutableArray+WSMutableArray.h
//  ESTicket
//
//  Created by 王帅 on 16/3/10.
//  Copyright © 2016年 鹏 刘. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (WSMutableArray)

/**
 *   过滤掉相同的元素
 *
 *   @return 返回一个数组
 */
- (NSMutableArray*)filterTheSameElement;

@end
