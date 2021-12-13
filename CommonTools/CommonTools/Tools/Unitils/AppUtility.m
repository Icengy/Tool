//
//  AppUtility.m
//  ESTicket
//
//  Created by 鹏 刘 on 15/11/26.
//  Copyright © 2015年 鹏 刘. All rights reserved.
//

#import "AppUtility.h"
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "STPhotoKitController.h"
#import "UIImagePickerController+ST.h"
#import "STConfig.h"
#import "TZImagePickerController.h"


#define ES_CURRENT_USER_KEY     @"es_current_user_info"

@implementation ESCurrentUser
MJCodingImplementation

@end

@interface AppUtility ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,STPhotoKitDelegate,TZImagePickerControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imageC;
@property (nonatomic, strong) UIImagePickerController *videoC;

@end


@implementation AppUtility

static AppUtility *instance = nil;

+ (AppUtility*)getInstance{
    @synchronized(self)
    {
        if (instance == nil)
        {
            instance = [[AppUtility alloc] init];
        }
    }
    return instance;
}

- (id)init{
    if (self = [super init]){
        // 当前用户缓存(会持久化)
        _currentUser = (ESCurrentUser *)[NSKeyedUnarchiver unarchiveObjectWithFile:[NSString stringWithFormat:@"%@/%@",[[LPSystemManager sharedInstance] userInfoFilePath],ES_CURRENT_USER_KEY]];
        if (nil == self.currentUser){
            _currentUser = [[ESCurrentUser alloc] init];
//            _currentUser.userName = @"";
//            _currentUser.token = @"";
//            _currentUser.userId = @"-1";
//            _currentUser.openduobao = @"";
//            _currentUser.rcUserId = @"";
//            _currentUser.rcUserName = @"";
//            _currentUser.rcUserIcon = @"";
//            _currentUser.upDateTime = @"0";
//            _currentUser.rcShopManagerId = @"";
//            _currentUser.rcShopManagerName = @"";
//            _currentUser.iconURLArrayJsonStr = @"";
//            _currentUser.kefuphone = @"";
//            _currentUser.realName = @"";
//            _currentUser.shopMobile = @"";
        }
    }
    return self;
}

- (BOOL)checkCurrentUser{
    //有用户名和密码或者有token就可以登录
    if ([CommonUtils stringIsUsefull:self.currentUser.token]){
        return YES;
    }
    else{
        return NO;
    }
}

- (void)saveCurrentUser
{
    [NSKeyedArchiver archiveRootObject:self.currentUser toFile:[NSString stringWithFormat:@"%@/%@",[[LPSystemManager sharedInstance] userInfoFilePath],ES_CURRENT_USER_KEY]];
    NSLog(@"%@",[[LPSystemManager sharedInstance] userInfoFilePath]);
}

- (void)clearCurrentUser
{
    self.currentUser.userName = @"";
	self.currentUser.level = @(0);
    self.currentUser.token = @"";
    self.currentUser.userId = @(0);
    self.currentUser.avatar = @"";
    self.currentUser.gallopAccountAmount = @(0);
    self.currentUser.couponAmount = @(0);
    self.currentUser.pushMessageCount = @(0);
	self.currentUser.interactMessageCount = @(0);
    self.currentUser.gallopIndex = @(0);
    self.currentUser.allRedIndex = @(0);
    self.currentUser.role = @(0);
    self.currentUser.email = @"";
    self.currentUser.phone = @"";
    [self saveCurrentUser];
}

