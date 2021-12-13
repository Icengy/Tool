//
//  ToolUtil.m
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/11/18.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import "ToolUtil.h"

#import <SDWebImage.h>

#define cachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

@implementation ToolUtil

// 缓存大小
+ (NSString *)getCachesSize {
	// 调试
#ifdef DEBUG
	
	// 如果文件夹不存在 or 不是一个文件夹, 那么就抛出一个异常
	// 抛出异常会导致程序闪退, 所以只在调试阶段抛出。发布阶段不要再抛了,--->影响用户体验
	
	BOOL isDirectory = NO;
	
	BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:cachePath isDirectory:&isDirectory];
	
	if (!isExist || !isDirectory) {
		
		NSException *exception = [NSException exceptionWithName:@"文件错误" reason:@"请检查你的文件路径!" userInfo:nil];
		
		[exception raise];
	}
	
	//发布
#else
	
#endif
	
	//1.获取“cachePath”文件夹下面的所有文件
	NSArray *subpathArray= [[NSFileManager defaultManager] subpathsAtPath:cachePath];
	
	NSString *filePath = nil;
	long long totalSize = 0;
	
	for (NSString *subpath in subpathArray) {
		
		// 拼接每一个文件的全路径
		filePath =[cachePath stringByAppendingPathComponent:subpath];
		
		BOOL isDirectory = NO;   //是否文件夹，默认不是
		
		BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];   // 判断文件是否存在
		
		// 文件不存在,是文件夹,是隐藏文件都过滤
		if (!isExist || isDirectory || [filePath containsString:@".DS"]) continue;
		
		// attributesOfItemAtPath 只可以获得文件属性，不可以获得文件夹属性，
		//这个也就是需要遍历文件夹里面每一个文件的原因
		
		long long fileSize = [[[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil] fileSize];
		
		totalSize += fileSize;
		
	}
	
	totalSize += [[SDImageCache sharedImageCache] totalDiskSize];
	
	// 2.将文件夹大小转换为 M/KB/B
	NSString *totalSizeString = nil;
	
	if (totalSize > 1000 * 1000) {
		
		totalSizeString = [NSString stringWithFormat:@"%.1fM",totalSize / 1000.0f /1000.0f];
		
	} else if (totalSize > 1000) {
		
		totalSizeString = [NSString stringWithFormat:@"%.1fKB",totalSize / 1000.0f ];
		
	} else {
		
		totalSizeString = [NSString stringWithFormat:@"%.1fB",totalSize / 1.0f];
		
	}
	
	return totalSizeString;
	
}

