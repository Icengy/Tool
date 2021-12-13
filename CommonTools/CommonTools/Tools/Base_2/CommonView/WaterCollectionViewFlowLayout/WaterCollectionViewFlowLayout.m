//
//  WaterCollectionViewFlowLayout.m
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/11/20.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import "WaterCollectionViewFlowLayout.h"

//@interface WaterCollectionViewFlowLayout ()
///**
// *  存放每列高度字典
// */
//@property (nonatomic, strong) NSMutableDictionary *dicOfheight;
///**
// *  存放所有item的attrubutes属性
// */
//@property (nonatomic, strong) NSMutableArray *array;
//
//@end
//
//@implementation WaterCollectionViewFlowLayout
//
//- (instancetype)init {
//	self = [super init];
//	if (self) {
//		//对默认属性进行设置
//		//默认行数 2行
//		//默认行间距 10.0f
//		//默认列间距 10.0f
//		//默认内边距 top:10 left:10 bottom:10 right:10
//
//		_lineNumber = 1;
//		self.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
//		_dicOfheight = [NSMutableDictionary dictionary];
//		_array = [NSMutableArray array];
//	}
//	return self;
//}
//
//- (void)setLineNumber:(NSInteger)lineNumber {
//	_lineNumber = lineNumber;
//}
///**
// *  准备好布局时调用
// */
//- (void)prepareLayout {
//	[super prepareLayout];
////	NSLog(@"prepareLayout - %@--%.2f--%.2f--%@",@(self.lineNumber),self.rowSpacing, self.lineSpacing, NSStringFromUIEdgeInsets(self.sectionInset));
//
//	if (_dicOfheight.allKeys.count) [_dicOfheight removeAllObjects];
//	if (_array.count) [_array removeAllObjects];
//
//	//初始化好每列的高度
//	for (NSInteger i = 0; i < self.lineNumber ; i++) {
//		[_dicOfheight setObject:@(self.sectionInset.top) forKey:[NSString stringWithFormat:@"%@",@(i)]];
//	}
//
//	NSInteger sectionsCount = [self.collectionView numberOfSections];
//	for (NSInteger i = 0; i < sectionsCount; i ++) {
//		NSInteger itemsCount = [self.collectionView numberOfItemsInSection:i];
//		for (NSInteger j = 0; j < itemsCount ; j++) {
//			NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
//			[_array addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
//		}
//	}
//}
//
///**
// *  设置可滚动区域范围
// *
// *  @return 可滚动区域的size
// */
//- (CGSize)collectionViewContentSize {
//
//	__block NSString *maxHeightline = @"0";
//	[_dicOfheight enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSNumber *obj, BOOL *stop) {
//		if ([_dicOfheight[maxHeightline] floatValue] < [obj floatValue] ) {
//			maxHeightline = key;
//		}
//	}];
//	return CGSizeMake(self.collectionView.bounds.size.width, self.sectionInset.bottom + [_dicOfheight[maxHeightline] floatValue]);
//}
//
///**
// *
// *  @return 返回视图框内item的属性，可以直接返回所有item属性
// */
//- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
////	return _array;
//	[_array addObjectsFromArray:[super layoutAttributesForElementsInRect:rect]];
//    return _array;
//}
//
///**
// *  计算indexPath下item的属性的方法
// *
// *  @return item的属性
// */
//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//	//通过indexPath创建一个item属性attr
//	UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//
//	[self layoutAttributesForHalfScreenLayout:attr indexPath:indexPath];
//
//	return attr;
//}
//
///////满屏布局
////- (void)layoutAttributesForFullScreenLayout:(UICollectionViewLayoutAttributes *)layoutAttributes indexPath:(NSIndexPath *)indexPath {
////	UIEdgeInsets sectionInset = UIEdgeInsetsZero;
////	if (self.delegate && [self.delegate respondsToSelector:@selector(flowLayout:insetInSection:)]) {
////		sectionInset = [self.delegate flowLayout:self insetInSection:indexPath.section];
////	}
////
////	NSInteger itemsCount = [self.collectionView numberOfItemsInSection:indexPath.section];
////	if (indexPath.item == 0) {
////		_firstSectionHeight += sectionInset.top;
////	}else if (indexPath.item == itemsCount - 1){
////		_firstSectionHeight += sectionInset.bottom;
////	}
////
////	//计算item宽
////	CGFloat itemW = 0.0;
////	CGFloat itemH = 0.0;
////	//计算item高
////	if (self.delegate && [self.delegate respondsToSelector:@selector(flowLayout:heightForItemAtIndexPath:)]) {
////		itemW = [self.delegate flowLayout:self heightForItemAtIndexPath:indexPath].width;
////		itemH = [self.delegate flowLayout:self heightForItemAtIndexPath:indexPath].height;
////	}else {
////		NSAssert(itemH != 0,@"Please implement computeIndexCellHeightWithWidthBlock Method");
////	}
////
//////	NSLog(@"layoutAttributesForFullScreenLayout = %.2f--- %.2f",itemW, itemH);
////	//计算item的frame
////	CGRect frame;
////	frame.size = CGSizeMake(itemW, itemH);
////	//计算item位置
////	frame.origin = CGPointMake(sectionInset.left, sectionInset.top + indexPath.item * (itemH + self.rowSpacing));
////	_firstSectionHeight += frame.size.height;
////	layoutAttributes.frame = frame;
////}
//
/////半屏布局
//- (void)layoutAttributesForHalfScreenLayout:(UICollectionViewLayoutAttributes *)layoutAttributes indexPath:(NSIndexPath *)indexPath {
//
//	//计算item宽
//	CGFloat itemW = 0.0f;
//	CGFloat itemH = 0.0f;
//	//计算item高
//	if (self.delegate && [self.delegate respondsToSelector:@selector(flowLayout:heightForItemAtIndexPath:)]) {
//		itemW = [self.delegate flowLayout:self heightForItemAtIndexPath:indexPath].width;
//		itemH = [self.delegate flowLayout:self heightForItemAtIndexPath:indexPath].height;
//	}else {
//		NSAssert(itemH != 0,@"Please implement computeIndexCellHeightWithWidthBlock Method");
//	}
//
//	//计算item的frame
//	CGRect frame;
//	frame.size = CGSizeMake(itemW, itemH);
//	//循环遍历找出高度最短行
//	__block NSString *lineMinHeight = @"0";
//	[_dicOfheight enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSNumber *obj, BOOL *stop) {
//		if ([_dicOfheight[lineMinHeight] floatValue] > [obj floatValue]) {
//			lineMinHeight = key;
//		}
//	}];
//	int line = [lineMinHeight intValue];
//	//找出最短行后，计算item位置
//	frame.origin = CGPointMake(self.sectionInset.left + line * (itemW + self.minimumLineSpacing),  [_dicOfheight[lineMinHeight] floatValue]);
//
//	_dicOfheight[lineMinHeight] = @(frame.size.height + self.minimumInteritemSpacing + [_dicOfheight[lineMinHeight] floatValue]);
//
//	layoutAttributes.frame = frame;
//}
//
/////当collectionView的bounds改变的时候，我们需要告诉collectionView是否需要重新计算布局属性，通过这个方法返回是否需要重新计算的结果。简单的返回YES会导致我们的布局在每一秒都在进行不断的重绘布局，造成额外的计算任务。
//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
//    //    NSLog(@"%s",__func__);
//    return NO;
//}

