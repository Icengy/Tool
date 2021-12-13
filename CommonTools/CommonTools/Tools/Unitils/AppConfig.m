//
//  AppConfig.m
//  ESTicket
//
//  Created by phoenix on 14-10-10.
//  Copyright (c) 2014年 SEU. All rights reserved.
//

#import "AppConfig.h"
#import "UIDevice+Ext.h"

static AppConfig * instance = nil;

@implementation AppConfig

#pragma mark - instance method
+ (AppConfig*)getInstance
{
	@synchronized(self) {
		if (instance == nil)
        {
			instance = [[AppConfig alloc] init];
		}
	}
	return instance;
}

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        [self initConfig];
    }
    return self;
}

-(void)initConfig
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    // 应用id
    self.appId = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    
    // 应用appStore的id
    self.appStoreId = [NSString stringWithFormat:@"%d",ITUNES_APP_KEY];
    
    // 客户端名称
    self.clientName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    
    // 客户端版本号
    self.version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    // 客户端编译日期和次数
    self.buildVersion = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    // 数据库版本
    self.dataVersion = @"0.1";
    
    // 设备型号
    self.deviceModel = [UIDevice getCurrentDeviceName];
    
    // 设备类型编号
    self.clientType = [UIDevice getCurrentDeviceModel];

    // 渠道号
    self.fid = @"888888888";
}

+ (NSString *)generateLiveToken:(NSString *)url time:(NSString *)time{
    //每次重新生成6位随机数
    int num = arc4random() % 100000;
    NSString *key = [NSString stringWithFormat:@"%06d", num];
    //time
    NSString*timeLastSeven = [time substringFromIndex:time.length - 7];
    //A串
    NSString *A = [NSString stringWithFormat:@"%@%@%@%@",timeLastSeven,key,url,time];
    //B串
    NSString *B = [CommonUtils md5:A].uppercaseString;
    //C串
    NSString *tempStr = [B substringToIndex:15];
    NSString *C = [[B substringFromIndex:15] stringByAppendingString:tempStr];
    //liveToken
    return [NSString stringWithFormat:@"%@%@",C,key];
}

+ (NSInteger)getCurrentAppVersion {
	NSArray *verArray = [APP_CONFIG.version componentsSeparatedByString:@"."];
	if (verArray.count == 5) {
		NSInteger version = [verArray[0] integerValue]*10000+[verArray[1] integerValue]*1000+[verArray[2] integerValue]*100+[verArray[3] integerValue]*10+[verArray[4] integerValue]*1;
		return version;
	}
	
	if (verArray.count == 4) {
		NSInteger version = [verArray[0] integerValue]*10000+[verArray[1] integerValue]*1000+[verArray[2] integerValue]*100+[verArray[3] integerValue]*10;
		return version;
	}
	return 0;
}

@end