//弹出登录
- (void)showLoginViewController{
    LoginViewController *viewController =  [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    
    ESNavigationViewController *navigationController = [[ESNavigationViewController alloc]initWithRootViewController:viewController];
    [APP_DELEGATE.window.rootViewController presentViewController:navigationController animated:YES completion:^{
        [App_Utility clearCurrentUser];
    }];
}

//弹出一个VC
-(void)presentVC:(UIViewController*)vc
{
     ESNavigationViewController *navigationController = [[ESNavigationViewController alloc]initWithRootViewController:vc];
    [APP_DELEGATE.window.rootViewController presentViewController:navigationController animated:YES completion:^{
    }];
}

#pragma mark - 非空判断
+ (BOOL)isEqualToNonNull:(id)value {
    if (!value ||
        value == NULL ||
        [value isEqual:@""] ||
        [value isKindOfClass:[NSNull class]] ||
        [value isEqual:@"(null)"] ||
        [value isEqual:@"<null>"] ||
        [value isEqual:@"(NULL)"] ||
        [value isEqual:@"<NULL>"]) {
        return NO;
    }
    return YES;
}

+ (NSString *)isEqualToNonNull:(id)value replace:(id)replace {
    if ([AppUtility isEqualToNonNull:value]) {
        return value;
    }
    return replace;
}

#pragma mark - photo
- (void)usePhotoForGetImage
{
    UIActionSheet *picSheet = [[UIActionSheet alloc]
                               initWithTitle:nil
                               delegate:self
                               cancelButtonTitle:@"取消"
                               destructiveButtonTitle:nil
                               otherButtonTitles: @"相机拍摄", @"从相册里选择",nil];
    
	picSheet.tag = 10000;
    [picSheet showInView:[LPUnitily currentViewController].view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (actionSheet.tag == 10000) {
		//相册
		if (buttonIndex == actionSheet.cancelButtonIndex)
		{
			self.completeImage = 0;
			if ([self.delegate respondsToSelector:@selector(completePhotoImageFaild)]) {
				[self.delegate completePhotoImageFaild];
			}
		}
		switch (buttonIndex)
		{
			case 0:{
				[self addCamera];
			}
				break;
			case 1:{  //打开本地相册
				[self selectFromPhotoLibray];
			}
				break;
		}
	} else {
		//视频
		if (buttonIndex == actionSheet.cancelButtonIndex)
			{
			self.completeImage = 0;
			if ([self.delegate respondsToSelector:@selector(completeVideoImageFaild)]) {
				[self.delegate completeVideoImageFaild];
			}
			}
		switch (buttonIndex)
			{
				case 0:{
					[self addVideo];
				}
				break;
				case 1:{  //打开本地视频相册
					[self selectFromVideoLibray];
				}
				break;
			}
	}
}

- (void)addCamera
{
	//打开照相机拍照
	NSLog(@"打开相机");
	//判断设备里面有没有照相机
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		
		NSString *mediaType = AVMediaTypeVideo;
		AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
		if(authStatus == ALAuthorizationStatusRestricted || authStatus == ALAuthorizationStatusDenied){
			
			UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请在设备的 设置-隐私-相机 中允许访问相机。" preferredStyle:UIAlertControllerStyleAlert];
			UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
				self.completeImage = 0;
				[[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
			}];
			[alertVC addAction:action];
			[APP_DELEGATE.window.rootViewController presentViewController:alertVC animated:YES completion:nil];
			
			return;
		}else{
			//创建一个图片选择器
			self.imageC = [[UIImagePickerController alloc]init];
			//指定图片来源
			self.imageC.sourceType = UIImagePickerControllerSourceTypeCamera;//从内置的照相机取照片或视频
			self.imageC.delegate = self;
			self.imageC.allowsEditing = NO;//设置为yes时,取出图片后会对图片进行放大或缩小以及移动位置
			[[LPUnitily currentViewController] presentViewController:self.imageC animated:YES completion:nil];
		}
	} else {
		UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该设备不支持照相功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
		[alertV show];
		if ([self.delegate respondsToSelector:@selector(completePhotoImageFaild)]) {
			[self.delegate completePhotoImageFaild];
		}
	}
}

- (void) selectFromPhotoLibray{
	PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
	if (status == PHAuthorizationStatusAuthorized) {
		NSLog(@"打开相册");
		if (self.completeImage == 3) {
			//社区发帖使用多张图片选择器
			if (self.seletedImageCount >= 9) {
				[CMMUtility showToastWithText:@"最多选择9张图片"];
				return;
			}
			TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:(9 - self.seletedImageCount) delegate:self];
			imagePicker.allowPickingVideo = NO;
			imagePicker.allowPickingOriginalPhoto = NO;
			
			[[LPUnitily currentViewController] presentViewController:imagePicker animated:YES completion:nil];
		} else {
			//创建一个图片选择器
			self.imageC = [[UIImagePickerController alloc]init];
			//指定图片来源
			self.imageC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//从现有的照片库取照片
			self.imageC.delegate = self;
			self.imageC.allowsEditing = NO;//设置为yes时,取出图片后会对图片进行放大或缩小以及移动位置
			[[LPUnitily currentViewController] presentViewController:self.imageC  animated:YES completion:nil];
		}
	} else if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
		UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"应用相册获取照片权限受限,请在设置中启用" preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
		}];
		[alertVC addAction:action];
		[APP_DELEGATE.window.rootViewController presentViewController:alertVC animated:YES completion:nil];
	}
	
	[PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
		if (status == PHAuthorizationStatusAuthorized) {
			NSLog(@"Authorized");
		}else{
			NSLog(@"Denied or Restricted");
		}
	}];
}

