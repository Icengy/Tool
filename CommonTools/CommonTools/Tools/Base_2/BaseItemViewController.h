//
//  BaseItemViewController.h
//  ArtMedia2
//
//  Created by icnengy on 2020/6/12.
//  Copyright © 2020 翁磊. All rights reserved.
//
// 分页子视图控制器
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class BaseItemViewController;
@protocol BaseItemViewControllerDelegate <NSObject>
@optional
/**
list是否滑动到顶部
 
@param listVC listVC
@param scrollTop scrollTop
*/
- (void)itemListController:(BaseItemViewController *)listVC scrollToTopOffset:(BOOL)scrollTop;
@end

@interface BaseItemViewController : BaseViewController

@property (weak ,nonatomic) id <BaseItemViewControllerDelegate> delegate;
@property (nonatomic, assign) BOOL vcCanScroll;
@property (nonatomic ,strong) UIScrollView *scrollView;

@end

NS_ASSUME_NONNULL_END
