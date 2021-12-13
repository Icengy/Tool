//
//  AMShareViewCell.h
//  ArtMedia2
//
//  Created by 美术传媒 on 2020/1/10.
//  Copyright © 2020 lcy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMShareViewModel : NSObject

@property (nonatomic ,assign) AMShareViewItemStyle itemStyle;
@property (nonatomic ,copy ,nullable) NSString *title;
@property (nonatomic ,copy ,nullable) NSString *image;

@end

NS_ASSUME_NONNULL_BEGIN

@interface AMShareViewCell : UICollectionViewCell

@property (nonatomic, strong) AMShareViewModel *model;

@end

NS_ASSUME_NONNULL_END
