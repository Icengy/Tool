//
//  WebViewURLViewController.h
//  tableview嵌套webview
//
//  Created by WOSHIPM on 16/7/2.
//  Copyright © 2016年 WOSHIPM. All rights reserved.
//

#import "BaseViewController.h"

@protocol WebViewURLViewControllerDelegate <NSObject>

@optional
- (void)webViewDidSelectedJSForShare:(NSInteger)shareType;
- (void)webViewDidSelectedJSForSaveImage:(id _Nullable)imageData;

@end

@interface WebViewURLViewController : BaseViewController

@property (nonatomic ,weak) id <WebViewURLViewControllerDelegate> _Nullable delegate;

@property (nonatomic ,assign) BOOL isShare;
@property (nonatomic ,copy) NSString * _Nullable navigationBarTitle;
/// 是否需要适配底部安全距离
@property (nonatomic ,assign) BOOL needSafeAreaBottomHeight;

- (instancetype _Nonnull )initWithUrlString:(NSString *_Nullable)urlString;

@end
