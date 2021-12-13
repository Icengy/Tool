//
//  ESTitleInputTableViewCell.h
//  ESTicket
//
//  Created by 鹏 刘 on 16/1/7.
//  Copyright © 2016年 鹏 刘. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ESTitleInputTableViewCell;
@protocol ESTitleInputTableViewCellDelegate <NSObject>

- (void)resetTitleInputTableViewCell:(ESTitleInputTableViewCell *)titleInputTableViewCell textFieldValueDidChange:(UITextField *)textField;

@end

@interface ESTitleInputTableViewCell : UITableViewCell

@property (nonatomic, weak) id <ESTitleInputTableViewCellDelegate> delegate;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, copy) void(^textFieldValueDidChange)(UITextField *textField);

@end
