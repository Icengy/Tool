//
//  ESViewController.m
//  ESTicket
//
//  Created by 鹏 刘 on 15/11/23.
//  Copyright © 2015年 鹏 刘. All rights reserved.
//

#import "ESViewController.h"
#import "WTCTitleView.h"


@interface ESViewController ()

@property (nonatomic, strong) WTCTitleView *titleView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, assign) BOOL showTitleButton;


@end

@implementation ESViewController

- (void)dealloc
{
    NSLog(@"%@ is dealloc",object_getClass(self));
    @try{
        [[NSNotificationCenter defaultCenter]removeObserver:self];//移除通知
    } @catch(id anException) {
        //do nothing, obviously it wasn't attached because an exception was thrown
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:[NSString stringWithFormat:@"进入 %@",self.title]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:[NSString stringWithFormat:@"离开 %@",self.title]];
//     self.navigationController.navigationBarHidden=;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    /**
     *  解决进入融云单聊页面后，POP返回后布局偏移的Bug
     */
    self.edgesForExtendedLayout = UIRectEdgeTop;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    self.view.backgroundColor = DefaultBackgroundColor;
    
    if (!self.hideBarSetting) {
    //    self.navigationItem.titleView = self.titleView;
        self.navigationController.navigationBar.barTintColor = ColorAppBlack;//ColorButtonRed;
        //去掉模糊效果
        UIView *navBackImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavBarHeight)];
        navBackImageView.backgroundColor = NavgationBarColor;
        UIImage *navBackImage = [LPUnitily createImageFromView:navBackImageView];
        [self.navigationController.navigationBar setBackgroundImage:navBackImage forBarMetrics:UIBarMetricsDefault];
        [self addNavBarBackButton];
    }

	//反馈悬浮窗
	[LPUnitily.keyWindow bringSubviewToFront:[LPUnitily.keyWindow viewWithTag:12345]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - scrollView delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	[UIView animateWithDuration:0.3f delay:0.f options:UIViewAnimationOptionLayoutSubviews animations:^{
		[[LPUnitily.keyWindow viewWithTag:12345] setX:SCREEN_WIDTH - 20];
		[LPUnitily.keyWindow viewWithTag:12345].alpha = 0.5;
	} completion:nil];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	if (decelerate) {
		return;
	}
	[UIView animateWithDuration:0.3f delay:1.0f options:UIViewAnimationOptionLayoutSubviews animations:^{
		[[LPUnitily.keyWindow viewWithTag:12345] setX:SCREEN_WIDTH - 55];
		[LPUnitily.keyWindow viewWithTag:12345].alpha = 1;
	} completion:nil];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	[UIView animateWithDuration:0.3f delay:1.0f options:UIViewAnimationOptionLayoutSubviews animations:^{
		[[LPUnitily.keyWindow viewWithTag:12345] setX:SCREEN_WIDTH - 55];
		[LPUnitily.keyWindow viewWithTag:12345].alpha = 1;
	} completion:nil];
}

#pragma mark - UITableViewDatasource Methods  子类有tableview的实现 =============

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *cellIdentifier = @"cellIdentifier";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    }
//    return cell;
//}

#pragma mark - UITableViewDatasource Methods  子类有tableview的实现 =============


/* 创建一个String导航按钮 */
- (UIBarButtonItem *)createStringNavBarItem:(NSString *)title
                                  textColor:(UIColor *)textColor
                                     action:(SEL)action {
    UIButton *button = [self createStringButton:title
                                      textColor:textColor
                                         action:action];
    UIBarButtonItem *barbutton = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barbutton;
}

- (UIButton *)createStringButton:(NSString *)title
                       textColor:(UIColor *)textColor
                          action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = fcFont(14);
    button.titleLabel.textColor = textColor;
    button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
//    CGSize textSize = [title sizeWithFont:button.titleLabel.font];
    CGSize textSize = [title sizeWithAttributes:@{NSFontAttributeName : [button.titleLabel font]}];
    button.frame = CGRectMake(0, 0, textSize.width, 30.0f);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}


- (UIBarButtonItem *)createLeftImageNavBarItem:(NSString *)normalImageName
                                  withHightImg:(NSString *)heightedImageName
                                        action:(SEL)action {
    UIButton *button = [self createLeftImageButton:normalImageName
                                      hightedImage:heightedImageName
                                            action:action];
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
	[contentView addSubview:button];
    UIBarButtonItem *barbutton = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    return barbutton;
}

