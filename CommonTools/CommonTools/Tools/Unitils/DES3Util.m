//
//  DES3Util.m
//  MiYao
//
//  Created by Homosum on 16/7/15.
//  Copyright © 2016年 JuXiuSheQu. All rights reserved.
//

#import "DES3Util.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonCrypto.h>
@implementation DES3Util
//需要协商密匙和向量
#define gkey            @"ESJPWIgQQDgoJXlRy91VZncpdJgwQEDi"
#define gIv             @""


+(NSString*)getDESEncrypt:(NSString *)plainText withKey:(NSString *)key
{
    
    NSString *ciphertext = nil;
    NSData *textData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    Byte iv[] = {1,2,3,4,5,6,7,8};
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,kCCOptionPKCS7Padding|kCCOptionECBMode,[key UTF8String], kCCKeySizeDES,iv,[textData bytes], dataLength,buffer, 1024,&numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [[NSString alloc] initWithData:[GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
    }
    return ciphertext;

//    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
//    char keyPtr[kCCKeySizeAES256+1];
//    bzero(keyPtr, sizeof(keyPtr));
//
//    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
//
//    NSUInteger dataLength = [data length];
//
//    size_t bufferSize = dataLength + kCCBlockSizeAES128;
//    void *buffer = malloc(bufferSize);
//
//    size_t numBytesEncrypted = 0;
//    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
//                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
//                                          keyPtr, kCCBlockSizeDES,
//                                          NULL,
//                                          [data bytes], dataLength,
//                                          buffer, bufferSize,
//                                          &numBytesEncrypted);
//    if (cryptStatus == kCCSuccess) {
//        return [GTMBase64 stringByEncodingData:[NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted]];
//    }
//
//    free(buffer);
//    return nil;
}

+(NSString*)getDESDecrypt:(NSString *)encryptText withKey:(NSString *)key
{
    NSString *plaintext = nil;
    NSData *cipherdata = [GTMBase64 decodeString:encryptText];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    Byte iv[] = {1,2,3,4,5,6,7,8};
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,kCCOptionPKCS7Padding|kCCOptionECBMode,[key UTF8String], kCCKeySizeDES,iv,[cipherdata bytes], [cipherdata length],buffer, 1024,&numBytesDecrypted);
    if(cryptStatus == kCCSuccess) {NSData *plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];}
    return plaintext;
//    NSData* data = [encryptText dataUsingEncoding:NSUTF8StringEncoding];
//    char keyPtr[kCCKeySizeAES256+1];
//    bzero(keyPtr, sizeof(keyPtr));
//
//    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
//
//    NSUInteger dataLength = [data length];
//
//    size_t bufferSize = dataLength + kCCBlockSizeAES128;
//    void *buffer = malloc(bufferSize);
//
//    size_t numBytesDecrypted = 0;
//    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
//                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
//                                          keyPtr, kCCBlockSizeDES,
//                                          NULL,
//                                          [data bytes], dataLength,
//                                          buffer, bufferSize,
//                                          &numBytesDecrypted);
//
//    if (cryptStatus == kCCSuccess) {
//        NSString *result = [GTMBase64 stringByEncodingData:[NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted]];
//        return result;
//    }
//
//    free(buffer);
//    return nil;
}

// 加密方法
+ (NSString*)getDES3Encrypt:(NSString*)plainText withKey:(NSString *)key{
//  转bytes
//  NSString*key=gkey;
    NSData*keyData=[key dataUsingEncoding:NSUTF8StringEncoding];
    const void*vkeyData=(const void*)[keyData bytes];
    //解密
    NSData*vwkeyData=[GTMBase64 decodeBytes:vkeyData length:[keyData length]];
    //转bytes
    const void*vkey=(const void*)[vwkeyData bytes];

    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainTextBufferSize = [data length];
    const void *vplainText = (const void *)[data bytes];

    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    const void *vinitVec = nil;
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionECBMode|kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    NSString *result = [GTMBase64 stringByEncodingData:myData];
    return result;
}

// 解密方法
+ (NSString*)getDES3Decrypt:(NSString*)encryptText withKey:(NSString *)key{
//    NSString*key=gkey;
    NSData*keyData=[key dataUsingEncoding:NSUTF8StringEncoding];
    const void*vkeyData=(const void*)[keyData bytes];
    //解密
    NSData*vwkeyData=[GTMBase64 decodeBytes:vkeyData length:[keyData length]];
    //转bytes
    const void*vkey=(const void*)[vwkeyData bytes];

    NSData *encryptData = [GTMBase64 decodeData:[encryptText dataUsingEncoding:NSUTF8StringEncoding]];
    size_t plainTextBufferSize = [encryptData length];
    const void *vplainText = [encryptData bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    const void *vinitVec=nil;
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                      kCCOptionPKCS7Padding|kCCOptionECBMode,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result = [[[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                      length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding] autorelease];

    return result;
}


@end
