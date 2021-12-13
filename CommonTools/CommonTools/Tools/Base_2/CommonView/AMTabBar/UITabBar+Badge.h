//
//  UITabBar+Badge.h
//  ArtMedia2
//
//  Created by icnengy on 2020/5/25.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (Badge)

- (void)showBadgeOnItemIndex:(NSInteger)index;
- (void)hideBadgeOnItemIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
