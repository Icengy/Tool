//
//  AMTextField.h
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/12/5.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AMTextField : UITextField

//@property (nonatomic ,strong) UIFont *placeholderFont;
//@property (nonatomic ,strong) UIColor *placeholderColor;
/// 限制字数
@property (nonatomic, assign) NSInteger charCount;

@end



@interface AMSingleInputTextField : UITextField

@property (nonatomic ,copy) NSString *mainTitle;
@property (nonatomic ,strong) NSDictionary <NSAttributedStringKey,id> * titleTextAttributes;

@end

NS_ASSUME_NONNULL_END
