//
//  MainNavigationController.m
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/10/24.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import "MainNavigationController.h"

#import "PublishVideoViewController.h"
#import "HomeBaseViewController.h"
#import "MinePageViewController.h"

#import "UITabBar+Badge.h"

@interface MainNavigationController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate, UINavigationBarDelegate>

@end

@implementation MainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	//右滑手势
	self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = self;
    self.view.backgroundColor = UIColor.clearColor;
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, 0) forBarMetrics:UIBarMetricsDefault];//隐藏back文字
    self.barStyle = AMNavigationBarStyleDetault;
}

- (void)setBarStyle:(AMNavigationBarStyle)barStyle {
    _barStyle = barStyle;
    [self updateDefaultSetting];
}

#pragma mark -
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count == 1) {
        [self getBadge:viewController];
    }
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    //YES：允许右滑返回  NO：禁止右滑返回

    return YES;
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item {
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    item.backBarButtonItem = back;
    return YES;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        // 当前导航栏, 只有第一个viewController push的时候设置隐藏
        if (self.viewControllers.count == 1) {
            viewController.hidesBottomBarWhenPushed = YES;
        }
    } else {
        viewController.hidesBottomBarWhenPushed = NO;
    }
    if (@available(iOS 13.0, *)) {
        [viewController setOverrideUserInterfaceStyle:(UIUserInterfaceStyleLight)];
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 针对iOS14 隐藏tabbar的bug
- (NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    if (self.viewControllers.count > 0 ) {
        UIViewController *popController = self.viewControllers.lastObject;
        if ([popController isKindOfClass:[MinePageViewController class]] || [popController isKindOfClass:[HomeBaseViewController class]]) {
            popController.hidesBottomBarWhenPushed = NO;
        }
    }
    return [super popToRootViewControllerAnimated:animated];
}

- (NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([viewController isKindOfClass:[MinePageViewController class]] || [viewController isKindOfClass:[HomeBaseViewController class]]) {
        viewController.hidesBottomBarWhenPushed = NO;
    }
    return [super popToViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [super popViewControllerAnimated:animated];
}

- (void)updateDefaultSetting {
    [self.navigationBar setBarTintColor:_barStyle?Color_Black:Color_Whiter];
    [self.navigationBar setTintColor:_barStyle?Color_Whiter:Color_Black];
    // 导航栏文字颜色+字号
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont addHanSanSC:18.0f fontType:2], NSForegroundColorAttributeName:_barStyle?Color_Whiter:Color_Black}];
    [self.navigationBar setShadowImage:_barStyle?[UIImage new]:[UIImage imageWithColor:RGB(230, 230, 230)]];
    
    UIImage *backButtonImage = [[UIImage imageNamed:_barStyle?@"backwhite":@"back_black"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 25, 0, 0)];
    [UINavigationBar appearance].backIndicatorTransitionMaskImage = backButtonImage;
    [UINavigationBar appearance].backIndicatorImage = backButtonImage;

    if (_barStyle == AMNavigationBarStyleDetault) {
        [self.navigationBar setBackgroundImage:[UIImage imageWithColor:UIColor.whiteColor] forBarMetrics:UIBarMetricsDefault];
    }
    if (_barStyle == AMNavigationBarStyleWhite) {
        [self.navigationBar setBackgroundImage:ImageNamed(@"Wallet_预估背景") forBarMetrics:UIBarMetricsDefault];
    }
    if (_barStyle == AMNavigationBarStyleTransparent) {/// 透明
        [self.navigationBar setBackgroundImage:ImageNamed(@"transparent") forBarMetrics:UIBarMetricsDefault];
    }

}

#pragma mark -
- (void)getBadge:(id)sender {
    if ([UserInfoManager shareManager].isLogin) {
        [ApiUtil postWithParent:self url:[ApiUtilHeader getUnreadCount] needHUD:NO params:@{@"uid":[UserInfoManager shareManager].uid} success:^(NSInteger code, id  _Nullable response) {
            if (code == 0) {
                NSDictionary *dict = (NSDictionary *)response[@"data"];
                AMUserDefaultsSetObject(dict, AMUserMsg);
                if ([[dict objectForKey:@"all_user_unread_msg"] integerValue]) {
                    [self.tabBarController.tabBar showBadgeOnItemIndex:3];
                }else {
                    [self.tabBarController.tabBar hideBadgeOnItemIndex:3];
                }
                
            }
        } fail:^(NSInteger errorCode, NSString * _Nullable errorMsg) {
        }];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
