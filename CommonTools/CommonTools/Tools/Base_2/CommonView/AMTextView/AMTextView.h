//
//  AMTextView.h
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/12/5.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextView+AMPlaceholder.h"

NS_ASSUME_NONNULL_BEGIN
@class AMTextView;
@protocol AMTextViewDelegate <NSObject>

@optional
- (BOOL)amTextViewShouldEndEditing:(AMTextView *)textView;
- (BOOL)amTextViewShouldBeginEditing:(AMTextView *)textView;
- (void)amTextViewDidChange:(AMTextView *)textView;

@end

@interface AMTextView : UITextView

@property (nonatomic ,weak) id<AMTextViewDelegate> ownerDelegate;

@property(nonatomic,strong)void(^textViewChangedBlock)(NSString *text);
/**
 限制字数
 */
@property (nonatomic, assign) NSInteger charCount;

@end

NS_ASSUME_NONNULL_END
