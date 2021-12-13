//
//  UIScrollView+RefreshHandler.m
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/10/29.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import "UIScrollView+RefreshHandler.h"



@implementation UIScrollView (RefreshHandler)

- (void)addRefreshHeaderWithTarget:(id)target action:(SEL)action {
	MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
	header.lastUpdatedTimeLabel.hidden = YES;
	header.stateLabel.hidden = YES;
	[header setTitle:@"" forState:MJRefreshStateIdle];
	
	header.stateLabel.font = [UIFont addHanSanSC:12.0f fontType:0];
	header.stateLabel.textColor = Color_Black;
	
	self.mj_header = header;
}

- (void)addRefreshFooterWithTarget:(id)target action:(SEL)action {
    [self addRefreshFooterWithTarget:target withTitle:@"- 没有更多了 -" action:action];
}

- (void)addRefreshFooterWithTarget:(id)target withTitle:(NSString *)title action:(SEL)action {
	MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
	footer.refreshingTitleHidden = YES;
	
	footer.stateLabel.font = [UIFont addHanSanSC:12.0f fontType:0];
	footer.stateLabel.textColor = Color_Black;
	[footer setTitle:@"" forState:MJRefreshStateIdle];
	[footer setTitle:title forState:MJRefreshStateNoMoreData];
    
    footer.hidden = YES;
	
	self.mj_footer = footer;
}

- (void)updataFreshFooter:(BOOL)show {
    if (show) {
        [self.mj_footer endRefreshingWithNoMoreData];
    }else {
        [self.mj_footer setState:MJRefreshStateIdle];
    }
}

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