#pragma mark - 1.STPhotoKitDelegate的委托
- (void)photoKitController:(STPhotoKitController *)photoKitController resultImage:(UIImage *)resultImage
{
	UIImage *image = [resultImage imageByScalingToSize:CGSizeMake(resultImage.size.width*0.7, resultImage.size.height*0.7)];
	//    //图片压缩
	NSData *imageData = UIImageJPEGRepresentation([LPUnitily rotateImage:image], 0.5);
	UIImage *doneImage = [UIImage imageWithData:imageData];
	if (self.delegate && [self.delegate respondsToSelector:@selector(getPhotoImageSuccessWithImage:)]) {
		[self.delegate getPhotoImageSuccessWithImage:doneImage];
	}
	
}

#pragma mark - video
- (void)usePhotoForGetVideo {
	UIActionSheet *picSheet = [[UIActionSheet alloc]
							   initWithTitle:nil
							   delegate:self
							   cancelButtonTitle:@"取消"
							   destructiveButtonTitle:nil
							   otherButtonTitles: @"录制", @"从相册里选择",nil];
	
	picSheet.tag = 10001;
	[picSheet showInView:[LPUnitily currentViewController].view];
}

- (void)addVideo
{
	self.videoC = [[UIImagePickerController alloc] init];
	self.videoC.delegate = self;
	self.videoC.allowsEditing = YES;
	if ([self.videoC isSupportTakingPhotos]) {
		self.videoC.sourceType = UIImagePickerControllerSourceTypeCamera;
		self.videoC.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
		self.videoC.videoQuality = UIImagePickerControllerQualityTypeMedium; //录像质量
		self.videoC.videoMaximumDuration = 600.0f; //录像最长时间
		self.videoC.mediaTypes = [NSArray arrayWithObjects:@"public.movie", nil];
	} else {
		UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"应用录制权限受限,请在设置中启用" preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
		}];
		[alertVC addAction:action];
		[APP_DELEGATE.window.rootViewController presentViewController:alertVC animated:YES completion:nil];
	}
	[APP_DELEGATE.window.rootViewController presentViewController:self.videoC animated:YES completion:^{
	}];
}

- (void)selectFromVideoLibray {
	PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
	if (status == PHAuthorizationStatusAuthorized) {
		self.videoC = [[UIImagePickerController alloc] init];
		self.videoC.delegate = self;
		//资源类型为视频库
		NSString *requiredMediaType1 = (NSString *)kUTTypeMovie;
		self.videoC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		//UIImagePickerControllerSourceTypeSavedPhotosAlbum
		NSArray *arrMediaTypes=[NSArray arrayWithObjects:requiredMediaType1,nil];
		[self.videoC setMediaTypes: arrMediaTypes];
		[APP_DELEGATE.window.rootViewController presentViewController:self.videoC animated:YES completion:^{
		}];
	} else if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied){
		UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"应用相册获取视频权限受限,请在设置中启用" preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
		}];
		[alertVC addAction:action];
		[APP_DELEGATE.window.rootViewController presentViewController:alertVC animated:YES completion:nil];
	}
	
	
	[PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
		if (status == PHAuthorizationStatusAuthorized) {
			NSLog(@"Authorized");
		}else{
			NSLog(@"Denied or Restricted");
		}
	}];
}

