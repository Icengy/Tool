//
//  ESNetAPIClient.m
//  EduSoho
//
//  Created by Edusoho on 15/5/30.
//  Copyright (c) 2015年 Kuozhi Network Technology. All rights reserved.
//

#import "ESNetAPIClient.h"

@implementation ESNetAPIClient

static dispatch_once_t onceToken = 0;

+ (instancetype)sharedClient {
    static ESNetAPIClient *_sharedClient = nil;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sharedClient = [[ESNetAPIClient alloc] initWithBaseURL:[[NSURL URLWithString:[ESConfig sharedConfig].apiBaseURLString] URLByDeletingLastPathComponent] sessionConfiguration:config];
        _sharedClient.responseSerializer = [AFCompoundResponseSerializer serializer];
        _sharedClient.requestSerializer.timeoutInterval = 8;
    });
    
    return _sharedClient;
}

+ (instancetype)pushCloudClient {
    static ESNetAPIClient *_pushCloudClient = nil;
    static dispatch_once_t pushOnceToken;
    dispatch_once(&pushOnceToken, ^{
        _pushCloudClient = [[ESNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:ESPUSH_CLOUD_HOST]];
        _pushCloudClient.responseSerializer = [AFCompoundResponseSerializer serializer];
        _pushCloudClient.requestSerializer.timeoutInterval = 8;
    });
    return _pushCloudClient;
}

+ (void)resetSharedClient {
    onceToken = 0;
}

