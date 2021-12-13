//
//  BaseItemParentViewController.h
//  ArtMedia2
//
//  Created by icnengy on 2020/6/13.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "BaseViewController.h"

#import "TYTabButtonPagerController.h"
#import "BaseItemViewController.h"
#import "EmptyTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseItemParentViewController : BaseViewController <UITableViewDelegate,
                UITableViewDataSource,
                TYTabPagerControllerDelegate,
                TYPagerControllerDataSource,
                BaseItemViewControllerDelegate>
@property (nonatomic, strong) TYTabButtonPagerController *contentCarrier;
@property (nonatomic ,strong) NSMutableArray <BaseItemViewController *>*contentChildArray;
@property (nonatomic ,strong) NSMutableArray *contentTitleArray;

@property (nonatomic ,assign) NSInteger currentIndex;
@property (nonatomic ,assign) BOOL canScroll;

- (void)tableViewDidScroll:(UIScrollView *)scrollView bottomCellOffset:(CGFloat)bottomCellOffset;
- (void)tableViewScrollToTopOffset;

@end

NS_ASSUME_NONNULL_END
