//
//  URLHost.h
//  ArtMedia2
//
//  Created by icnengy on 2020/12/3.
//  Copyright © 2020 翁磊. All rights reserved.
//

#ifndef URLHost_h
#define URLHost_h

//#define OnlineEnvironment   1 /// 正式环境/测试环境
#define DebugEnvironment 1   /// 测试环境/联调环境

#if OnlineEnvironment

/// 正式环境
#define URL_HOST            @"https://api.mscmchina.com"
#define IMAGE_HOST          @"http://api.mscmchina.com"
#define URL_NEW_HOST        @"https://api.ysrmt.cn"

#define AMSharePrefix       @"https://admin.ysrmt.cn/wechat/#"

#define URL_JAVA_HOST       @"https://admin.ysrmt.cn"
#define IMAGE_JAVA_HOST     @"https://admin.ysrmt.cn/download"

#else /// 测试/debug 环境
    #if DebugEnvironment  //测试
        #define URL_HOST            @"https://apitest.mscmchina.com"
        #define IMAGE_HOST          @"http://apitest.mscmchina.com"
        #define URL_NEW_HOST        @"https://apitest.ysrmt.cn"

        #define AMSharePrefix       @"https://test.ysrmt.cn/wechat/#"

        #define URL_JAVA_HOST       @"https://test.ysrmt.cn"
        #define IMAGE_JAVA_HOST     @"https://test.ysrmt.cn/download"
    #else    //debug
        #define URL_HOST            @"https://apidebug.mscmchina.com"
        #define IMAGE_HOST          @"http://apidebug.mscmchina.com"
        #define URL_NEW_HOST        @"https://apidebug.ysrmt.cn"

        #define AMSharePrefix       @"https://debug.ysrmt.cn/wechat/#"

        #define URL_JAVA_HOST       @"https://debug.ysrmt.cn"
        #define IMAGE_JAVA_HOST     @"https://debug.ysrmt.cn/download"
    #endif
#endif

#endif /* URLHost_h */