- (UIButton *)createLeftImageButton:(NSString *)normalImageName
                       hightedImage:(NSString *)heightedImageName
                             action:(SEL)action {
    UIImage *barButtonImage = GetImage(normalImageName);
    UIImage *barButtonHighlightImage = GetImage(heightedImageName);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(0, 0, 22, 22);
    [button setImage:barButtonImage forState:UIControlStateNormal];
	button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button setImage:barButtonHighlightImage forState:UIControlStateHighlighted];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}


/* 创建一个图片导航按钮 */
- (UIBarButtonItem *)createImageNavBarItem:(NSString *)normalImageName
                              withHightImg:(NSString *)heightedImageName
                                    action:(SEL)action {
    
    UIButton *button = [self createImageButton:normalImageName
                                  hightedImage:heightedImageName
                                        action:action];
    UIBarButtonItem *barbutton = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barbutton;
}

/** 创建一个文字导航按钮*/
- (UIBarButtonItem *)greateTextNavBarItem:(NSString *)text action:(SEL)action
{
    UIButton *button = [self createTextButton:text action:action];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barButton;
}
-(UIBarButtonItem*)createRedButtonTextNavBarItem:(NSString *)text action:(SEL)action
{
    UIButton *button = [self createRedTextButton:text action:action];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barButton;
}
-(UIButton*)createRedTextButton:(NSString *)text action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, [LPUnitily getWidthFromString:text font:15.0f]+8, 30.0f);
    [button setTitle:text forState:UIControlStateNormal];
    button.titleLabel.font = GetFont(15.0f);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = ColorButtonRed;
    button.layer.shadowOffset = CGSizeMake(1, 1);
    button.layer.shadowColor = [UIColor blackColor].CGColor;
    button.layer.shadowOpacity = 0.5;
    button.layer.cornerRadius = 4;
    button.clipsToBounds = NO;
    
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}
- (UIButton *)createTextButton:(NSString *)text action:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, [LPUnitily getWidthFromString:text font:15.0f], 30.0f);
    [button setTitle:text forState:UIControlStateNormal];
    button.titleLabel.font = GetFont(15.0f);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (UIButton *)createImageButton:(NSString *)normalImageName
                   hightedImage:(NSString *)heightedImageName
                         action:(SEL)action {
    
    UIImage *barButtonImage = GetImage(normalImageName);
    UIImage *barButtonHighlightImage = GetImage(heightedImageName);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 35, 30.0f);
    [button setImage:barButtonImage forState:UIControlStateNormal];
    [button setImage:barButtonHighlightImage forState:UIControlStateHighlighted];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 35 - barButtonImage.size.width, 0, 0)];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

/* 填加返回按钮 */
- (void)addNavBarBackButton {
    if ([self.navigationController.navigationBar isKindOfClass:[UINavigationBar class]] &&
        self.navigationController.viewControllers &&
        [self.navigationController.viewControllers count] > 1) {
        self.navigationItem.leftBarButtonItem = [self createLeftImageNavBarItem:@"nav_return_btn" withHightImg:@"nav_return_btn" action:@selector(back:)];
    }
}

- (void)addGotoHomeButton{
    if ([self.navigationController.navigationBar isKindOfClass:[UINavigationBar class]] &&
        self.navigationController.viewControllers &&
        [self.navigationController.viewControllers count] > 2 &&
        !self.navigationItem.rightBarButtonItem) {
        self.navigationItem.rightBarButtonItem = [self createImageNavBarItem:@"top_icon_home.png" withHightImg:@"top_icon_home.png" action:@selector(gotoHome)];
    }
}

