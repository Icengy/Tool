//
//  ESNavigationViewController.m
//  ESTicket
//
//  Created by 鹏 刘 on 15/11/23.
//  Copyright © 2015年 鹏 刘. All rights reserved.
//

#import "ESNavigationViewController.h"

@interface ESNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation ESNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.enabled = NO;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    self.navigationBar.barTintColor = ColorAppBlack;//ColorButtonRed;
//    //去掉模糊效果
//    UIView *navBackImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavBarHeight)];
//    navBackImageView.backgroundColor = NavgationBarColor;
//    UIImage *navBackImage = [LPUnitily createImageFromView:navBackImageView];
//    [self.navigationBar setBackgroundImage:navBackImage forBarMetrics:UIBarMetricsDefault];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
