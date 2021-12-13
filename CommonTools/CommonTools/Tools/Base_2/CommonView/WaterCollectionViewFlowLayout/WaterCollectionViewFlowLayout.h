//
//  WaterCollectionViewFlowLayout.h
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/11/20.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterCollectionViewFlowLayout;
NS_ASSUME_NONNULL_BEGIN

@protocol WaterCollectionViewFlowLayoutDelegate <NSObject>

@required
/**
 获取每一个item的高度
 */
- (CGSize)flowLayout:(WaterCollectionViewFlowLayout *)flowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface WaterCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic ,weak) id <WaterCollectionViewFlowLayoutDelegate> delegate;

/// 列数 默认为2
@property (nonatomic ,assign) NSInteger colums;

@end

NS_ASSUME_NONNULL_END
