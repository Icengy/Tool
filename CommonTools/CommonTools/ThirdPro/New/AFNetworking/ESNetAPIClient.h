//
//  ESNetAPIClient.h
//  EduSoho
//
//  Created by Edusoho on 15/5/30.
//  Copyright (c) 2015年 Kuozhi Network Technology. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef NS_ENUM(NSUInteger, HttpMethod) {
    GET,
    POST,
    PUT,
    DELETE
};

@interface ESNetAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;
+ (instancetype)pushCloudClient;
+ (void)resetSharedClient;

- (void)pushCloudRequestDataWithPath:(NSString *)aPath
                           authToken:(NSString *)token
                              params:(NSDictionary *)params
                          methodType:(HttpMethod)method
                            callback:(void (^)(id data, NSError *error))block;

- (void)newRequestJSONDataWithPath:(NSString *)aPath
                         userToken:(NSString *)token
                            params:(NSDictionary *)params
                        methodType:(HttpMethod)method
                          callback:(void (^)(id data, NSError *error))block;

- (void)requestJSONDataWithPath:(NSString *)aPath
                         params:(NSDictionary *)params
                     methodType:(HttpMethod)method
                       callback:(void (^)(id data, NSError *error))block;

- (void)requestJSONDataWithPath:(NSString *)aPath
                      userToken:(NSString *)token
                         params:(NSDictionary *)params
                     methodType:(HttpMethod)method
                       callback:(void (^)(id data, NSError *error))block;

- (void)requestJSONDataWithPath:(NSString *)aPath
                           file:(NSDictionary *)file
                         params:(NSDictionary *)params
                     methodType:(HttpMethod)method
                       callback:(void (^)(id data, NSError *error))block;
- (void)requestLiveJSONDataWithPath:(NSString *)aPath
                          userToken:(NSString *)token
                             params:(NSDictionary *)params
                         methodType:(HttpMethod)method
                           callback:(void (^)(id data, NSError *error))block;

@end
