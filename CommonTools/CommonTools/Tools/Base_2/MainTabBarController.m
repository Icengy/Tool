//
//  MainTabBarController.m
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/10/16.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import "MainTabBarController.h"

#import "HomeBaseViewController.h"
//#import "PersonalHomepageViewController.h"
#import "MinePageViewController.h"
#import "MessageViewController.h"
#import "ArtWorkMainViewController.h"


#import "ShortVideoEntranceViewController.h"
#import "UGCKitWrapper.h"
#import "VideoListModel.h"
#import "PublishVideoViewController.h"
#import "FaceRecognitionViewController.h"
#import "PhoneAuthViewController.h"

#import "AMDialogView.h"

#import "LBTabBar.h"

#import "LoginViewController.h"

///需要禁用右滑返回功能的界面
#import "SearchViewController.h"
#import "UIImage+CropRotate.h"


@import TXLiteAVSDK_Professional;

@interface MainTabBarController () <LBTabBarDelegate, UITabBarControllerDelegate, ShortVideoEntranceDelegate, UGCKitWrapperDelegate>

@property (nonatomic ,strong) UIView *alertCarrier;
@property (nonatomic ,strong) UIView *alertView;

@property (strong, nonatomic) UGCKitTheme *theme;
@property (strong, nonatomic) UGCKitWrapper *ugcWrapper;  // UGC 业务逻辑

@end

@implementation MainTabBarController

- (UGCKitTheme *)theme {
    if (!_theme) {
        _theme = [[UGCKitTheme alloc] init];
    }return _theme;
}

- (UGCKitWrapper *)ugcWrapper {
    if (!_ugcWrapper) {
        _ugcWrapper = [[UGCKitWrapper alloc] initWithViewController:self theme:self.theme];
        _ugcWrapper.delegate = self;
    }return _ugcWrapper;
}

#pragma mark - 第一次使用当前类的时候对设置UITabBarItem的主题
+ (void)initialize {
	UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
	
	NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
	dictNormal[NSForegroundColorAttributeName] = RGB(157,155,152);
	dictNormal[NSFontAttributeName] = [UIFont addHanSanSC:12.0f fontType:0];
	
	NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
	dictSelected[NSForegroundColorAttributeName] = RGB(239, 90, 45);
	dictSelected[NSFontAttributeName] = [UIFont addHanSanSC:12.0f fontType:0];
	
	[tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
	[tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
	
	if(isiOS13) {
		[[UITabBar appearance] setUnselectedItemTintColor:RGB(157,161,179)];
	}
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedIndex = 1;
    // Do any additional setup after loading the view.
	
	[self setUpAllChildVc];
	self.delegate = self;
    
	//创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
	LBTabBar *tabbar = [[LBTabBar alloc] init];
	tabbar.myDelegate = self;
	//kvc实质是修改了系统的_tabBar
	[self setValue:tabbar forKeyPath:@"tabBar"];
    
}
#pragma mark - 初始化tabBar上除了中间按钮之外所有的按钮
- (void)setUpAllChildVc {
	
	HomeBaseViewController *homeVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([HomeBaseViewController class])];
	[self setUpOneChildVcWithVc:homeVC Image:@"main_index_bf" selectedImage:@"main_index_af" title:@"首页"];
    
    ArtWorkMainViewController *artWorkVC = [[ArtWorkMainViewController alloc]init];
    [self setUpOneChildVcWithVc:artWorkVC Image:@"main_art_bf" selectedImage:@"main_art_af" title:@"作品"];
    
    MessageViewController *messageVC = [[MessageViewController alloc]init];
    [self setUpOneChildVcWithVc:messageVC Image:@"main_message_bf" selectedImage:@"main_message_af" title:@"消息"];
    
    MinePageViewController *mineVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([MinePageViewController class])];
	[self setUpOneChildVcWithVc:mineVC Image:@"main_mine_bf" selectedImage:@"main_mine_af" title:@"我的"];
}

