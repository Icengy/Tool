//
//  NSString.h
//  ArtMedia
//
//  Created by 美术传媒 on 2019/7/15.
//  Copyright © 2019 lcy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (MD5)

+ (NSString *)md5String:(NSString *)str;
- (NSString *)md5;

@end

@interface NSString(Size)

- (CGSize)sizeWithFont:(UIFont*)font andMaxSize:(CGSize)size;
- (CGSize)sizeWithFont:(UIFont*)font andMaxSize:(CGSize)size numberOfLines:(NSInteger)numberOfLines;

@end

NS_ASSUME_NONNULL_END