/** 默认的列数 */
//static const int WXZDefaultColumsCount = 2;

@interface WaterCollectionViewFlowLayout ()
/** 每一列的最大Y值 */
@property (nonatomic, strong) NSMutableArray *columnMaxYs;
/** 存放所有cell的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;

@property (nonatomic, strong) NSArray *heightArray;

@end

@implementation WaterCollectionViewFlowLayout 

#pragma mark -lazy
- (NSMutableArray *)columnMaxYs
{
    if (!_columnMaxYs) {
        _columnMaxYs = [[NSMutableArray alloc] init];
    }
    return _columnMaxYs;
}

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [[NSMutableArray alloc] init];
    }
    return _attrsArray;
}

- (NSArray *)heightArray
{
    if (!_heightArray) {
        _heightArray = [[NSArray alloc] init];
        _heightArray = @[@85,@105,@115,@105];
    }
    return _heightArray;
}

- (instancetype)init {
    if (self == [super init]) {
        self.colums = 2;
    }return self;
}

#pragma mark - 实现内部的方法
/**
 * 决定了collectionView的contentSize。由于collectionView将item的布局任务委托给layout对象，那么滚动区域的大小对于它而言是不可知的。自定义的布局对象必须在这个方法里面计算出显示内容的大小，包括supplementaryView和decorationView在内。
 */
- (CGSize)collectionViewContentSize
{
    if (self.colums == 1) return [super collectionViewContentSize];
    // 找出最长那一列的最大Y值
    CGFloat destMaxY = [self.columnMaxYs[0] doubleValue];
    for (NSUInteger i = 1; i<self.columnMaxYs.count; i++) {
        // 取出第i列的最大Y值
        CGFloat columnMaxY = [self.columnMaxYs[i] doubleValue];
        
        // 找出数组中的最大值
        if (destMaxY < columnMaxY) {
            destMaxY = columnMaxY;
        }
    }
    return CGSizeMake(0, destMaxY + self.sectionInset.bottom);
}
/**
 * 系统在准备对item进行布局前会调用这个方法，我们重写这个方法之后可以在方法里面预先设置好需要用到的变量属性等。比如在瀑布流开始布局前，我们可以对存储瀑布流高度的数组进行初始化。有时我们还需要将布局属性对象进行存储，比如卡片动画式的定制，也可以在这个方法里面进行初始化数组。切记要调用[super prepareLayout];
 */
