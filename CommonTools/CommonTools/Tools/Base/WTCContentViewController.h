//
//  WTCContentViewController.h
//  ESTicket
//
//  Created by Homosum on 2017/12/18.
//  Copyright © 2017年 九辰_王添诚. All rights reserved.
//
typedef enum : NSInteger{
    WTCContentTypeDefault,	//有tabbar 无导航栏
    WTCContentTypeOther,	//无导航栏 无tabbar
    WTCContentTypeNav	//有导航栏 无tabbar
} WTCContentType;

#import "ESViewController.h"
@interface WTCContentViewController : ESViewController
-(void)loadRequstWithURLString:(NSString *)url;
@property (nonatomic, strong)NSString*url;
@property (nonatomic, assign)WTCContentType contentType;
@end
