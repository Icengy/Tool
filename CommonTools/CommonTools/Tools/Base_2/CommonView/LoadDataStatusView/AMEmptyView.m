//
//  AMEmptyView.m
//  ArtMedia2
//
//  Created by icnengy on 2020/6/5.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "AMEmptyView.h"

@implementation AMEmptyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)am_EmptyView {
    return [AMEmptyView emptyViewWithImageStr:@"list_null_img"
                                       titleStr:@""
                                      detailStr:@""];
}

+ (instancetype)am_EmptyView:(NSString *_Nullable)imageStr {
    return [AMEmptyView emptyViewWithImageStr:[ToolUtil isEqualToNonNull:imageStr]?imageStr:@"list_null_img"
                                       titleStr:@""
                                      detailStr:@""];
}

+ (instancetype)am_emptyImageStr:(NSString *_Nullable)imageStr titleStr:(NSString *_Nullable)titleStr detailStr:(NSString *_Nullable)detailStr {
    
    return [AMEmptyView emptyViewWithImageStr:[ToolUtil isEqualToNonNull:imageStr]?imageStr:@"list_null_img"
                                       titleStr:titleStr
                                      detailStr:detailStr];
}

+ (instancetype)am_emptyActionViewWithTarget:(id)target action:(SEL)action{
    return [AMEmptyView emptyActionViewWithImageStr:@"list_null_img"
                                             titleStr:@""
                                            detailStr:@""
                                          btnTitleStr:@"重新加载"
                                               target:target
                                               action:action];
}

+ (instancetype)am_emptyActionViewWithTarget:(id)target titleStr:(NSString *_Nullable)titleStr detailStr:(NSString *_Nullable)detailStr action:(SEL)action {
    return [AMEmptyView emptyActionViewWithImageStr:@""
                                             titleStr:titleStr
                                            detailStr:detailStr
                                          btnTitleStr:@"重新加载"
                                               target:target
                                               action:action];
}

+ (instancetype)am_emptyActionViewWithTarget:(id)target imageStr:(NSString *_Nullable)imageStr action:(SEL)action {
    return [AMEmptyView emptyActionViewWithImageStr:[ToolUtil isEqualToNonNull:imageStr]?imageStr:@"list_null_img"
                                             titleStr:@""
                                            detailStr:@""
                                          btnTitleStr:@"重新加载"
                                               target:target
                                               action:action];
}

+ (instancetype)am_emptyActionViewWithTarget:(id)target imageStr:(NSString *_Nullable)imageStr titleStr:(NSString *_Nullable)titleStr detailStr:(NSString *_Nullable)detailStr btnTitleStr:(NSString *_Nullable)btnTitleStr action:(SEL)action {
    return [AMEmptyView emptyActionViewWithImageStr:[ToolUtil isEqualToNonNull:imageStr]?imageStr:@"list_null_img"
                                           titleStr:titleStr
                                          detailStr:detailStr
                                        btnTitleStr:btnTitleStr
                                             target:target
                                             action:action];
}




- (void)prepare{
    [super prepare];
    
    self.backgroundColor = UIColor.clearColor;
    
    self.autoShowEmptyView = NO; //如果想要DemoEmptyView的效果都不是自动显隐的，这里统一设置为NO，初始化时就不必再一一去写了
    
    self.titleLabTextColor = RGB(112, 115, 128);
    self.titleLabFont = [UIFont addHanSanSC:17.0f fontType:0];
    
    self.actionBtnFont = [UIFont addHanSanSC:14.0f fontType:0];
    self.actionBtnCornerRadius = 4.0f;
    
    self.detailLabTextColor = UIColorFromRGB(0x9D9B98);
    self.detailLabFont = [UIFont addHanSanSC:14.0f fontType:0];
}


@end
