//
//  AMDialogView.h
//  ArtMedia2
//
//  Created by icnengy on 2020/6/3.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface AMDialogView : UIView <UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIView *mainCarrier;

+ (instancetype)shareInstance;

- (void)show;
- (void)hide;
- (void)hide:(void (^)(void))completion;

@end

#pragma mark - AMImageSelectDialogView
@interface AMImageSelectDialogView : AMDialogView

@property (nonatomic, strong) NSArray <NSString *>*itemData;
@property (nonatomic, copy) NSString *title;

/// imageSelectedBlock isTop:上面的按钮
@property (nonatomic, copy) void(^imageSelectedBlock)(AMImageSelectedMeidaType meidaType);

@end

#pragma mark - AMAuthDialogView
@interface AMAuthDialogView : AMDialogView

@property (nonatomic, copy) NSString *title;
/// imageSelectedBlock isTop:上面的按钮
@property (nonatomic, copy) void(^imageSelectedBlock)(AMImageSelectedMeidaType meidaType);

@end

#pragma mark - AMTableDialogView
typedef NS_ENUM(NSUInteger, AMTableDialogType) {
    AMTableDialogTypeMenu = 0,      //菜单
    AMTableDialogTypeBank  //银行名列表
};

@protocol AMTableDialogViewDataSource <NSObject>

@required
/// 传入数据源
/// @param dialogView self
- (NSArray *)dialogViewDataSource:(AMDialogView *)dialogView;

@optional
/// 针对银行列表
/// @param dialogView self
- (NSInteger)dialogViewSelectedItem:(AMDialogView *)dialogView;

@end

@protocol AMTableDialogViewDelegate <NSObject>

@optional
/// 分组点击事件
/// @param dialogView self
/// @param indexPath indexPath
- (void)dialogView:(AMDialogView *)dialogView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface AMTableDialogView : AMDialogView

@property (nonatomic ,weak ,nullable) id <AMTableDialogViewDelegate> delegate;
@property (nonatomic ,weak, nullable) id <AMTableDialogViewDataSource> dataSource;

@property (nonatomic ,assign) AMTableDialogType tableType;

@end

#pragma mark - AMThumbsDialogView
@interface AMThumbsDialogView : AMDialogView

@property (nonatomic ,assign) NSInteger thumbsCount;

@end

#pragma mark - AMMeetingConfirmDialogView
@interface AMMeetingConfirmDialogView : AMDialogView

@property (nonatomic, assign) NSInteger inviteCount;
@property (nonatomic ,copy) NSString *beginDate;
@property (nonatomic ,strong) NSArray *numberRangeArray;
@property (nonatomic ,copy) NSString *meetingTips;

@property (nonatomic, copy) void(^meetingConfirmBlock)(void);

@end


#pragma mark - AMMeetingCancelDialogView
typedef NS_ENUM(NSUInteger, AMMeetingEditCancelDialogStyle) {
    AMMeetingEditCancelDialogEdit = 0,      //编辑
    AMMeetingEditCancelDialogCancel  //取消
};

@interface AMMeetingEditCancelDialogView : AMDialogView

@property (nonatomic, assign) AMMeetingEditCancelDialogStyle style;
@property (nonatomic, copy) void(^meetingInfoBlock)(NSString * _Nullable reason);

@end


NS_ASSUME_NONNULL_END