// 清除缓存
+ (void)removeCache:(void (^ __nullable)(BOOL finished))completion {
	
	// 1.拿到cachePath路径的下一级目录的子文件夹
	// contentsOfDirectoryAtPath:error:递归
	// subpathsAtPath:不递归
	
	NSArray *subpathArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:cachePath error:nil];
	
	// 2.如果数组为空，说明没有缓存或者用户已经清理过，此时直接return
	if (subpathArray.count == 0) {
		[SVProgressHUD showMsg:@"缓存已清理"];
		return ;
	}
	
	[SVProgressHUD showWithStatus:@"清理中，请稍后..."];
	
	NSError *error = nil;
	NSString *filePath = nil;
	BOOL flag = NO;
	
	NSString *size = [self getCachesSize];
	
	for (NSString *subpath in subpathArray) {
		filePath = [cachePath stringByAppendingPathComponent:subpath];
		if ([[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
			// 删除子文件夹
			BOOL isRemoveSuccessed = [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
			if (isRemoveSuccessed) { // 删除成功
				flag = YES;
			}
		}
	}
	
	[[SDImageCache sharedImageCache] clearMemory];
	
	[SVProgressHUD dismiss];
	if (NO == flag) {
		[SVProgressHUD showSuccess:@"缓存已清理"];
	}else {
		NSString *text = [NSString stringWithFormat:@"为您腾出%@空间",size];
		[SVProgressHUD showSuccess:text];
	}
	if (completion) completion(YES);
}

//+ (NSString *)getSecretBankNumWithBankNum:(NSString *_Nullable)bankNum {
//	if (![ToolUtil isEqualToNonNull:bankNum]) {
//		return @"";
//	}
//	if ([bankNum containsString:@" "]) bankNum =[bankNum stringByReplacingOccurrencesOfString:@" " withString:@""];
//
//	if (!bankNum.length) return @"";
//
//    NSMutableString *mutableStr = [NSMutableString stringWithString:bankNum];
//    for (int i = 0 ; i < mutableStr.length; i ++) {
//        if (i > 3 && i < mutableStr.length - 4) {
//            [mutableStr replaceCharactersInRange:NSMakeRange(i, 1) withString:@"*"];
//        }
//    }
//    NSString *text = mutableStr;
//    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
//    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
//
//    NSString *newString = @"";
//    while (text.length > 0) {
//        NSString *subString = [text substringToIndex:MIN(text.length, 4)];
//        newString = [newString stringByAppendingString:subString];
//        if (subString.length == 4) {
//            newString = [newString stringByAppendingString:@" "];
//        }
//        text = [text substringFromIndex:MIN(text.length, 4)];
//    }
//    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
//    return newString;
//}

+ (NSString *)getSecretBankNumWithBankNum:(NSString *_Nullable)bankNum {
    if (![ToolUtil isEqualToNonNull:bankNum]) {
        return @"";
    }
    if ([bankNum containsString:@" "]) bankNum =[bankNum stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (!bankNum.length) return @"";
    NSString *newBum = [bankNum substringFromIndex:bankNum.length - 4];
    return [NSString stringWithFormat:@"**** **** **** %@",newBum];
}

+ (NSString *)getSecretCardIDWitCardID:(NSString *_Nullable)cardID {
    ///先校验身份证号
    if (![ToolUtil verifyIDCardString:cardID]) return cardID;
    if ([cardID containsString:@" "]) cardID = [cardID stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (!cardID.length) return @"";
    if (cardID.length != 18) return @"";
    
    NSString *newString = [NSString stringWithFormat:@"%@ **** **** %@",[cardID substringWithRange:NSMakeRange(0, 6)], [cardID substringWithRange:NSMakeRange(cardID.length-4, 4)]];
    return newString;
}

+ (BOOL)verifyIDCardString:(NSString *)idCardString {
    if (![ToolUtil isEqualToNonNull:idCardString]) {
        return NO;
    }
    NSString *regex = @"^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isRe = [predicate evaluateWithObject:idCardString];
    if (!isRe) {
         //身份证号码格式不对
        return NO;
    }
    //加权因子 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2
    NSArray *weightingArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    //校验码 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2
    NSArray *verificationArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    NSInteger sum = 0;//保存前17位各自乖以加权因子后的总和
    for (int i = 0; i < weightingArray.count; i++) {//将前17位数字和加权因子相乘的结果相加
        NSString *subStr = [idCardString substringWithRange:NSMakeRange(i, 1)];
        sum += [subStr integerValue] * [weightingArray[i] integerValue];
    }
    
    NSInteger modNum = sum % 11;//总和除以11取余
    NSString *idCardMod = verificationArray[modNum]; //根据余数取出校验码
    NSString *idCardLast = [idCardString.uppercaseString substringFromIndex:17]; //获取身份证最后一位
    
    if (modNum == 2) {//等于2时 idCardMod为10  身份证最后一位用X表示10
        idCardMod = @"X";
    }
    if ([idCardLast isEqualToString:idCardMod]) { //身份证号码验证成功
        return YES;
    } else { //身份证号码验证失败
        return NO;
    }
}

+ (NSString *)getSecretMobileNumWitMobileNum:(NSString *_Nullable)mobileNum {
	if (!mobileNum || !mobileNum.length || mobileNum.length != 11) {
		return @"";
	}
	if ([mobileNum containsString:@" "]) {
		mobileNum =[mobileNum stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
	if (!mobileNum.length) {
		return @"";
	}
	NSMutableString *mutableStr;
	if (mobileNum.length) {
		mutableStr = [NSMutableString stringWithString:mobileNum];
		for (int i = 0 ; i < mutableStr.length; i ++) {
			if (i > 2 && i < mutableStr.length - 4) {
				[mutableStr replaceCharactersInRange:NSMakeRange(i, 1) withString:@"*"];
			}
		}
		return [mutableStr copy];
	}
	return mobileNum;
}


+ (NSString *)html5StringWithContent:(NSString *_Nullable)content withTitle:(NSString *_Nullable)title {
	if (![self isEqualToNonNull:content]) return nil;
    
	[content stringByReplacingOccurrencesOfString:@"&amp;quot" withString:@"'"];
	content = [content stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
	content = [content stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
	content = [content stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
	
	NSString *htmls = [NSString stringWithFormat:@"<html> \n"
					   "<head> \n"
					   "<meta name=\"viewport\" content=\"initial-scale=1.0, maximum-scale=1.0, user-scalable=no\" /> \n"
					   "<style type=\"text/css\"> \n"
					   "body {font-size:15px;}\n"
					   "</style> \n"
					   "</head> \n"
					   "<body>"
					   "<script type='text/javascript'>"
					   "window.onload = function(){\n"
					   "var $img = document.getElementsByTagName('img');\n"
					   "for(var p in  $img){\n"
					   " $img[p].style.width = '100%%';\n"
					   "$img[p].style.height ='auto'\n"
					   "}\n"
					   "}"
					   "</script>%@"
					   "</body>"
					   "</html>",content];
	
	return htmls;
}

#pragma mark -
+ (NSString *)getNetImageURLStringWith:(NSString *)urlStr {
    if (![ToolUtil isEqualToNonNull:urlStr]) return nil;
    NSURL *url = nil;
    if ([urlStr hasPrefix:@"https://"] || [urlStr hasPrefix:@"http://"]) {
        url = [NSURL URLWithString:urlStr];
    }else {
        if ([urlStr hasPrefix:@"group"]) {/// java
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", IMAGE_JAVA_HOST ,urlStr]];
        }else if ([urlStr hasPrefix:@"Upload"]) {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", IMAGE_HOST ,urlStr]];
        }else {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", IMAGE_HOST ,urlStr]];
        }
    }
    return url.absoluteString;
}

#pragma mark -
+ (NSString *)numberSuitScanf:(NSString*)number {
	//首先验证是不是手机号码
	NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\\\d{8}$";
	NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
	BOOL isOk = [regextestmobile evaluateWithObject:number];
	if (isOk) {//如果是手机号码的话
		NSString *numberString = [number stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
		return numberString;
	}
	return number;
}


+ (void)showInController:(UIViewController *)parentController photoOfMax:(NSInteger)photoOfMax withType:(AMImageSelectedMeidaType)type uploadType:(NSInteger)uploadType completion:(void (^ __nullable)(NSArray *_Nullable images))completion {
	switch (type) {
		case AMImageSelectedMeidaTypeCamera: {
			ZZCameraController *controller = [[ZZCameraController alloc] init];
			controller.takePhotoOfMax = photoOfMax;
			controller.themeColor = [UIColor clearColor];
			controller.isSaveLocal = YES;
			[controller showIn:parentController result:^(id responseObject) {
				NSArray *resp = (NSArray *)responseObject;
				if (resp.count) {
					NSMutableArray *imageArray = [NSMutableArray new];
					[resp enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
						ZZCamera *camera = (ZZCamera *)obj;
						[imageArray insertObject:camera.image atIndex:imageArray.count];
					}];
					if (uploadType > 0) {
						[SVProgressHUD showWithStatus:@"图片上传中，请稍后..."];
						dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
							[self uploadImgs:[imageArray copy] uploadType:uploadType completion:completion];
						});
					}else {
						if (completion) completion([imageArray copy]);
					}
				}else {
					if (completion) completion(nil);
				}
			}];
			break;
		}
		case AMImageSelectedMeidaTypePhoto: {
			ZZPhotoController *controller = [[ZZPhotoController alloc] init];
			controller.selectPhotoOfMax = photoOfMax;
			[controller showIn:parentController result:^(id responseObject) {
				NSArray *resp = (NSArray *)responseObject;
				if (resp.count) {
					NSMutableArray *imageArray = [NSMutableArray new];
					[resp enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
						ZZPhoto *photo = (ZZPhoto *)obj;
						[imageArray insertObject:photo.originImage atIndex:imageArray.count];
					}];
					if (uploadType > 0) {
						[SVProgressHUD showWithStatus:@"图片上传中，请稍后..."];
						dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
							[self uploadImgs:[imageArray copy] uploadType:uploadType completion:completion];
						});
					}else {
						if (completion) completion([imageArray copy]);
					}
				}else {
					if (completion) completion(nil);
				}
			}];
			break;
		}
		default:
			break;
	}
}


+ (void)FK_showInController:(UIViewController *)parentController photoOfMax:(NSInteger)photoOfMax withType:(AMImageSelectedMeidaType)type uploadType:(NSInteger)uploadType completion:(void (^ __nullable)(NSArray *_Nullable images))completion {
    switch (type) {
        case AMImageSelectedMeidaTypeCamera: {
            ZZCameraController *controller = [[ZZCameraController alloc] init];
            controller.takePhotoOfMax = photoOfMax;
            controller.themeColor = [UIColor clearColor];
            controller.isSaveLocal = YES;
            [controller showIn:parentController result:^(id responseObject) {
                NSArray *resp = (NSArray *)responseObject;
                if (resp.count) {
                    NSMutableArray *imageArray = [NSMutableArray new];
                    [resp enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        ZZCamera *camera = (ZZCamera *)obj;
                        [imageArray insertObject:camera.image atIndex:imageArray.count];
                    }];
                    if (uploadType > 0) {
//                        [SVProgressHUD showWithStatus:@"图片上传中，请稍后..."];
//                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                            [self uploadImgs:[imageArray copy] uploadType:uploadType completion:completion];
//                        });
                        if (completion) completion([imageArray copy]);
                    }else {
                        if (completion) completion([imageArray copy]);
                    }
                }else {
                    if (completion) completion(nil);
                }
            }];
            break;
        }
        case AMImageSelectedMeidaTypePhoto: {
            ZZPhotoController *controller = [[ZZPhotoController alloc] init];
            controller.selectPhotoOfMax = photoOfMax;
            [controller showIn:parentController result:^(id responseObject) {
                NSArray *resp = (NSArray *)responseObject;
                if (resp.count) {
                    NSMutableArray *imageArray = [NSMutableArray new];
                    [resp enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        ZZPhoto *photo = (ZZPhoto *)obj;
                        [imageArray insertObject:photo.originImage atIndex:imageArray.count];
                    }];
                    if (uploadType > 0) {
//                        [SVProgressHUD showWithStatus:@"图片上传中，请稍后..."];
//                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                            [self uploadImgs:[imageArray copy] uploadType:uploadType completion:completion];
//                        });
                        if (completion) completion([imageArray copy]);
                    }else {
                        if (completion) completion([imageArray copy]);
                    }
                }else {
                    if (completion) completion(nil);
                }
            }];
            break;
        }
        default:
            break;
    }
}






+ (void)showInControllerWithoutUpload:(UIViewController *)parentController photoOfMax:(NSInteger)photoOfMax withType:(AMImageSelectedMeidaType)type completion:(void (^ __nullable)(NSArray *_Nullable images))completion {
    [self showInController:parentController photoOfMax:photoOfMax withType:type uploadType:0 completion:completion];
}


+ (void)uploadImgs:(NSArray *)imageArray uploadType:(NSInteger)uploadType completion:(void (^ __nullable)(NSArray *_Nullable imageURls))completion {
    [self uploadImgs:imageArray uploadType:uploadType completion:completion fail:nil];
}

+ (void)uploadImgs:(NSArray *)imageArray uploadType:(NSInteger)uploadType completion:(void (^ __nullable)(NSArray *_Nullable imageURls))completion fail:(void (^ _Nullable)(NSString * _Nonnull))fail {
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    params[@"num"] = @"2";
    params[@"type"] = [NSString stringWithFormat:@"%@",@(uploadType)];
    [ApiUtil imagePost:[ApiUtilHeader uploadImage] params:params images:imageArray success:^(id response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([response[@"code"] integerValue]) {
                if (fail) fail(response[@"message"]);
                else [SVProgressHUD showError:response[@"message"]];
            }else {
                NSArray *imageUrls = (NSArray *)response[@"data"];
                if (imageUrls && imageUrls.count) {
                    if (completion) completion(imageUrls);
                    else [SVProgressHUD showSuccess:response[@"message"]];
                }else {
                    if (fail) fail(@"数据丢失，请重试");
                    else [SVProgressHUD showError:@"数据丢失，请重试"];
                }
            }
        });
    } fail:^(NSError *error) {
        if (fail) fail(showNetworkError);
        else [SVProgressHUD showError:showNetworkError];
    }];
}

