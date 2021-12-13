//
//  UITableView+Setting.m
//  Gallop_iOS
//
//  Created by icengy on 2021/4/21.
//  Copyright © 2021 homosum. All rights reserved.
//
// 注册单元格 Identifier为当前cell的名称
//

#import "UITableView+Setting.h"

@implementation UITableView (Setting)


/// 注册通过xib创建的cell
/// @param cellClass cell Class
- (void)registerNibCell:(Class)cellClass {
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil] forCellReuseIdentifier:NSStringFromClass(cellClass)];
}

/// 注册纯代码创建的cell
/// @param cellClass cell Class
- (void)registerCell:(Class)cellClass {
    [self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
}

/// 通过cell类获取cell
/// @param cellClass cellClass
- (id)dequeueReusableCell:(Class)cellClass {
    return [self dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)];
}


#pragma mark -
- (void)endAllFreshing {
    if (self.mj_footer)
        [self.mj_footer endRefreshing];
    if (self.mj_header)
        [self.mj_header endRefreshing];
    
    if ([self isKindOfClass:[UITableView class]]) {
        [(UITableView *)self setAllowsSelection:YES];
    }
    if ([self isKindOfClass:[UICollectionView class]]) {
        [(UICollectionView *)self setAllowsSelection:YES];
    }
}

@end
