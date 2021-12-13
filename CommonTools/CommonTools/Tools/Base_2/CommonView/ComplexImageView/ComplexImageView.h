//
//  ComplexImageView.h
//  ArtMedia2
//
//  Created by icnengy on 2020/5/27.
//  Copyright © 2020 翁磊. All rights reserved.
//
// 两个图片重叠或单个图片显示
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComplexImageView : UIView

@property (nonatomic ,strong) NSArray <NSString *>*imageArray;

@end

NS_ASSUME_NONNULL_END