#pragma mark - TZImagePickerController 代理
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
	if ([self.delegate respondsToSelector:@selector(completePhotoImageFaild)]) {
		[self.delegate completePhotoImageFaild];
	}
	[picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
	
	NSMutableArray *imageArr = [NSMutableArray array];
	for (UIImage *image in photos) {
		[imageArr addObject:UIImageJPEGRepresentation(image, 1)];
	}
	
	[self.delegate getPhotoImageSuccessWithImageArr:imageArr];
}

#pragma mark- 回调
/** 系统相机拍照/录制完成*/
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
	if ([mediaType isEqualToString:@"public.movie"]) {
		//视频
		if (@available(iOS 11.0, *)&&[info objectForKey:UIImagePickerControllerPHAsset]) {
			PHVideoRequestOptions*option = [[PHVideoRequestOptions alloc]init];
			option.networkAccessAllowed = YES;
			__block NSData *resultData;
			PHAsset *asset = [info objectForKey:UIImagePickerControllerPHAsset];
			[[PHImageManager defaultManager] requestAVAssetForVideo:asset options:option resultHandler:^(AVAsset *asset, AVAudioMix *audioMix, NSDictionary *info) {
				AVURLAsset* myAsset = (AVURLAsset*)asset;
				resultData = [NSData dataWithContentsOfURL:myAsset.URL];
				AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
				gen.appliesPreferredTrackTransform = YES;
				CMTime time = CMTimeMakeWithSeconds(0.0, 600);
				NSError *error = nil;
				CMTime actualTime;
				CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
				UIImage *shotImage = [[UIImage alloc] initWithCGImage:image];
				CGImageRelease(image);
				if (self.delegate && [self.delegate respondsToSelector:@selector(getVideoSuccessWithData:url:shotImage:)]) {
					[self.delegate getVideoSuccessWithData:resultData url:myAsset.URL.absoluteString shotImage:shotImage];
				}
			}];
		} else {
			NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
			NSData *videoData = [NSData dataWithContentsOfURL:videoURL];
			if (self.delegate && [self.delegate respondsToSelector:@selector(getVideoSuccessWithData:url:shotImage:)]) {
				[self.delegate getVideoSuccessWithData:videoData url:videoURL.absoluteString shotImage:nil];
			}
		}
		[picker dismissViewControllerAnimated:YES completion:nil];
	} else {
		//图片
		if (self.completeImage!=0) {
			UIImage *image = [info valueForKey:@"UIImagePickerControllerOriginalImage"];
			if (self.completeImage == 1) {
				if (self.delegate && [self.delegate respondsToSelector:@selector(completePhotoImageSuccessWithImage:)]) {
					[self.delegate completePhotoImageSuccessWithImage:image];
				}
			}else if(self.completeImage == 2 || self.completeImage == 3){
				if (self.delegate && [self.delegate respondsToSelector:@selector(getPhotoImageSuccessWithImage:)]) {
					[self.delegate getPhotoImageSuccessWithImage:image];
				}
			}
			self.completeImage = NO;
			[picker dismissViewControllerAnimated:YES completion:nil];
		}else{
			[picker dismissViewControllerAnimated:NO completion:^{
				UIImage *imageOriginal = [info objectForKey:UIImagePickerControllerOriginalImage];
				STPhotoKitController *photoVC = [STPhotoKitController new];
				[photoVC setDelegate:self];
				[photoVC setImageOriginal:imageOriginal];
				[photoVC setSizeClip:CGSizeMake(200, 200)];
				
				[[LPUnitily currentViewController] presentViewController:photoVC animated:YES completion:nil];
			}];
		}
	}
}

//cancel
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	if (picker == self.imageC) {
		self.completeImage = 0;
		if ([self.delegate respondsToSelector:@selector(completePhotoImageFaild)]) {
			[self.delegate completePhotoImageFaild];
		}
	} else {
		if ([self.delegate respondsToSelector:@selector(completeVideoImageFaild)]) {
			[self.delegate completeVideoImageFaild];
		}
	}
	
	[picker dismissViewControllerAnimated:YES completion:nil];
}
 
@end
