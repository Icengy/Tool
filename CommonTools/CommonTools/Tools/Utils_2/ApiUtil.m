//
//  ApiUtil.m
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/8/19.
//  Copyright © 2019 lcy. All rights reserved.
//

#import "ApiUtil.h"

#import "MainTabBarController.h"
#import "LoginViewController.h"
#import "NSDictionary+deleteNull.h"


#define MscmToken  [UserInfoManager shareManager].token
//#define MscmToken  @"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJhZG1pbiIsImlhdCI6MTYwMTAyNTU1MywiZXhwIjoxNjAzNjE3NTUzLCJuYmYiOjE2MDEwMjU1NTMsInN1YiI6Ijg0MSIsImp0aSI6IjY3ZmY0YjJlZGE4MWYzMGZkMjAzMzdhOTM5MTE4MDgyIn0.axQctjwoI7GRKN15fsPZr9l-MHkAQwHIayEFe0XUf1c"
//#define MscmToken  @"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJhZG1pbiIsImlhdCI6MTYwMTAyNTYwMCwiZXhwIjoxNjAzNjE3NjAwLCJuYmYiOjE2MDEwMjU2MDAsInN1YiI6IjgzNyIsImp0aSI6IjczYWI5ZTAzMGJjYWM3YjI2ZmQwMDdhMDJkNDI2Y2NjIn0.qJXbSsN7zYtKroZlIBvULMjJsRnYPxzAHrga7fywgpo"



@implementation ApiUtil

static AFHTTPSessionManager *_manager;

+ (AFHTTPSessionManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        _manager = [AFHTTPSessionManager manager];
        
        AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:(AFSSLPinningModeNone)];
        policy.validatesDomainName = NO;
        policy.allowInvalidCertificates = YES;
        _manager.securityPolicy = policy;
        
//        _manager.requestSerializer = [AFHTTPRequestSerializer serializer]; _manager.responseSerializer = [AFHTTPResponseSerializer serializer];

        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        _manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        _manager.requestSerializer.timeoutInterval = 10.0f;
        [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        _manager.responseSerializer= [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
																				  @"application/octet-stream",
                                                                                  @"text/html",
                                                                                  @"text/json",
                                                                                  @"text/plain",
                                                                                  @"text/javascript",
                                                                                  @"text/xml",
																				  @"multipart/form-data",
                                                                                  @"image/png",
																				  @"image/jpg",
																				  @"image/jpeg"]];
    });
    return _manager;
}

#pragma mark - prvite
+ (void)dealError:(NSError * _Nonnull)error fail:(AMResponseFail _Nullable)fail {
    [SVProgressHUD dismiss];
    NSString *errorMsg = [ToolUtil isEqualToNonNull:error.localizedDescription replace:showNetworkError];
    

    #ifdef DEBUG
        SingleAMAlertView *alert = [SingleAMAlertView shareInstance];
        alert.title = errorMsg;
        [alert show];
    #else
        if (fail) { fail(error.code ,errorMsg);
        }else [SVProgressHUD showError:errorMsg];
    #endif
    
}

+ (void)dealMethod:(NSString *)netMethod
      urlString:(NSString *)urlString
     withParent:(id _Nullable)parent
       response:(id _Nonnull)responseObject
        success:(AMResponseSuccess _Nullable)success
           fail:(AMResponseFail _Nullable)fail {
    
    [SVProgressHUD dismiss];
    if (responseObject == nil) {
        NSInteger code = [[responseObject objectForKey:@"errcode"] integerValue];
        NSString *errorMsg = [ToolUtil isEqualToNonNull:[responseObject objectForKey:@"errmsg"] replace:showNetworkError];
        #ifdef DEBUG
            SingleAMAlertView *alert = [SingleAMAlertView shareInstance];
            alert.title = errorMsg;
            alert.confirmBlock = ^{
                if (fail) fail(code ,errorMsg);
            };
            [alert show];
        #else
            if (fail) fail(code ,errorMsg);
            else [SVProgressHUD showError:errorMsg];
        #endif
        
    }else {
        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
        if (code == 0 || code == 200) {
            NSMutableDictionary *response = [(NSDictionary *)responseObject mutableCopy];
            if (![ToolUtil isEqualToNonNull:[response objectForKey:@"data"]]) {
                response[@"data"] = @{};
            }
            if (success) success(code ,response);
        }else if (code == 401 || code/10 == 401) {/// 需重新登录
            if (parent && ([urlString hasPrefix:URL_HOST] ||
                           [urlString hasPrefix:URL_NEW_HOST] ||
                           [urlString hasPrefix:URL_JAVA_HOST])) {
                [[UserInfoManager shareManager] deleteUserData];
                if ([parent isKindOfClass:[MainTabBarController class]]) {
                    LoginViewController *loginVC = [[LoginViewController alloc] init];
                    loginVC.jumpClass = [parent class];
                    loginVC.viewControllers = [(BaseViewController *)parent navigationController].viewControllers;
                    MainNavigationController *navi = [[MainNavigationController alloc] initWithRootViewController:loginVC];
                    navi.modalPresentationStyle = UIModalPresentationFullScreen;
                    [parent presentViewController:navi animated:YES completion:nil];

                }else if ([parent isKindOfClass:[MainNavigationController class]]) {
                    
                }else if ([parent isKindOfClass:[BaseViewController class]]) {
                    [(BaseViewController *)parent jumpToLoginWithBlock:nil];
                }
            }
        }else {
            NSString *errorMsg = showNetworkError;
            
            if ([urlString hasPrefix:URL_HOST] ||
                [urlString hasPrefix:URL_NEW_HOST] ||
                [urlString hasPrefix:URL_JAVA_HOST]) {
                if ([responseObject objectForKey:@"msg"]) {
                    errorMsg = [responseObject objectForKey:@"msg"];
                }
                if ([responseObject objectForKey:@"message"]) {
                    errorMsg = [responseObject objectForKey:@"message"];
                }
            }
            #ifdef DEBUG
                SingleAMAlertView *alert = [SingleAMAlertView shareInstance];
                alert.title = errorMsg;
                alert.confirmBlock = ^{
                    if (fail) fail(code ,errorMsg);
                };
                [alert show];
            #else
                if (fail) fail(code ,errorMsg);
                else [SVProgressHUD showError:errorMsg];
            #endif
            
        }
    }
}

