//
//  ESTextView.h
//  ESTicket
//
//  Created by 鹏 刘 on 15/11/23.
//  Copyright © 2015年 鹏 刘. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESTextView : UITextView
/**
 *  提示用户输入的标语
 */
@property (nonatomic, strong) NSString *placeholder;

/**
 *  标语文本的颜色
 */
@property (nonatomic, strong) UIColor *placeholderColor;

@end
