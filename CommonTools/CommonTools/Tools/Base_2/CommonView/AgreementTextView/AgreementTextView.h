//
//  AgreementTextView.h
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/11/18.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickToLinkBlock)(NSString *_Nullable linkKey);

NS_ASSUME_NONNULL_BEGIN

@interface AgreementTextView : UITextView

- (void)setAllText:(NSString *)allStr
		   allFont:(UIFont *_Nullable)allFont
	  allTextColor:(UIColor *_Nullable)allTextColor
		  linkText:(NSString *_Nullable)linkText
		linkKey:(NSString *_Nullable)linkKey
		  linkFont:(UIFont *_Nullable)linkFont
	 linkTextColor:(UIColor *_Nullable)linkTextColor
			 block:(clickToLinkBlock)clickBlock;

@end

NS_ASSUME_NONNULL_END