#pragma mark - 初始化设置tabBar上面单个按钮的方法
/**
 *  @author li bo, 16/05/10
 *
 *  设置单个tabBarButton
 *
 *  @param Vc            每一个按钮对应的控制器
 *  @param image         每一个按钮对应的普通状态下图片
 *  @param selectedImage 每一个按钮对应的选中状态下的图片
 *  @param title         每一个按钮对应的标题
 */
- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
	MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:Vc];
	
	UIImage *myImage = [UIImage imageNamed:image];
	myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	
	//tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
	Vc.tabBarItem.image = myImage;
	
	UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
	mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	
	Vc.tabBarItem.selectedImage = mySelectedImage;
	
	Vc.tabBarItem.title = title;
	
	[self addChildViewController:nav];
}

#pragma mark - LBTabBarDelegate
//点击中间按钮的代理方法
- (void)tabBarPlusBtnClick:(LBTabBar *)tabBar {
    ShortVideoEntranceViewController *videoEnteranceVC = [[ShortVideoEntranceViewController alloc] init];
    videoEnteranceVC.delegate = self;
    MainNavigationController *navi = (MainNavigationController *)self.selectedViewController;
    [navi presentViewController:videoEnteranceVC animated:YES completion:nil];
}

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
	
	NSInteger index = [tabBarController.viewControllers indexOfObject:viewController];
    if ((index == 2 || index == 3) && ![UserInfoManager shareManager].isLogin) {
		LoginViewController *loginVC = [[LoginViewController alloc] init];
		loginVC.jumpClass = [self class];
        MainNavigationController *navi = [[MainNavigationController alloc] initWithRootViewController:loginVC];
        navi.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:navi animated:YES completion:nil];
		return NO;
	}
    /// 刷新首页子页面通知
    if (index == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:AMHomeUpdatesDefaults object:nil];
    }
    
	return YES;
}


#pragma mark - UGCKitWrapperDelegate
- (void)wrapper:(UGCKitWrapper *)wrapper onPublishComplete:(TXPublishResult *)result {
    
    __block VideoListModel *model = [[VideoListModel alloc] init];
    model.check_state = @"0";
    model.image_url = result.coverURL;
    model.video_file_id = result.videoId;
    model.video_url = result.videoURL;
    model.video_localurl = result.videoPath;
    model.is_include_obj = @"0";
    model.video_length = [NSString stringWithFormat:@"%.f",[TXVideoInfoReader getVideoInfo:result.videoPath].duration];
    model.modify_state = NO;
    model.canSaveDraft = YES;
    
    @weakify(self);
    [[UIImageView new] am_setImageWithURL:result.coverURL placeholderImage:nil contentMode:UIViewContentModeScaleAspectFit completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        CGRect frame = CGRectMake(0, (image.size.height - image.size.width)/2, image.size.width, image.size.width);
        UIImage *newImage = [image croppedImageWithFrame:frame angle:0.0 circularClip:NO];
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD show];
        });
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        dispatch_group_t group = dispatch_group_create();
        dispatch_queue_t queue = dispatch_queue_create("com.changeCoverImage.newVideo", DISPATCH_QUEUE_CONCURRENT);
        dispatch_group_async(group, queue, ^{
            [ToolUtil uploadImgs:@[newImage] uploadType:5 completion:^(NSArray * _Nullable imageURls) {
                model.image_url = imageURls.lastObject;
                
                dispatch_semaphore_signal(semaphore);
            } fail:^(NSString * _Nonnull errorMsg) {
                dispatch_semaphore_signal(semaphore);
            }];
            if (semaphore) dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        });
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:^{
                @strongify(self);
                PublishVideoViewController *publishVC = [[PublishVideoViewController alloc] init];
                publishVC.videoModel = model;
                
                [(MainNavigationController *)self.selectedViewController pushViewController:publishVC animated:YES];
            }];
        });
    }];
    
    
}

- (void)wrapper:(UGCKitWrapper *)wrapper onPublishWith:(AMVideoEditer *)videoEdit {
    PublishVideoViewController *publishVC = [[PublishVideoViewController alloc] init];
    publishVC.videoEdit = videoEdit;
    
    @weakify(self);
    [self dismissViewControllerAnimated:YES completion:^{
        @strongify(self);
        [(MainNavigationController *)self.selectedViewController pushViewController:publishVC animated:YES];
    }];
}

