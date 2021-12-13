//
//  BaseViewController.m
//  ArtMedia
//
//  Created by 美术传媒 on 2018/9/27.
//  Copyright © 2018年 lcy. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginViewController.h"
#import "MinePageViewController.h"

#import "UITabBar+Badge.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bgColorStyle = AMBaseBackgroundColorStyleDetault;
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    if (@available(iOS 13.0, *)) {
        [self setOverrideUserInterfaceStyle:UIUserInterfaceStyleLight];
   }
    self.barStyle = UIStatusBarStyleDefault;
    self.barHidden = NO;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [SVProgressHUD dismiss];
}

- (void)setBgColorStyle:(AMBaseBackgroundColorStyle)bgColorStyle {
    _bgColorStyle = bgColorStyle;
    switch (_bgColorStyle) {
        case AMBaseBackgroundColorStyleDetault:
            self.view.backgroundColor = Color_Whiter;
            break;
        case AMBaseBackgroundColorStyleGray:
            self.view.backgroundColor = RGB(247, 247, 247);
            break;
        case AMBaseBackgroundColorStyleBlack:
            self.view.backgroundColor = Color_Black;
            break;
        case AMBaseBackgroundColorStyleClear:
            self.view.backgroundColor = UIColor.clearColor;
            break;
            
        default:
            break;
    }
}

- (void)setNavigationBarStyle:(AMNavigationBarStyle)navigationBarStyle {
    _navigationBarStyle = navigationBarStyle;
    if ([self.navigationController isKindOfClass:[MainNavigationController class]]) {
        [(MainNavigationController *)self.navigationController setBarStyle:_navigationBarStyle];
    }
}

#pragma mark -
- (void)setBarStyle:(UIStatusBarStyle)barStyle {
    _barStyle = barStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setBarHidden:(BOOL)barHidden {
    _barHidden = barHidden;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)prefersStatusBarHidden {
	return _barHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return _barStyle;
}

#pragma mark -
-(void)jumpToLoginWithBlock:(void(^ __nullable)(id __nullable data))loginBlock {
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    loginVC.jumpClass = [self class];
    loginVC.viewControllers = self.navigationController.viewControllers;
    loginVC.loginBlock = loginBlock;

    MainNavigationController *navi = [[MainNavigationController alloc] initWithRootViewController:loginVC];
    navi.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:navi animated:YES completion:nil];
}

-(void)showMessageWithStr:(NSString*)str withType:(int)type
{
    switch (type) {
        case 0:
        {
            [SVProgressHUD showInfoWithStatus:str];
        }
            break;
        case 1:
        {
            [SVProgressHUD showSuccessWithStatus:str];
        }
            break;
        case 12:
        {
            [SVProgressHUD showErrorWithStatus:str];
        }
            break;
            
        default:
        {
            [SVProgressHUD showWithStatus:str];
        }
            break;
    }
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD show];
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    if (@available(iOS 13.0, *)) {
        [self setOverrideUserInterfaceStyle:(UIUserInterfaceStyleLight)];
        viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (NSMutableArray *)HK_dataArr {
    if (!_HK_dataArr) {
        _HK_dataArr=[[NSMutableArray alloc]init];
    }
    return _HK_dataArr;
}

- (void)removePreviousViewController:(Class)removeClass{
    NSMutableArray *vcArr = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
            for (UIViewController *vc in vcArr) {
                if ([vc isKindOfClass:removeClass]) {
                    [vcArr removeObject:vc];
                    break;
                }
            }
     self.navigationController.viewControllers = vcArr;
}
@end
