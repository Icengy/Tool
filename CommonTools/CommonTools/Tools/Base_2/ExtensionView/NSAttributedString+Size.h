//
//  NSMutableAttributedString+Size.h
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/12/2.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (Size)

- (CGSize)sizeWithFont:(UIFont*)font andMaxSize:(CGSize)size;

- (CGSize)getStringRectWithMaxSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