/// 新版网络请求部分
#pragma mark - Get
+ (void)getWithParent:(id _Nullable)parent
                  url:(NSString *_Nullable)urlString
              needHUD:(BOOL)needHUD
               params:(NSDictionary *_Nullable)params
              success:(AMResponseSuccess _Nullable)success
                 fail:(AMResponseFail _Nullable)fail {
    
    if (needHUD) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD show];
        });
    }
    if ([urlString hasPrefix:@"https://"] || [urlString hasPrefix:@"http://"]) {
    }else
        urlString = [URL_HOST stringByAppendingString:urlString];
    
    if(!params) params = @{};
    NSMutableDictionary *headers = @{}.mutableCopy;
    headers[@"mscmToken"] = MscmToken;
    
    [[self sharedInstance] GET:urlString
                    parameters:params
                       headers:headers
                      progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        NSLog(@"responseObject = %@ -- url =%@-- params = %@-- headers = %@",responseObject,urlString,params,headers);
        [self dealMethod:@"GET" urlString:urlString withParent:parent response:responseObject success:success fail:fail];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error = %@ -- %@",error, urlString);
        [self dealError:error fail:fail];
    }];
}

+ (void)getWithParent:(id _Nullable)parent
                  url:(NSString *_Nullable)urlString
               params:(NSDictionary *_Nullable)params
              success:(AMResponseSuccess _Nullable)success
                 fail:(AMResponseFail _Nullable)fail {
    [self getWithParent:parent url:urlString needHUD:YES params:params success:success fail:fail];
}

#pragma mark - Post
+ (void)postWithParent:(id _Nullable)parent
                   url:(NSString *_Nullable)urlString
               needHUD:(BOOL)needHUD
                params:(NSDictionary *_Nullable)params
               success:(AMResponseSuccess _Nullable)success
                  fail:(AMResponseFail _Nullable)fail {
    
    if (needHUD) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD show];
        });
    }
    if ([urlString hasPrefix:@"https://"] || [urlString hasPrefix:@"http://"]) {
    }else
        urlString = [URL_HOST stringByAppendingString:urlString];
    
    if(!params) params = @{};
    NSMutableDictionary *headers = @{}.mutableCopy;
    headers[@"mscmToken"] = MscmToken;
    
    [[self sharedInstance] POST:urlString
                     parameters:params
                        headers:headers.copy
                       progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        
        NSLog(@"responseObject = %@ -- url =%@-- params = %@-- headers = %@",responseObject,urlString,params,headers);
        [self dealMethod:@"POST" urlString:urlString withParent:parent response:responseObject success:success fail:fail];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error = %@ -- %@",error, urlString);
        [self dealError:error fail:fail];
    }];
}
     
+ (void)postWithParent:(id _Nullable)parent
                   url:(NSString *_Nullable)urlString
                params:(NSDictionary *_Nullable)params
               success:(AMResponseSuccess _Nullable)success
                  fail:(AMResponseFail _Nullable)fail {
    [self postWithParent:parent url:urlString needHUD:YES params:params success:success fail:fail];
}

