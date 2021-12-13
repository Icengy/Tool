//
//  ESAdjustTextView.h
//  Gallop_iOS
//
//  Created by lixuanye on 2020/6/11.
//  Copyright © 2020 homosum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESAdjustTextView : UIView
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,copy) NSString *placeholder;
@property (nonatomic,strong) UIFont *font;

- (void)resize;
@end
