//
//  BaseTableView.h
//  ArtMedia2
//
//  Created by icnengy on 2020/6/12.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AMBaseTableViewBackgroundColorStyle) {
    /// 无色 clearColor
    AMBaseTableViewBackgroundColorStyleDetault                                  = 0,
    /// 灰色底 RGB(247, 247, 247)
    AMBaseTableViewBackgroundColorStyleGray,
    /// 白色底 whiteColor
    AMBaseTableViewBackgroundColorStyleWhite
};


NS_ASSUME_NONNULL_BEGIN

@interface BaseTableView : UITableView <UIGestureRecognizerDelegate>

/// 是否允许多个手势 默认NO
@property (nonatomic ,assign) BOOL multipleGestureEnable;
@property (nonatomic ,assign) AMBaseTableViewBackgroundColorStyle bgColorStyle;

@end

NS_ASSUME_NONNULL_END
