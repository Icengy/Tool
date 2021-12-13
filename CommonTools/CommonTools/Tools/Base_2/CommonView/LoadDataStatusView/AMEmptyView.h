//
//  AMEmptyView.h
//  ArtMedia2
//
//  Created by icnengy on 2020/6/5.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "LYEmptyViewHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface AMEmptyView : LYEmptyView

+ (instancetype)am_EmptyView;
+ (instancetype)am_EmptyView:(NSString *_Nullable)imageStr;
+ (instancetype)am_emptyImageStr:(NSString *_Nullable)imageStr titleStr:(NSString *_Nullable)titleStr detailStr:(NSString *_Nullable)detailStr;

+ (instancetype)am_emptyActionViewWithTarget:(id)target action:(SEL)action;
+ (instancetype)am_emptyActionViewWithTarget:(id)target titleStr:(NSString *_Nullable)titleStr detailStr:(NSString *_Nullable)detailStr action:(SEL)action;
+ (instancetype)am_emptyActionViewWithTarget:(id)target imageStr:(NSString *_Nullable)imageStr action:(SEL)action;

/// 全功能
+ (instancetype)am_emptyActionViewWithTarget:(id)target imageStr:(NSString *_Nullable)imageStr titleStr:(NSString *_Nullable)titleStr detailStr:(NSString *_Nullable)detailStr btnTitleStr:(NSString *_Nullable)btnTitleStr action:(SEL)action;


@end

NS_ASSUME_NONNULL_END
