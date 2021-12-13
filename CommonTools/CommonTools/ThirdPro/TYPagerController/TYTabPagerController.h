//
//  TYTabPagerController.h
//  TYPagerControllerDemo
//
//  Created by tanyang on 16/5/3.
//  Copyright © 2016年 tanyang. All rights reserved.
//

#import "TYPagerController.h"

@class TYTabPagerController;

@protocol TYTabPagerControllerDelegate <TYPagerControllerDelegate>

@optional
// configre collectionview cell
- (void)pagerController:(TYTabPagerController *_Nullable)pagerController configreCell:(UICollectionViewCell *_Nullable)cell forItemTitle:(NSString *_Nullable)title atIndexPath:(NSIndexPath *_Nullable)indexPath;

- (void)pagerController:(TYTabPagerController *_Nullable)pagerController configreCell:(UICollectionViewCell *_Nullable)cell forItemBadge:(NSInteger)badge atIndexPath:(NSIndexPath *_Nullable)indexPath;

// did select indexPath
- (void)pagerController:(TYTabPagerController *_Nullable)pagerController didSelectAtIndexPath:(NSIndexPath *_Nullable)indexPath;

// did scroll to page index
- (void)pagerController:(TYTabPagerController *_Nullable)pagerController didScrollToTabPageIndex:(NSInteger)index;

// transition frome cell to cell with animated
- (void)pagerController:(TYTabPagerController *_Nullable)pagerController transitionFromeCell:(UICollectionViewCell *_Nullable)fromCell toCell:(UICollectionViewCell *_Nullable)toCell animated:(BOOL)animated;

// transition frome cell to cell with progress
- (void)pagerController:(TYTabPagerController *_Nullable)pagerController transitionFromeCell:(UICollectionViewCell *_Nullable)fromCell toCell:(UICollectionViewCell *_Nullable)toCell progress:(CGFloat)progress;

@end

typedef NS_ENUM(NSUInteger, TYPagerBarStyle) {
    TYPagerBarStyleNoneView,
    TYPagerBarStyleProgressView,
    TYPagerBarStyleProgressBounceView,
    TYPagerBarStyleProgressElasticView,
    TYPagerBarStyleCoverView
};

@interface TYTabPagerController : TYPagerController

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wobjc-property-synthesis"
@property (nonatomic, weak) id<TYTabPagerControllerDelegate> _Nullable delegate;
#pragma clang diagnostic pop

// view ,don't change frame
@property (nonatomic, weak, readonly) UIView * _Nullable pagerBarView; // pagerBarView height is contentTopEdging
@property (nonatomic, weak, readonly) UIImageView * _Nullable pagerBarImageView;
@property (nonatomic, weak, readonly) UICollectionView * _Nullable collectionViewBar;
@property (nonatomic, weak, readonly) UIView * _Nullable progressView;

@property (nonatomic, assign) TYPagerBarStyle barStyle; // you can set or ovrride barStyle

@property (nonatomic, assign) CGFloat collectionLayoutEdging; // collectionLayout left right edging

// progress view
@property (nonatomic, assign) CGFloat progressHeight;
@property (nonatomic, assign) CGFloat progressWidth; //if>0 progress width is equal,else progress width is cell width
@property (nonatomic, assign) CGFloat progressEdging; // if < 0 width + edge ,if >0 width - edge
@property (nonatomic, assign) CGFloat progressBottomEdging; // if < 0 width + edge ,if >0 width - edge

// cell
@property (nonatomic, assign) CGFloat cellWidth; // if>0 cells width is equal,else if=0 cell will caculate all titles width
@property (nonatomic, assign) CGFloat cellSpacing; // cell space
@property (nonatomic, assign) CGFloat cellEdging;  // cell left right edge ,when cellwidth == 0 valid

//   animate duration
@property (nonatomic, assign) CGFloat animateDuration;

// text font
@property (nonatomic, strong) UIFont * _Nullable normalTextFont;
@property (nonatomic, strong) UIFont * _Nullable selectedTextFont;

//shadowColor, 默认为RGBA(77, 77, 77, 1.0f)
@property (nonatomic, strong,  nullable) UIColor *customShadowColor;


// if you custom cell ,you must register cell
- (void)registerCellClass:(Class _Nullable)cellClass isContainXib:(BOOL)isContainXib;

@end

