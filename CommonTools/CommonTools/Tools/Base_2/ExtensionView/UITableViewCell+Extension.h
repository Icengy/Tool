//
//  UITableViewCell+Extension.h
//  ArtMedia2
//
//  Created by icnengy on 2020/6/18.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (Extension)
- (void)addSectionCornerWithTableView:(UITableView *)tableView tableViewCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath cornerRadius:(CGFloat)cornerRadius;
@end

NS_ASSUME_NONNULL_END
