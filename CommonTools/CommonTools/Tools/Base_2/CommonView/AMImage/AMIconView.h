//
//  AMIconView.h
//  ArtMedia2
//
//  Created by icnengy on 2020/12/15.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "BaseView.h"

#import "AMIconImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AMIconView : BaseView
@property (nonatomic ,weak) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet AMIconImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *artMark;

@end

NS_ASSUME_NONNULL_END
