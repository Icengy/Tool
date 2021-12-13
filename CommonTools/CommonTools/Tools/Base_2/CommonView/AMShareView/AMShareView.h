//
//  AMShareView.h
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/11/27.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import "BasePopView.h"

#import "AMShareViewCell.h"

typedef NS_ENUM(NSUInteger, AMShareViewStyle) {
    ///默认模式 只包含举报与屏蔽
    AMShareViewStyleDefalut = 0,
    ///分享模式 包含微信、朋友圈分享、复制、举报与屏蔽
    AMShareViewStyleShare,
    ///分享模式 包含微信、朋友圈分享、复制
    AMShareViewStyleInvite,
    /// 分享模式 包含微信、朋友圈图片分享、本地下载
    AMShareViewStyleImage
};

typedef NS_ENUM(NSUInteger, AMImageShareWayStyle) {
    /// 微信
    AMImageShareWayStyleWX = 0,
    /// 朋友圈
    AMImageShareWayStyleWXFriend,
    /// 保存本地
    AMImageShareWayStyleSave
};

@class AMShareView;
NS_ASSUME_NONNULL_BEGIN

@protocol AMShareViewDelegate <NSObject>

@optional
- (void)shareView:(AMShareView *)shareView didSelectedWithItemStyle:(AMShareViewItemStyle)itemStyle;

@end

@interface AMShareView : BasePopView

@property (nonatomic, weak) id <AMShareViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic ,strong) NSDictionary *params;

+ (AMShareView *)shareInstanceWithStyle:(AMShareViewStyle)style;

@end

//#pragma mark -
//@class AMImageShareView;
//@protocol AMImageShareViewDelegate <NSObject>
//
//@optional
//- (void)shareView:(AMImageShareView *)shareView didSelectedWithItemStyle:(AMImageShareWayStyle)style;
//
//@end
//
//@interface AMImageShareView : BaseView
//@property (nonatomic ,weak) id <AMImageShareViewDelegate> delegate;
//@end

NS_ASSUME_NONNULL_END