- (void)wrapper:(UGCKitWrapper *)wrapper onGeneratedComplete:(UGCKitResult *)result {
    VideoListModel *model = [[VideoListModel alloc] init];
    model.video_localurl = result.media.videoPath;
    model.image_url = result.coverImage;
    
    PublishVideoViewController *publishVC = [[PublishVideoViewController alloc] init];
    publishVC.videoModel = model;
    @weakify(self);
    [self dismissViewControllerAnimated:YES completion:^{
        @strongify(self);
        [(MainNavigationController *)self.selectedViewController pushViewController:publishVC animated:YES];
    }];
}

#pragma mark - ShortVideoEntranceDelegate
/// 点击登陆
- (void)videoEntrance:(BaseViewController *)viewController clickToLogin:(id)sender {
    @weakify(self);
    [viewController dismissViewControllerAnimated:YES completion:^{
        @strongify(self);
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.jumpClass = [viewController class];

        MainNavigationController *navi = [[MainNavigationController alloc] initWithRootViewController:loginVC];
        navi.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:navi animated:YES completion:nil];
    }];
}
/// 点击认证
- (void)videoEntrance:(BaseViewController *)viewController clickToAuth:(id)sender {
    [viewController dismissViewControllerAnimated:YES completion:^{
        AMAuthDialogView *dialogView = [AMAuthDialogView shareInstance];
        @weakify(dialogView);
        dialogView.imageSelectedBlock = ^(AMImageSelectedMeidaType meidaType) {
            @strongify(dialogView);
            [dialogView hide];
            if (meidaType) {
                [(MainNavigationController *)self.selectedViewController pushViewController:[[PhoneAuthViewController alloc] init] animated:YES];
            }else {
                [(MainNavigationController *)self.selectedViewController pushViewController:[[FaceRecognitionViewController alloc] init] animated:YES];
            }
        };
        [dialogView show];
    }];
}

/// 点击拍摄
- (void)videoEntrance:(BaseViewController *)viewController clickToVideoShot:(id)sender {
    [SVProgressHUD show];
    @weakify(self);
    [viewController dismissViewControllerAnimated:YES completion:^{
        @strongify(self);
        UGCKitRecordConfig *config = [[UGCKitRecordConfig alloc] init];
        config.watermark = nil;
        config.minDuration = 10.0f;
        NSInteger index = 1;
        if ([UserInfoManager shareManager].isArtist) index = 5;
        config.maxDuration = 60.0f *index;
        [self.ugcWrapper showRecordViewControllerWithConfig:config];
    }];
}

/// 点击视频编辑 assets:选中的视频集合
- (void)videoEntrance:(BaseViewController *)viewController clickToVideoLoading:(nonnull id)sender {
    [SVProgressHUD show];
    @weakify(self);
    [viewController dismissViewControllerAnimated:YES completion:^{
        @strongify(self);
        [self onVideoSelectClicked];
    }];
}

/// 点击图片编辑 assets:选中的图片集合
- (void)videoEntrance:(BaseViewController *)viewController clickToImageLoading:(nonnull id)sender {
    [SVProgressHUD show];
    @weakify(self);
    [viewController dismissViewControllerAnimated:YES completion:^{
        @strongify(self);
        [self onPictureSelectClicked];
    }];
}