//
- (void)prepareLayout {
    [super prepareLayout];
    
    if (self.colums != 1) {
        // 重置每一列的最大Y值
        [self.columnMaxYs removeAllObjects];
        for (NSUInteger i = 0; i < self.colums; i++) {
            [self.columnMaxYs addObject:@(self.headerReferenceSize.height)];
        }
        
        // 计算所有cell的布局属性
        [self.attrsArray removeAllObjects];
        NSUInteger count = [self.collectionView numberOfItemsInSection:0];
        for (NSUInteger i = 0; i < count; ++i) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.attrsArray addObject:attrs];
        }
    }
}

/**
 * 说明所有元素（比如cell、补充控件、装饰控件）的布局属性。个人觉得完成定制布局最核心的方法，没有之一。collectionView调用这个方法并将自身坐标系统中的矩形传过来，这个矩形代表着当前collectionView可视的范围。我们需要在这个方法里面返回一个包括UICollectionViewLayoutAttributes对象的数组，这个布局属性对象决定了当前显示的item的大小、层次、可视属性在内的布局属性。同时，这个方法还可以设置supplementaryView和decorationView的布局属性。合理使用这个方法的前提是不要随便返回所有的属性，除非这个view处在当前collectionView的可视范围内，又或者大量额外的计算造成的用户体验下降——你加班的原因。
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    if (self.colums == 1) return [super layoutAttributesForElementsInRect:rect];
    //找到collectionVIew的头部headReusableView并且添加到数组里，这样子就能够显示出头部里
    [self.attrsArray addObjectsFromArray:[super layoutAttributesForElementsInRect:rect]];
    return self.attrsArray;
}

/**
 * 说明cell的布局属性,相当重要的方法。collectionView可能会为了某些特殊的item请求特殊的布局属性，我们可以在这个方法中创建并且返回特别定制的布局属性。根据传入的indexPath调用[UICollectionViewLayoutAttributes layoutAttributesWithIndexPath: ]方法来创建属性对象，然后设置创建好的属性，包括定制形变、位移等动画效果在内
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.colums == 1) return [super layoutAttributesForItemAtIndexPath:indexPath];
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    /** 计算indexPath位置cell的布局属性 */
    CGSize size = CGSizeZero;
    
    //计算item高
    if (self.delegate && [self.delegate respondsToSelector:@selector(flowLayout:heightForItemAtIndexPath:)]) {
        size = [self.delegate flowLayout:self heightForItemAtIndexPath:indexPath];
    }else {
        NSAssert(size.height != 0,@"Please implement compute heightForItemAtIndexPath Method");
    }
    
    // 找出最短那一列的 列号 和 最大Y值
    CGFloat destMaxY = [self.columnMaxYs[0] doubleValue];
    NSUInteger destColumn = 0;
    for (NSUInteger i = 1; i < self.columnMaxYs.count; i++) {
        // 取出第i列的最大Y值
        CGFloat columnMaxY = [self.columnMaxYs[i] doubleValue];
        
        // 找出数组中的最小值
        if (destMaxY > columnMaxY) {
            destMaxY = columnMaxY;
            destColumn = i;
        }
    }
    // cell的x值
    CGFloat x = 0.0f;
    CGFloat y = destMaxY;
    if (size.width != [UIScreen mainScreen].bounds.size.width) {
        x = self.sectionInset.left + destColumn * (size.width + self.minimumLineSpacing);
    }
    y = destMaxY + self.minimumInteritemSpacing;
    
    // cell的frame
    attrs.frame = CGRectMake(x, y, size.width, size.height);
    
    // 更新数组中的最大Y值
    if (CGSizeEqualToSize(size, self.itemSize)) {
        self.columnMaxYs[0] = @(CGRectGetMaxY(attrs.frame));
        self.columnMaxYs[1] = @(CGRectGetMaxY(attrs.frame));
    }else {
        self.columnMaxYs[destColumn] = @(CGRectGetMaxY(attrs.frame));
    }
    
    return attrs;
}

//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
//当collectionView的bounds改变的时候，我们需要告诉collectionView是否需要重新计算布局属性，通过这个方法返回是否需要重新计算的结果。简单的返回YES会导致我们的布局在每一秒都在进行不断的重绘布局，造成额外的计算任务。
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    //    NSLog(@"%s",__func__);
    return NO;
}

@end
