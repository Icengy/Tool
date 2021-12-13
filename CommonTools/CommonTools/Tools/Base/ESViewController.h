//
//  ESViewController.h
//  ESTicket
//
//  Created by 鹏 刘 on 15/11/23.
//  Copyright © 2015年 鹏 刘. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableView+Setting.h"

@interface ESViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) BOOL iconImageUp;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UITableView *tableView;
/** UITableViewStylePlain 类型的tableview*/
@property (nonatomic, strong) UITableView *plainTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSString *navTitleText;
@property (nonatomic, strong) UIColor * titleColor;

@property (nonatomic, assign) BOOL hideSperator;
/// 屏蔽导航栏设置（避免背景图设置影响子类）
@property (nonatomic, assign) BOOL hideBarSetting;

- (void)dismissBack:(id)sender;
- (void)back:(id)sender;

- (void)showTitleButtonView;

- (UIBarButtonItem *)createStringNavBarItem:(NSString *)title
                                  textColor:(UIColor *)textColor
                                     action:(SEL)action;
- (UIBarButtonItem *)createLeftImageNavBarItem:(NSString *)normalImageName
                                  withHightImg:(NSString *)heightedImageName
                                        action:(SEL)action;
- (UIBarButtonItem *)createImageNavBarItem:(NSString *)normalImageName
                              withHightImg:(NSString *)heightedImageName
                                    action:(SEL)action;
/** 创建一个文字导航按钮*/
- (UIBarButtonItem *)greateTextNavBarItem:(NSString *)text action:(SEL)action;

- (UIButton *)createLeftImageButton:(NSString *)normalImageName
                       hightedImage:(NSString *)heightedImageName
                             action:(SEL)action;
- (UIButton *)createImageButton:(NSString *)normalImageName
                   hightedImage:(NSString *)heightedImageName
                         action:(SEL)action;
-(UIBarButtonItem*)createRedButtonTextNavBarItem:(NSString *)text action:(SEL)action;
@end