#pragma mark - Put
+ (void)putWithParent:(id _Nullable)parent
                  url:(NSString *_Nullable)urlString
              needHUD:(BOOL)needHUD
               params:(NSDictionary *_Nullable)params
              success:(AMResponseSuccess _Nullable)success
                 fail:(AMResponseFail _Nullable)fail {
    
    if (needHUD) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD show];
        });
    }
    if ([urlString hasPrefix:@"https://"] || [urlString hasPrefix:@"http://"]) {
    }else
        urlString = [URL_HOST stringByAppendingString:urlString];
    
    if(!params) params = @{};
    NSMutableDictionary *headers = @{}.mutableCopy;
    headers[@"mscmToken"] = MscmToken;
   
    [[self sharedInstance] PUT:urlString parameters:params headers:headers success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject = %@ -- url =%@-- params = %@-- headers = %@",responseObject,urlString,params,headers);
        [self dealMethod:@"PUT" urlString:urlString withParent:parent response:responseObject success:success fail:fail];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error = %@ -- %@",error, urlString);
        [self dealError:error fail:fail];
    }];
}

+ (void)putWithParent:(id _Nullable)parent
                  url:(NSString *_Nullable)urlString
               params:(NSDictionary *_Nullable)params
              success:(AMResponseSuccess _Nullable)success
                 fail:(AMResponseFail _Nullable)fail {
    [self putWithParent:parent url:urlString needHUD:YES params:params success:success fail:fail];
}

#pragma mark - Delete
+ (void)deleteWithParent:(id _Nullable)parent
                     url:(NSString *_Nullable)urlString
                 needHUD:(BOOL)needHUD
                  params:(NSDictionary *_Nullable)params
                 success:(AMResponseSuccess _Nullable)success
                    fail:(AMResponseFail _Nullable)fail {
    
    if (needHUD) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD show];
        });
    }
    if ([urlString hasPrefix:@"https://"] || [urlString hasPrefix:@"http://"]) {
    }else
        urlString = [URL_HOST stringByAppendingString:urlString];
    
    if(!params) params = @{};
    NSMutableDictionary *headers = @{}.mutableCopy;
    headers[@"mscmToken"] = MscmToken;
    
    [[self sharedInstance] DELETE:urlString
                       parameters:params
                          headers:headers
                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject = %@ -- url =%@-- params = %@-- headers = %@",responseObject,urlString,params,headers);
        [self dealMethod:@"DELETE" urlString:urlString withParent:parent response:responseObject success:success fail:fail];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        NSLog(@"error = %@ -- %@",error, urlString);
        [self dealError:error fail:fail];
    }];
}

+ (void)deleteWithParent:(id _Nullable)parent
                     url:(NSString *_Nullable)urlString
                  params:(NSDictionary *_Nullable)params
                 success:(AMResponseSuccess _Nullable)success
                    fail:(AMResponseFail _Nullable)fail {
    [self deleteWithParent:parent url:urlString needHUD:YES params:params success:success fail:fail];
}

#pragma mark - 图片上传表单格式
///图片上传表单格式
+ (void) imagePost:(NSString *)urlString params:(NSDictionary *_Nullable)params images:(NSArray <UIImage *>* _Nullable)images success:(CMResponseSuccess _Nullable)cmSuccess fail:(CMResponseFail _Nullable)cmFail {
    if ([urlString hasPrefix:@"https://"] || [urlString hasPrefix:@"http://"]) {
    }else
        urlString = [URL_HOST stringByAppendingString:urlString];
	if(!params)
	{
		params=[NSDictionary dictionary];
	}
	[self sharedInstance].requestSerializer.timeoutInterval = 180;
	[[self sharedInstance] POST:urlString parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
		for (int i = 0; i < images.count; i++) {
			UIImage *image = images[i];
			NSData *imageData = [ImagesTool compressOriginalImage:image toMaxDataSizeKBytes:10.0f*1024];
			// 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
			// 要解决此问题，
			// 可以在上传时使用当前的系统事件作为文件名
			NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
			// 设置时间格式
			[formatter setDateFormat:@"yyyyMMddHHmmss"];
			NSString *dateString = [formatter stringFromDate:[NSDate date]];
			NSString *fileName = [NSString  stringWithFormat:@"%@_%@.png", dateString, @(i)];
//			NSLog(@"%@.png",fileName);
			/*
			 *该方法的参数
			 1. appendPartWithFileData：要上传的照片[二进制流]
			 2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
			 3. fileName：要保存在服务器上的文件名
			 4. mimeType：上传的文件的类型
			 */
			[formData appendPartWithFileData:imageData name:@"file[]" fileName:fileName mimeType:@"image/png"];
		}
	} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
		if (cmSuccess) cmSuccess(responseObject);
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
		if (cmFail) cmFail(error);
	}];
}
+ (void)JAVA_ImagePost:(NSString *)urlString params:(NSDictionary *_Nullable)params images:(NSArray <UIImage *>* _Nullable)images success:(CMResponseSuccess _Nullable)cmSuccess fail:(CMResponseFail _Nullable)cmFail {
    if ([urlString hasPrefix:@"https://"] || [urlString hasPrefix:@"http://"]) {
        
    }else
        urlString = [URL_HOST stringByAppendingString:urlString];
    if(!params)
    {
        params=[NSDictionary dictionary];
    }
//    [[self sharedInstance].requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    [self sharedInstance].requestSerializer.timeoutInterval = 180;
    
    NSMutableDictionary *headers = @{}.mutableCopy;
    headers[@"mscmToken"] = MscmToken;
    
    [[self sharedInstance] POST:urlString parameters:params headers:headers.copy constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < images.count; i++) {
            UIImage *image = images[i];
            NSData *imageData = [ImagesTool compressOriginalImage:image toMaxDataSizeKBytes:10.0f*1024];
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@_%@.png", dateString, @(i)];
//            NSLog(@"%@.png",fileName);
            /*
             *该方法的参数
             1. appendPartWithFileData：要上传的照片[二进制流]
             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
             3. fileName：要保存在服务器上的文件名
             4. mimeType：上传的文件的类型
             */
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        if (cmSuccess) cmSuccess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        if (cmFail) cmFail(error);
    }];
}

