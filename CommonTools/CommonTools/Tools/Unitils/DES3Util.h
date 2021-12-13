//
//  DES3Util.h
//  MiYao
//
//  Created by Homosum on 16/7/15.
//  Copyright © 2016年 JuXiuSheQu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DES3Util : NSObject
// 加密方法
+ (NSString*)getDES3Encrypt:(NSString*)plainText withKey:(NSString*)key;

// 解密方法
+ (NSString*)getDES3Decrypt:(NSString*)encryptText withKey:(NSString*)key;

// 加密方法
+ (NSString*)getDESEncrypt:(NSString*)plainText withKey:(NSString*)key;

// 解密方法
+ (NSString*)getDESDecrypt:(NSString*)encryptText withKey:(NSString*)key;


@end
