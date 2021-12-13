//
//  ApiUtil.h
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/8/19.
//  Copyright © 2019 lcy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>
#import "ApiUtilHeader.h"

#define NetCodeDetermine(code) (code == 0 || code == 200)

typedef void( ^ CMResponseSuccess)(id _Nullable response);
typedef void( ^ CMResponseFail)(NSError * _Nullable error);

typedef void( ^ AMResponseSuccess)(NSInteger code, id _Nullable response);
typedef void( ^ AMResponseFail)(NSInteger errorCode ,NSString * _Nullable errorMsg);

NS_ASSUME_NONNULL_BEGIN

@interface ApiUtil : NSObject

+ (AFHTTPSessionManager *)sharedInstance;

/// 需要开始HUD，结束HUD根据code值自行判断
/// @param method 请求链接
/// @param params 参数
/// @param cmSuccess 请求成功的回调(只返回code=0时的数据)
/// @param cmFail 当cmFail=nil时，不做任何操作。cmFail(error)基本为网络情况导致的出错，HUD提示固定语句，cmFail(nil)为请求成功请求数据，但code!=0，HUD提示服务器返回的错误语句
//+(void)post:(NSString*)method params:(NSDictionary* _Nullable)params success:(CMResponseSuccess _Nullable)cmSuccess fail:(CMResponseFail _Nullable)cmFail;


/// 只需自定义开始HUD，结束HUD根据code值自行判断
/// @param method 请求链接
/// @param needHUD 是否需要开始HUD
/// @param params 参数
/// @param cmSuccess 请求成功的回调(只返回code=0时的数据)
/// @param cmFail 当cmFail=nil时，不做任何操作。cmFail(error)基本为网络情况导致的出错，HUD提示固定语句，cmFail(nil)为请求成功请求数据，但code!=0，HUD提示服务器返回的错误语句
//+ (void)post:(NSString*)method needHUD:(BOOL)needHUD params:(NSDictionary* _Nullable)params success:(CMResponseSuccess _Nullable)cmSuccess fail:(CMResponseFail _Nullable)cmFail;

/// 基础模式 需自定义开始HUD，自定义结束HUD
/// @param method 请求链接
/// @param needHUD 是否需要开始HUD
/// @param needTips 是否需要结束HUD(正常请求返回值code!=0时)
/// @param params 参数
/// @param cmSuccess 请求成功的回调
/// @param cmFail 当cmFail=nil时，不做任何操作。cmFail(error)基本为网络情况导致的出错，HUD提示固定语句，cmFail(nil)为请求成功请求数据，但code!=0，HUD提示服务器返回的错误语句
//+ (void)post:(NSString*)method needHUD:(BOOL)needHUD needTips:(BOOL)needTips params:(NSDictionary* _Nullable)params success:(CMResponseSuccess _Nullable)cmSuccess fail:(CMResponseFail _Nullable)cmFail;


+ (void)get:(NSString*)method needHUD:(BOOL)needHUD params:(NSDictionary* _Nullable)params success:(CMResponseSuccess _Nullable)cmSuccess fail:(CMResponseFail _Nullable)cmFail;
+ (void)get:(NSString*)method params:(NSDictionary* _Nullable)params success:(CMResponseSuccess _Nullable)cmSuccess fail:(CMResponseFail _Nullable)cmFail;


#pragma mark -
/// get请求
/// @param parent 请求发起时所在的控制器
/// @param urlString urlString
/// @param needHUD 是否需要HUD YES为需要
/// @param params params
/// @param success success
/// @param fail fail
+ (void)getWithParent:(id _Nullable)parent
                  url:(NSString *_Nullable)urlString
              needHUD:(BOOL)needHUD
               params:(NSDictionary *_Nullable)params
              success:(AMResponseSuccess _Nullable)success
                 fail:(AMResponseFail _Nullable)fail;
/// get请求 needHUD = YES
+ (void)getWithParent:(id _Nullable)parent
                  url:(NSString *_Nullable)urlString
               params:(NSDictionary *_Nullable)params
              success:(AMResponseSuccess _Nullable)success
                 fail:(AMResponseFail _Nullable)fail;

/// post请求
/// @param parent 请求发起时所在的控制器
/// @param urlString urlString
/// @param needHUD 是否需要HUD YES为需要
/// @param params params
/// @param success success
/// @param fail fail
+ (void)postWithParent:(id _Nullable)parent
                   url:(NSString *_Nullable)urlString
               needHUD:(BOOL)needHUD
                params:(NSDictionary * _Nullable)params
               success:(AMResponseSuccess _Nullable)success
                  fail:(AMResponseFail _Nullable)fail;
/// post请求 needHUD = YES
+ (void)postWithParent:(id _Nullable)parent
                   url:(NSString *_Nullable)urlString
                params:(NSDictionary *_Nullable)params
               success:(AMResponseSuccess _Nullable)success
                  fail:(AMResponseFail _Nullable)fail;

/// put请求
/// @param parent 请求发起时所在的控制器
/// @param urlString urlString
/// @param needHUD 是否需要HUD YES为需要
/// @param params params
/// @param success success
/// @param fail fail
+ (void)putWithParent:(id _Nullable)parent
                  url:(NSString *_Nullable)urlString
              needHUD:(BOOL)needHUD
               params:(NSDictionary *_Nullable)params
              success:(AMResponseSuccess _Nullable)success
                 fail:(AMResponseFail _Nullable)fail;
/// put请求 needHUD = YES
+ (void)putWithParent:(id _Nullable)parent
                  url:(NSString *_Nullable)urlString
               params:(NSDictionary *_Nullable)params
              success:(AMResponseSuccess _Nullable)success
                 fail:(AMResponseFail _Nullable)fail;

/// delete请求
/// @param parent 请求发起时所在的控制器
/// @param urlString urlString
/// @param needHUD 是否需要HUD YES为需要
/// @param params params
/// @param success success
/// @param fail fail
+ (void)deleteWithParent:(id _Nullable)parent
                     url:(NSString * _Nullable)urlString
                 needHUD:(BOOL)needHUD
                  params:(NSDictionary *_Nullable)params
                 success:(AMResponseSuccess _Nullable)success
                    fail:(AMResponseFail _Nullable)fail;
/// delete请求 needHUD = YES
+ (void)deleteWithParent:(id _Nullable)parent
                     url:(NSString *_Nullable)urlString
                  params:(NSDictionary *_Nullable)params
                 success:(AMResponseSuccess _Nullable)success
                    fail:(AMResponseFail _Nullable)fail;

#pragma mark -
+ (void) imagePost:(NSString *)urlString params:(NSDictionary *_Nullable)params images:(NSArray <UIImage *>* _Nullable)images success:(CMResponseSuccess _Nullable)cmSuccess fail:(CMResponseFail _Nullable)cmFail;

+ (void)JAVA_ImagePost:(NSString *)urlString params:(NSDictionary *_Nullable)params images:(NSArray <UIImage *>* _Nullable)images success:(CMResponseSuccess _Nullable)cmSuccess fail:(CMResponseFail _Nullable)cmFail;
@end

NS_ASSUME_NONNULL_END
