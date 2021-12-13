//
//  AMPayModel.h
//  ArtMedia2
//
//  Created by icnengy on 2020/5/21.
//  Copyright © 2020 翁磊. All rights reserved.
//
//  支付界面布局
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AMPayModel : NSObject

@property (nonatomic, copy ,nullable) NSString *iconStr;
@property (nonatomic, copy ,nullable) NSString *titleStr;
@property (nonatomic, copy ,nullable) NSString *subTitleStr;
/// 是否选中
@property (nonatomic, assign) BOOL isSelected;
/// 艺币不足
@property (nonatomic, assign) BOOL needRecharge;
@property (nonatomic, assign) AMPayWay wayType;

@end

NS_ASSUME_NONNULL_END