- (NSError *)handleResponse:(id)responseJSON {
    if ([responseJSON isKindOfClass:[NSError class]]) {
        NSError *error = (NSError *)responseJSON;
        return [NSError errorWithDomain:error.domain
                                   code:error.code
                               userInfo:@{@"code" : @(error.code),
                                          @"message" : [error localizedDescription]}];
    }
    if (![responseJSON isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    NSDictionary *errorInfo = [responseJSON valueForKeyPath:@"error"];
    if (errorInfo) {
        if ([errorInfo isKindOfClass:[NSDictionary class]]) {
            return [NSError errorWithDomain:NSCocoaErrorDomain
                                       code:errorInfo[@"code"] ? [errorInfo[@"code"] integerValue] : NSURLErrorUnknown
                                   userInfo:errorInfo];
        } else if ([errorInfo isKindOfClass:[NSString class]]) {
            return [NSError errorWithDomain:NSCocoaErrorDomain
                                       code:responseJSON[@"code"] ? [responseJSON[@"code"] integerValue] : NSURLErrorUnknown
                                   userInfo:@{@"code" : responseJSON[@"code"], @"message" : errorInfo}];
        }
    }
    // code非200时，表示有错
    NSNumber *resultCode = [responseJSON valueForKeyPath:@"code"];
    if (resultCode && [resultCode isKindOfClass:[NSNumber class]] && resultCode.intValue != 200 && resultCode.intValue != 0) {
        return [NSError errorWithDomain:NSCocoaErrorDomain
                                    code:resultCode.intValue
                                userInfo:responseJSON];
    }
    
    return nil;
}

- (void)pushCloudRequestDataWithPath:(NSString *)aPath
                           authToken:(NSString *)token
                              params:(NSDictionary *)params
                          methodType:(HttpMethod)method
                            callback:(void (^)(id, NSError *))block {
    if (!aPath || aPath.length <= 0) {
        return;
    }
    if (token) {
        [self.requestSerializer setValue:token forHTTPHeaderField:@"Auth-Token"];
    }
    [self requestWithPath:aPath params:params methodType:method callback:block];
}

- (void)newRequestJSONDataWithPath:(NSString *)aPath
                         userToken:(NSString *)token
                            params:(NSDictionary *)params
                        methodType:(HttpMethod)method
                          callback:(void (^)(id data, NSError *error))block {
    if (!aPath || aPath.length <= 0) {
        return;
    }
    aPath = [[@"api" stringByAppendingPathComponent:aPath] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (token) {
        [self.requestSerializer setValue:token forHTTPHeaderField:@"Auth-Token"];
    }
    [self requestWithPath:aPath params:params methodType:method callback:block];
}

- (void)requestJSONDataWithPath:(NSString *)aPath
                         params:(NSDictionary*)params
                     methodType:(HttpMethod)method
                       callback:(void (^)(id data, NSError *error))block {
    [self requestJSONDataWithPath:aPath userToken:nil params:params methodType:method callback:block];
}

- (void)requestJSONDataWithPath:(NSString *)aPath
                      userToken:(NSString *)token
                         params:(NSDictionary *)params
                     methodType:(HttpMethod)method
                       callback:(void (^)(id data, NSError *error))block {
    if (!aPath || aPath.length <= 0) {
        return;
    }
    aPath = [[[ESConfig sharedConfig].apiBaseURLString.lastPathComponent stringByAppendingPathComponent:aPath] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (token) {
        [self.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    }
    [self requestWithPath:aPath params:params methodType:method callback:block];
}

- (void)requestLiveJSONDataWithPath:(NSString *)aPath
                      userToken:(NSString *)token
                         params:(NSDictionary *)params
                     methodType:(HttpMethod)method
                       callback:(void (^)(id data, NSError *error))block {
    if (!aPath || aPath.length <= 0) {
        return;
    }
    if (token) {
        [self.requestSerializer setValue:token forHTTPHeaderField:@"auth-token"];
    }
    switch (method) {
        case GET: {
            [self GET:aPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                block(responseObject,nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                block(nil, error);
            }];
            break;
        }
        case POST: {
            [self POST:aPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                block(responseObject, nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                block(nil, error);
            }];
            break;
        }
        default:
            break;
    }
}

- (void)requestJSONDataWithPath:(NSString *)aPath
                           file:(NSDictionary *)file
                         params:(NSDictionary*)params
                     methodType:(HttpMethod)method
                       callback:(void (^)(id data, NSError *error))block {
    aPath = [[[ESConfig sharedConfig].apiBaseURLString.lastPathComponent stringByAppendingPathComponent:aPath] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    switch (method) {
        case POST: {
            [self POST:aPath parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                if (file) {
                    NSArray *images = file[@"image"];
                    for (int i = 1; i <= [images count]; i ++) {
                        NSData *imageData = UIImageJPEGRepresentation(images[i - 1], 1.0);
                        if ((float)imageData.length/1024 > 1000) {
                            imageData = UIImageJPEGRepresentation(images[i - 1], 1024*1000.0/(float)imageData.length);
                        }
                        [formData appendPartWithFileData:imageData name:[@(i) stringValue] fileName:[NSString stringWithFormat:@"%@.jpeg", @(i)] mimeType:@"image/jpeg"];
                    }
                }
            } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSError *error = nil;
                responseObject = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                 options:NSJSONReadingAllowFragments
                                                                   error:&error];
                DLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
//                error = [self handleResponse:responseObject];
                if (block) {
                    if (error) {
                        block(nil, error);
                    } else {
                        block(responseObject, nil);
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                if (block) {
                    block(nil, error);
                }
            }];
            break;
        }
        
        default:
            break;
    }
}

#pragma mark - Private

- (void)requestWithPath:(NSString *)aPath
                 params:(NSDictionary*)params
             methodType:(HttpMethod)method
               callback:(void (^)(id data, NSError *error))block {
    switch (method) {
        case GET: {
            [self GET:aPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSError *error = nil;
                responseObject = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                 options:NSJSONReadingAllowFragments
                                                                   error:&error];
//                DLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                error = [self handleResponse:responseObject];
                if (block) {
                    if (error) {
                        block(nil, error);
                    } else {
                        block(responseObject, nil);
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                error = [self handleResponse:error];
                if (block) {
                    block(nil, error);
                }
            }];
            break;
        }
        case POST: {
            [self POST:aPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSError *error = nil;
                responseObject = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                 options:NSJSONReadingAllowFragments
                                                                   error:&error];
                DLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                error = [self handleResponse:responseObject];
                if (block) {
                    if (error) {
                        block(nil, error);
                    } else {
                        block(responseObject, nil);
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                error = [self handleResponse:error];
                if (block) {
                    block(nil, error);
                }
            }];
            break;
        }
        case PUT: {
            [self PUT:aPath parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSError *error = nil;
                responseObject = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                 options:NSJSONReadingAllowFragments
                                                                   error:&error];
                DLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                error = [self handleResponse:responseObject];
                if (block) {
                    if (error) {
                        block(nil, error);
                    } else {
                        block(responseObject, nil);
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                error = [self handleResponse:error];
                if (block) {
                    block(nil, error);
                }
            }];
            break;
        }
        case DELETE: {
            [self DELETE:aPath parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSError *error = nil;
                responseObject = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                 options:NSJSONReadingAllowFragments
                                                                   error:&error];
                DLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                error = [self handleResponse:responseObject];
                if (block) {
                    if (error) {
                        block(nil, error);
                    } else {
                        block(responseObject, nil);
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                error = [self handleResponse:error];
                if (block) {
                    block(nil, error);
                }
            }];
            break;
        }
        default:
            break;
    }
}

@end
