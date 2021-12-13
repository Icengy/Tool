//
//  UILabel+Custom.h
//  Gallop_iOS
//
//  Created by caizx on 2019/7/17.
//  Copyright © 2019 homosum. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Custom)
//设置行高
-(void)setLabelSpace:(CGFloat)space withFont:(UIFont*)font;
//设置特殊文字颜色
-(void)setColorArr:(NSArray *)colorArr forTextArr:(NSArray *)textArr;
@end

NS_ASSUME_NONNULL_END