- (void)gotoHome {
    [ES_HttpService cancelAll];
    [ES_LPUnitily removeHUDToCurrentView];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)back:(id)sender {
    [ES_HttpService cancelAll];
    [ES_LPUnitily removeHUDToCurrentView];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dismissBack:(id)sender {
    [ES_HttpService cancelAll];
    [ES_LPUnitily removeHUDToCurrentView];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)setTitle:(NSString *)title{
//    [super setTitle:title];
    
    [self.navigationItem setTitleView:self.titleView];
    self.titleLabel.text = title;
}

- (void)setNavTitleText:(NSString *)navTitleText
{
    _navTitleText = navTitleText;
    self.titleLabel.text = navTitleText;
}

- (void)showTitleButtonView
{
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_titleView.centerX).offset(-6);
    }];
    _titleImageView.hidden = NO;
    [_titleButton addTarget:self action:@selector(toChoosetype:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)toChoosetype:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected) {
        _titleImageView.image = [UIImage imageNamed:@"up"];
    }else{
        _titleImageView.image = [UIImage imageNamed:@"down"];
    }
    [self chickTitleViewButton];
}
/** 子类需重写此方法 实现点击*/
- (void)chickTitleViewButton
{
    
}
- (void)setIconImageUp:(BOOL)iconImageUp
{
    _iconImageUp = iconImageUp;
    if (_iconImageUp) {
        _titleImageView.image = [UIImage imageNamed:@"up"];
    }else{
        _titleImageView.image = [UIImage imageNamed:@"down"];
    }
}
-(void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    _titleLabel.textColor = titleColor;
}
- (WTCTitleView *)titleView
{
    if (!_titleView) {
        _titleView = [[WTCTitleView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 200, 30)];
        self.titleLabel = [[UILabel alloc] init];
        [_titleView addSubview:self.titleLabel];
        _titleLabel.textColor = ColorAppBlack;
		_titleLabel.font = fcFont(18);
        self.titleImageView = [[UIImageView alloc] init];
        [_titleView addSubview:self.titleImageView];
        _titleImageView.image = [UIImage imageNamed:@"down"];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self->_titleView);
            make.width.lessThanOrEqualTo(@(SCREEN_WIDTH - 80));
        }];
        [_titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self->_titleLabel.mas_right).offset(5);
            make.centerY.equalTo(self->_titleView);
            make.size.mas_equalTo(CGSizeMake(13, 8));
        }];
        _titleImageView.hidden = YES;
        
        self.titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_titleView addSubview:self.titleButton];
        _titleButton.backgroundColor = [UIColor clearColor];
        [_titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_titleLabel.mas_left);
            make.right.mas_equalTo(self->_titleImageView.mas_right);
            make.centerY.equalTo(self->_titleView);
            make.height.equalTo(@(30));
        }];
        _titleView.intrinsicContentSize = CGSizeMake(SCREEN_WIDTH - 200, 40);
        
    }
    return _titleView;
}

- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _myTableView.backgroundColor = DefaultBackgroundColor;
        _myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _myTableView.backgroundView = nil;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.showsHorizontalScrollIndicator = NO;
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.sectionFooterHeight = 0.01;
        if (@available(iOS 11.0, *)){
            _myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        _myTableView.placeHolderView = [self placeHolderWithBounds:_myTableView.bounds];
		_myTableView.placeHolderLabel = [self placeHolderLabel];
    }
    return _myTableView;
}

- (UITableView *)plainTableView {
    if (!_plainTableView) {
        _plainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _plainTableView.backgroundColor = DefaultBackgroundColor;
        _plainTableView.backgroundView = nil;
        _plainTableView.delegate = self;
        _plainTableView.dataSource = self;
        _plainTableView.showsHorizontalScrollIndicator = NO;
        _plainTableView.showsVerticalScrollIndicator = NO;
//        if (@available(iOS 11.0, *)){
//            _plainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        }
        if ([_plainTableView respondsToSelector:@selector(setSeparatorInset:)])
        {
            [_plainTableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_plainTableView respondsToSelector:@selector(setLayoutMargins:)])
        {
            [_plainTableView setLayoutMargins:UIEdgeInsetsZero];
        }
		_plainTableView.placeHolderView = [self placeHolderWithBounds:_plainTableView.bounds];
		_plainTableView.placeHolderLabel = [self placeHolderLabel];
    }
    
    return _plainTableView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = DefaultBackgroundColor;
        _tableView.backgroundView = nil;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        if (self.hideSperator) {
            _tableView.separatorStyle=0;
        }
//        if (@available(iOS 11.0, *)){
//            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        }
        
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)])
        {
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)])
        {
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
        _tableView.placeHolderView = [self placeHolderWithBounds:_tableView.bounds];
		_tableView.placeHolderLabel = [self placeHolderLabel];
    }
    
    return _tableView;
}
-(UIImageView*)placeHolderWithBounds:(CGRect)bounds
{
    UIImageView*imageView = [[UIImageView alloc] init];
    return imageView;
}

- (UILabel *)placeHolderLabel {
	UILabel *label = [UILabel new];
	label.textColor = RGBCOLOR(58, 58, 58);
	label.font = fcFont(16);
	label.textAlignment = NSTextAlignmentCenter;
	label.numberOfLines = 0;
	return label;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}
#pragma mark 此方法加上是为了适配iOS 11出现的问题

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

//有时候tableview的底部视图也会出现此现象对应的修改就好了

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

@end