+ (void)JAVA_uploadImgs:(NSArray *)imageArray uploadType:(NSInteger)uploadType completion:(void (^ __nullable)(NSArray *_Nullable imageURls))completion {
    [self JAVA_uploadImgs:imageArray uploadType:uploadType completion:completion fail:nil];
}

+ (void)JAVA_uploadImgs:(NSArray *)imageArray uploadType:(NSInteger)uploadType completion:(void (^ __nullable)(NSArray *_Nullable imageURls))completion fail:(void (^ _Nullable)(NSString * _Nonnull))fail {
//    NSMutableDictionary *params = [NSMutableDictionary new];
    
//    params[@"file"] = imageArray;
    [ApiUtil JAVA_ImagePost:[ApiUtilHeader JAVA_UploadImage] params:nil images:imageArray success:^(id  _Nullable response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([response[@"code"] integerValue] != 200) {
                if (fail) fail(response[@"message"]);
                else [SVProgressHUD showError:response[@"message"]];
            }else {
                NSString *imageUrl = (NSString *)response[@"data"];
                if ([ToolUtil isEqualToNonNull:imageUrl]) {
                    if (completion) completion(@[imageUrl]);
                    else [SVProgressHUD showSuccess:response[@"message"]];
                }else {
                    if (fail) fail(@"数据丢失，请重试");
                    else [SVProgressHUD showError:@"数据丢失，请重试"];
                }
            }
        });
    } fail:^(NSError * _Nullable error) {
        if (fail) fail(showNetworkError);
        else [SVProgressHUD showError:showNetworkError];
    }];
}






