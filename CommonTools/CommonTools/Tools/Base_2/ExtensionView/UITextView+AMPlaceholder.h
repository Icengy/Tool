//
//  UITextView+AMPlaceholder.h
//  UITextViewPlaceDemo
//
//  Created by JianJian-Mac on 17/3/17.
//  Copyright © 2017年 Mecare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (AMPlaceholder)

@property(nonatomic,readonly)  UILabel * _Nullable placeholdLabel;
@property(nonatomic,strong) IBInspectable NSString * _Nullable placeholder;
@property(nonatomic,strong) IBInspectable UIColor * _Nullable placeholderColor;
@property(nonatomic,strong) IBInspectable UIFont * _Nullable placeholderFont;
@property(nonnull,strong) NSAttributedString *attributePlaceholder;
@property(nonatomic,assign) CGPoint location;

+ (UIColor *_Nullable)defaultColor;

@end