- (void)onVideoSelectClicked {
    UGCKitMediaPickerConfig *config = [[UGCKitMediaPickerConfig alloc] init];
    config.mediaType = UGCKitMediaTypeVideo;
    config.maxItemCount = NSIntegerMax;
    UGCKitMediaPickerViewController *imagePickerController = [[UGCKitMediaPickerViewController alloc] initWithConfig:config theme:_theme];
    MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:imagePickerController];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    __weak __typeof(self) wself = self;
    __weak UINavigationController *navigationController = nav;
    imagePickerController.completion = ^(UGCKitResult *result) {
        if (!result.cancelled && result.code == 0) {
            [wself _showVideoCutView:result inNavigationController:navigationController];
        } else {
            NSLog(@"isCancelled: %c, failed: %@", result.cancelled ? 'y' : 'n', result.info[NSLocalizedDescriptionKey]);
            [wself dismissViewControllerAnimated:YES completion:^{
                if (!result.cancelled) {
                    UIAlertController *alert =
                    [UIAlertController alertControllerWithTitle:result.info[NSLocalizedDescriptionKey]
                                                        message:nil
                                                 preferredStyle:UIAlertControllerStyleAlert];
                    [alert addAction:[UIAlertAction actionWithTitle:@"确定"
                                                              style:UIAlertActionStyleDefault
                                                            handler:nil]];
                    [self presentViewController:alert animated:YES completion:nil];
                }
            }];
        }
    };
    [self presentViewController:nav animated:YES completion:^{
        [SVProgressHUD dismiss];
    }];
}

-(void)onPictureSelectClicked {
    UGCKitMediaPickerConfig *config = [[UGCKitMediaPickerConfig alloc] init];
    config.mediaType = UGCKitMediaTypePhoto;
    config.minItemCount = 5;
    config.maxItemCount = NSIntegerMax;
    UGCKitMediaPickerViewController *imagePickerController = [[UGCKitMediaPickerViewController alloc] initWithConfig:config theme:_theme];
    MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:imagePickerController];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    __weak __typeof(self) wself = self;
    __weak UINavigationController *navigationController = nav;
    imagePickerController.completion = ^(UGCKitResult *result) {
        if (!result.cancelled && result.code == 0) {
            [wself _showVideoCutView:result inNavigationController:navigationController];
        } else {
            NSLog(@"isCancelled: %c, failed: %@", result.cancelled ? 'y' : 'n', result.info[NSLocalizedDescriptionKey]);
            [wself dismissViewControllerAnimated:YES completion:nil];
        }
    };
    [self presentViewController:nav animated:YES completion:^{
        [SVProgressHUD dismiss];
    }];
}

- (void)_showVideoCutView:(UGCKitResult *)result inNavigationController:(UINavigationController *)nav {
    UGCKitCutViewController *vc = [[UGCKitCutViewController alloc] initWithMedia:result.media theme:_theme];
    __weak __typeof(self) wself = self;
    __weak UINavigationController *weakNavigation = nav;
    vc.completion = ^(UGCKitResult *result, int rotation) {
        if ([result isCancelled]) {
            [wself dismissViewControllerAnimated:YES completion:nil];
        } else {
            [wself.ugcWrapper showEditViewController:result rotation:rotation inNavigationController:weakNavigation backMode:TCBackModePop];
        }
    };
    [nav pushViewController:vc animated:YES];
}


#pragma mark -
- (NSString *)_getCoverPath:(UIImage *)coverImage
{
    UIImage *image = coverImage;
    if (image == nil) {
        return nil;
    }

    NSString *coverPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"TXUGC"];
    coverPath = [coverPath stringByAppendingPathComponent:[self _getFileNameByTimeNow:@"TXUGC" fileType:@"jpg"]];
    if (coverPath) {
        // 保证目录存在
        [[NSFileManager defaultManager] createDirectoryAtPath:[coverPath stringByDeletingLastPathComponent]
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];

        [UIImageJPEGRepresentation(image, 1.0) writeToFile:coverPath atomically:YES];
    }
    return coverPath;
}

-(NSString *)_getFileNameByTimeNow:(NSString *)type fileType:(NSString *)fileType {
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd_HHmmss"];
    NSDate * NowDate = [NSDate dateWithTimeIntervalSince1970:now];
    ;
    NSString * timeStr = [formatter stringFromDate:NowDate];
    NSString *fileName = ((fileType == nil) ||
                          (fileType.length == 0)
                          ) ? [NSString stringWithFormat:@"%@_%@",type,timeStr] : [NSString stringWithFormat:@"%@_%@.%@",type,timeStr,fileType];
    return fileName;
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
