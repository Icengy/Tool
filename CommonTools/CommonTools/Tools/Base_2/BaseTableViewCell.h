//
//  BaseTableViewCell.h
//  ArtMedia2
//
//  Created by icnengy on 2020/10/26.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import <UIKit/UIKit.h>

#define AMCellcornersRadiusDefault  CGSizeMake(8.0f, 8.0f)
NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic, assign) UIEdgeInsets insets;
@property (nonatomic ,assign) UIRectCorner corners;
@property (nonatomic ,assign) CGSize cornersRadii;

@end

NS_ASSUME_NONNULL_END
