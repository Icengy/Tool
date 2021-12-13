//
//  AMAlertView.h
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/10/29.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void( ^ AMAlertComfirm)(void);
typedef void( ^ AMAlertCancel)(void);

typedef NS_ENUM(NSUInteger, AMAlertType) {
	///普通类型
	AMAlertTypeNormal = 0,
	///有副标题
	AMAlertTypeMessage, //NonDissmiss（点击确认不会消失）
	///强制展示
	AMAlertTypeNonDissmiss,//NonDissmiss（点击确认不会消失）
};

@interface AMAlertView : UIView

/**
 普通模式
 */
+ (AMAlertView *_Nullable)shareInstanceWithTitle:(NSString * __nonnull)titleString
							buttonArray:(NSArray * __nonnull)buttonTitleArray
										 confirm:(AMAlertComfirm _Nullable)confirm
										  cancel:(AMAlertCancel _Nullable )cancel;
/**
 全属性自选模式
 */
+ (AMAlertView *_Nonnull)shareInstanceWithTitle:(NSString * __nonnull)titleString
								message:(NSString *_Nullable)message
							buttonArray:(NSArray * __nonnull)buttonTitleArray
							  alertType:(AMAlertType)alertType
										confirm:(AMAlertComfirm _Nullable )confirm
										 cancel:(AMAlertCancel _Nullable )cancel;

- (void)show;

@end


@interface SingleAMAlertView : UIView

@property (nonatomic, copy) NSString * _Nullable title;
@property (nonatomic, strong) UIFont * _Nullable titleFont;
@property (nonatomic, copy) NSString * _Nullable subTitle;
@property (nonatomic, strong) UIFont * _Nullable subTitleFont;
@property (nonatomic, copy) NSAttributedString * _Nullable subAttributedTitle;
@property (nonatomic ,assign) BOOL canTouchBlank;
@property (nonatomic ,assign) BOOL needCancelShow;

@property (nonatomic ,copy) AMAlertComfirm _Nullable confirmBlock;
@property (nonatomic ,copy) AMAlertCancel _Nullable cancelBlock;

+ (instancetype _Nullable)shareInstance;

- (void)show;
- (void)hide;

@end

@interface AMMeetingSettingAlertView : UIView

@property (nonatomic, copy) NSString * _Nullable title;
@property (nonatomic, copy) NSString * _Nullable subTitle;
@property (nonatomic ,assign) BOOL canTouchBlank;

@property (nonatomic ,copy) AMAlertComfirm _Nullable confirmBlock;

+ (instancetype _Nullable)shareInstance;

- (void)show;
- (void)hide;

@end

typedef NS_ENUM(NSUInteger, AMMeetingNewAlertViewType) {
    ///未开启约见功能
    AMMeetingNewAlertViewTypeNotOpen = 0,
    ///人员不足
    AMMeetingNewAlertViewTypeUnderstaffed
};

#pragma mark - AMMeetingNewAlertView
@interface AMMeetingNewAlertView : UIView

@property (nonatomic ,assign) AMMeetingNewAlertViewType type;
@property (nonatomic ,copy, nullable) AMAlertComfirm confirmBlock;
@property (nonatomic ,copy, nullable) NSString *titleStr;

+ (instancetype _Nullable)shareInstance;

- (void)show;
- (void)hide;

@end
