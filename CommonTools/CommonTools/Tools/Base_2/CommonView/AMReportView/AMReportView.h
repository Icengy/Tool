//
//  AMReportView.h
//  ArtMedia2
//
//  Created by 美术传媒 on 2020/1/13.
//  Copyright © 2020 lcy. All rights reserved.
//

#import "BasePopView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AMReportView : BasePopView

/// 1短视频，2评论，3回复
@property (nonatomic ,copy) NSString *obj_type;
/// 1短视频，2评论，3回复 对于ID
@property (nonatomic ,copy) NSString *obj_id;

@end

NS_ASSUME_NONNULL_END
