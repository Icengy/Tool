//
//  AppConfig.h
//  ESTicket
//
//  Created by phoenix on 14-10-10.
//  Copyright (c) 2014年 SEU. All rights reserved.
//

#import <Foundation/Foundation.h>

#define APP_CONFIG [AppConfig getInstance]

@interface AppConfig : NSObject

+ (AppConfig*)getInstance;
//生成socket liveToken
+ (NSString *)generateLiveToken:(NSString *)url time:(NSString *)timeString;
//获取当前版本号数字
+ (NSInteger)getCurrentAppVersion;
// 应用id
@property (nonatomic, strong) NSString* appId;
// 应用appStore的id
@property (nonatomic, strong) NSString* appStoreId;
// 客户端版本号
@property (nonatomic, strong) NSString* version;
// 客户端编译日期和次数
@property (nonatomic, strong) NSString* buildVersion;
// 客户端名称
@property (nonatomic, strong) NSString* clientName;
// 设备型号
@property (nonatomic, strong) NSString* deviceModel;
// 数据库版本
@property (nonatomic, strong) NSString* dataVersion;
// 渠道号
@property (nonatomic, strong) NSString* fid;
// 设备类型编号
@property (nonatomic, strong) NSString* clientType;
@end
