//
//  UISegmentedControl+Style.h
//  ArtMedia2
//
//  Created by 美术传媒 on 2020/1/7.
//  Copyright © 2020 lcy. All rights reserved.
//
//
//#if !TARGET_OS_IOS
//#import <AppKit/AppKit.h>
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UISegmentedControl (Style)
/// UISegmentedControl 将iOS13风格转化成iOS12之前的风格样式
- (void)ensureiOS12Style;
@end

NS_ASSUME_NONNULL_END