+ (BOOL) isEqualOwner:(id)userID {
	if ([StringWithFormat(userID) isEqualToString:[UserInfoManager shareManager].uid]) {
		return YES;
	}
	return NO;
}

/*手机号码验证 MODIFIED BY HELENSONG*/
+ (BOOL) valifyMobile:(NSString *)mobile {
    if (![ToolUtil isEqualToNonNull:mobile])  {
        return NO;
    }
	NSString *phoneRegex=@"1[3456789]([0-9]){9}";
	NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
	BOOL isMobile = [phoneTest evaluateWithObject:[ToolUtil isEqualToNonNullKong:mobile]];
	return isMobile;
}

+ (BOOL)valifyInputPrice:(NSString *)price {
    if (price.length > 0)  {
        NSString *stringRegex = @"(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,8}(([.]\\d{0,2})?)))?";//一般格式 d{0,8} 控制位数
        NSPredicate *money = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];

        BOOL flag = [money evaluateWithObject:price];
        if (!flag) return NO;
    }
    return YES;
}

+ (BOOL)isValidPhone:(NSString *)phone {
	if (phone.length != 11) {
		return NO;
	}else {
		/**
		 * 移动号段正则表达式
		 */
		NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
		/**
		 * 联通号段正则表达式
		 */
		NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
		/**
		 * 电信号段正则表达式
		 */
		NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
		NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
		BOOL isMatch1 = [pred1 evaluateWithObject:phone];
		NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
		BOOL isMatch2 = [pred2 evaluateWithObject:phone];
		NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
		BOOL isMatch3 = [pred3 evaluateWithObject:phone];
		
		if (isMatch1 || isMatch2 || isMatch3) {
			return YES;
		}else{
			return NO;
		}
	}
}


