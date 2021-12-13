//
//  BaseItemParentViewController.m
//  ArtMedia2
//
//  Created by icnengy on 2020/6/13.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "BaseItemParentViewController.h"


@interface BaseItemParentViewController ()

@end

@implementation BaseItemParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.currentIndex = 0;
    self.canScroll = YES;
}

- (TYTabButtonPagerController *)contentCarrier {
    if (!_contentCarrier) {
        _contentCarrier = [[TYTabButtonPagerController alloc] init];
        _contentCarrier.contentTopEdging = 0.0f;
    }return _contentCarrier;
}

#pragma mark - public
- (void)tableViewDidScroll:(UIScrollView *)scrollView bottomCellOffset:(CGFloat)bottomCellOffset {
    CGFloat offsetY = scrollView.contentOffset.y;
    NSDecimalNumber *offsetYNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%.2f", offsetY]];
    NSDecimalNumber *bottomCellOffsetNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%.2f", bottomCellOffset]];
    
    /// offsetY >= bottomCellOffset
    if ([offsetYNum compare:bottomCellOffsetNum] == NSOrderedDescending ||
        [offsetYNum compare:bottomCellOffsetNum] == NSOrderedSame) {
        
        [scrollView setContentOffset:CGPointMake(0, bottomCellOffsetNum.doubleValue) animated:NO];
        
        if (self.canScroll) {
            self.canScroll = NO;
            [self changeScrollStatus:!self.canScroll];
        }
    }else{
        if (!self.canScroll) {//子视图没到顶部;
            [scrollView setContentOffset:CGPointMake(0, bottomCellOffsetNum.doubleValue) animated:NO];
        }
    }
}

- (void)tableViewScrollToTopOffset {
    self.canScroll = YES;
    [self changeScrollStatus:!self.canScroll];
}

#pragma mark - prvite
- (void)changeScrollStatus:(BOOL)scrollEnabled {
    [self.contentChildArray enumerateObjectsUsingBlock:^(BaseItemViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.vcCanScroll = scrollEnabled;
        if (!scrollEnabled) {//如果cell不能滑动，代表到了顶部，修改所有子vc的状态回到顶部
            obj.scrollView.contentOffset = CGPointZero;
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