#pragma mark - OLD
+ (void)post:(NSString*)method needHUD:(BOOL)needHUD needTips:(BOOL)needTips params:(NSDictionary* _Nullable)params success:(CMResponseSuccess _Nullable)cmSuccess fail:(CMResponseFail _Nullable)cmFail {
    if (needHUD) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD show];
        });
    }
    if ([method hasPrefix:@"https://"] || [method hasPrefix:@"http://"]) {
    }else
        method = [URL_HOST stringByAppendingString:method];
    
    if(!params) params=[NSDictionary dictionary];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:method parameters:nil error:nil];
    //设置超时时长
    request.timeoutInterval = 30.0f;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    //将对象设置到requestbody中 ,主要是这不操作
    [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[[self sharedInstance] dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [SVProgressHUD dismiss];
        NSLog(@"responseObject = %@ -- url = %@-- params = %@",responseObject,method,params);
        if (error) {
            if (cmFail) {// 当cmFail != nil时，表示不需要弹出错误HUD
                cmFail(error);
            }else {
                [SVProgressHUD showError:showNetworkError];
            }
        }else {
            if (cmSuccess) {
                if (needTips && [method hasPrefix:URL_HOST] && [responseObject[@"code"] integerValue]) {
                    [SVProgressHUD showError:responseObject[@"message"]];
                    // 当code != 0时，说明获取服务器为空, 此时调用cmFail(),
                    // 为和cmFail(error)区别，此时cmFail传递空，即cmFail();
                    if (cmFail) cmFail(nil);
                }else
                    cmSuccess(responseObject);
            }
        }
    }] resume];
}

+ (void)post:(NSString*)method params:(NSDictionary* _Nullable)params success:(CMResponseSuccess _Nullable)cmSuccess fail:(CMResponseFail _Nullable)cmFail {
    [self post:method needHUD:YES needTips:YES params:params success:cmSuccess fail:cmFail];
}

+ (void)post:(NSString*)method needHUD:(BOOL)needHUD params:(NSDictionary* _Nullable)params success:(CMResponseSuccess _Nullable)cmSuccess fail:(CMResponseFail _Nullable)cmFail {
    [self post:method needHUD:needHUD needTips:YES params:params success:cmSuccess fail:cmFail];
}

+ (void)get:(NSString*)method needHUD:(BOOL)needHUD params:(NSDictionary* _Nullable)params success:(CMResponseSuccess _Nullable)cmSuccess fail:(CMResponseFail _Nullable)cmFail {
    if (needHUD) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD show];
        });
    }
    if ([method hasPrefix:@"https://"] || [method hasPrefix:@"http://"]) {
        
    }else
        method = [URL_HOST stringByAppendingString:method];
    
    if(!params) {
        params=[NSDictionary dictionary];
    }
    [[self sharedInstance] GET:method parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject = %@ -- url =%@-- params = %@",responseObject,method,params);
        [SVProgressHUD dismiss];
        if (cmSuccess) cmSuccess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@ -- %@",error, method);
        [SVProgressHUD dismiss];
        if (cmFail) cmFail(error);
    }];
}

+ (void)get:(NSString*)method params:(NSDictionary* _Nullable)params success:(CMResponseSuccess _Nullable)cmSuccess fail:(CMResponseFail _Nullable)cmFail {
    [self get:method needHUD:NO params:params success:cmSuccess fail:cmFail];
}

@end