#pragma mark -
+ (BOOL)isEqualToNonNull:(id)value {
	if (!value || [value isKindOfClass:[NSNull class]] || !StringWithFormat(value).length || [StringWithFormat(value) isEqualToString:@"(null)"] || [StringWithFormat(value) isEqualToString:@"<null>"]) {
		return NO;
	}
	return YES;
}

+ (NSString *)isEqualToNonNullKong:(id)value {
	return [ToolUtil isEqualToNonNull:value replace:@""];
}

+ (NSString *)isEqualToNonNullForZanWu:(id)value {
	return [ToolUtil isEqualToNonNull:value replace:@"无"];
}

+ (NSString *)isEqualToNonNull:(id)value replace:(id)replace {
	if ([ToolUtil isEqualToNonNull:value]) {
		return value;
	}
	return replace;
}

+ (BOOL)isPhoneX {
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {//判断是否是手机
          return NO;
      }
      if (@available(iOS 11.0, *)) {
          UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
          if (mainWindow.safeAreaInsets.bottom > 0.0) {
              return YES;
          }
      }
      return NO;
}

+ (NSString *)stringToDealMoneyString:(NSString *)string {
    if (string.length > 0) {
        NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
        [numFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber *num = [numFormatter numberFromString:string];
        NSString *tempStr = [numFormatter stringFromNumber:num];
        return tempStr;
    }else{
        return @"";
    }
}



@end
