//
//  AMAlertView.m
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/10/29.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import "AMAlertView.h"

static BOOL _hadInstance = NO;

@interface AMAlertView ()
@property (nonatomic ,strong) UIView *mainContentView;
@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) UILabel *messageLabel;
@property (nonatomic ,strong) AMButton *confirmBtn;
@property (nonatomic ,strong) AMButton *cancelBtn;
@end


//static AMAlertView *_singleInstance = nil;
@implementation AMAlertView
{
	AMAlertComfirm _confirmBlock;
	AMAlertCancel _cancelBlock;
	NSString *_titleString;
	NSString *_messageString;
	NSArray *_buttonArray;
	CGFloat _titleHeight;
	CGFloat _messageHeight;
	AMAlertType _alertType;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (AMAlertView *)shareInstanceWithTitle:(NSString * __nonnull)titleString
							buttonArray:(NSArray * __nonnull)buttonTitleArray
								confirm:(AMAlertComfirm)confirm
								 cancel:(AMAlertCancel)cancel {
	
	return [[AMAlertView alloc] initWithTitle:titleString message:nil buttonArray:buttonTitleArray alertType:AMAlertTypeNormal confirm:confirm cancel:cancel];
}

+ (AMAlertView *)shareInstanceWithTitle:(NSString * __nonnull)titleString
								message:(NSString *_Nullable)message
							buttonArray:(NSArray * __nonnull)buttonTitleArray
							  alertType:(AMAlertType)alertType
								confirm:(AMAlertComfirm)confirm
								 cancel:(AMAlertCancel)cancel {
	
	return [[AMAlertView alloc] initWithTitle:titleString message:message buttonArray:buttonTitleArray alertType:alertType confirm:confirm cancel:cancel];
}

- (instancetype) initWithTitle:(NSString * __nonnull)titleString
					   message:(NSString *_Nullable)message
				   buttonArray:(NSArray * __nonnull)buttonTitleArray
						  alertType:(AMAlertType)alertType
					   confirm:(void (^)(void))confirm
						cancel:(void (^)(void))cancel {
	if (self = [super init]) {
		self.frame = CGRectMake(0, 0, K_Width, K_Height);
		self.alpha = 0.0;
		self.backgroundColor = [RGB(21, 22, 26) colorWithAlphaComponent:0.8];
        if (@available(iOS 13.0, *)) {
            [self setOverrideUserInterfaceStyle:UIUserInterfaceStyleLight];
        }
		_buttonArray = buttonTitleArray;
		_titleString = titleString;
		_messageString = message;
		_confirmBlock = confirm;
		_cancelBlock = cancel;
		[self initSubViews];
	}
	return self;
}

- (void)initSubViews {
	if (self.subviews.count) {
		[self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
	}
	
	if ([ToolUtil isEqualToNonNull:_messageString ]) {
		self.messageLabel.text = _messageString;
		CGSize messageSize = [_messageString sizeWithFont:self.messageLabel.font andMaxSize:CGSizeMake(self.width*3/4-ADAptationMargin*4, MAXFLOAT)];
		_messageHeight = messageSize.height + 4.0f;
		if (_messageHeight < ADRowHeight) {
			_messageHeight = ADRowHeight;
		}
	}else {
		_messageHeight = 0.0f;
		self.titleLabel.font = [UIFont addHanSanSC:15.0f fontType:1];
	}
	self.titleLabel.text = _titleString;
	CGSize size = [self.titleLabel.text sizeWithFont:self.titleLabel.font andMaxSize:CGSizeMake(self.width*3/4-ADAptationMargin*4, MAXFLOAT)];
	_titleHeight = size.height + 8.0f;
	
	if (_titleHeight < ADRowHeight) _titleHeight = ADRowHeight;
	
	[self addSubview:self.mainContentView];
	self.mainContentView.layer.cornerRadius = 4.0f;
	self.mainContentView.clipsToBounds = YES;
	
	[self.mainContentView addSubview:self.titleLabel];
	[self.mainContentView addSubview:self.messageLabel];
	[self.mainContentView addSubview:self.confirmBtn];
	[self.mainContentView addSubview:self.cancelBtn];
	
	self.cancelBtn.hidden = (_buttonArray.count == 1)?YES:NO;
	if ([_titleString isEqualToString:@"版本更新提示!"]) {
		[self.confirmBtn setTitleColor:Color_Red forState:UIControlStateNormal];
	}else {
		[self.confirmBtn setTitleColor:RGB(17,103,219) forState:UIControlStateNormal];
	}
}

- (void)layoutSubviews {
	[super layoutSubviews];
	//ADAptationMargin/2+titleHeight+messageHegiht+ADBottomButtonHeight
	[self.mainContentView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.equalTo(self);
		make.centerY.equalTo(self.mas_centerY).offset(-ADAPTATIONRATIOVALUE(44.0f));
		make.width.offset(self.width*3/4);
		make.height.offset(ADAptationMargin*3/2+_titleHeight+_messageHeight+ADBottomButtonHeight);
	}];
	
	[self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.equalTo(self.mainContentView);
		make.top.equalTo(self.mainContentView.mas_top).offset(ADAptationMargin);
		make.width.offset(self.width*3/4-ADAptationMargin*4);
		make.height.offset(_titleHeight);
	}];
	[self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.equalTo(self.mainContentView);
		make.top.equalTo(self.titleLabel.mas_bottom).offset(0);
		make.width.offset(self.width*3/4-ADAptationMargin*4);
		make.height.offset(_messageHeight);
	}];
	[self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.equalTo(self.mainContentView.mas_right).offset(-ADAptationMargin *2);
		make.bottom.equalTo(self.mainContentView.mas_bottom).offset(-ADAptationMargin/2);
		make.height.offset(ADBottomButtonHeight);
		make.width.offset(ADBottomButtonHeight *1.5);
	}];
	
	if (_buttonArray.count != 1) {
		[self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
			make.right.equalTo(self.confirmBtn.mas_left).offset(-ADAptationMargin);
			make.width.height.centerY.equalTo(self.confirmBtn);
		}];
	}
}

#pragma mark -
- (void)show {
	[[UIApplication sharedApplication] .keyWindow addSubview:self];
	static NSInteger alpha = 0;
	[UIView animateWithDuration:0.3 animations:^{
		alpha += 100;
		self.alpha = alpha/100.0f;
	}];
}

- (void)hide:(void (^ __nullable)(BOOL finished))completion {
	static NSInteger alpha = 100;
	[UIView animateWithDuration:0.3 animations:^{
		alpha -= 0;
		self.alpha = alpha/100.0f;
	} completion:^(BOOL finished) {
		[self removeFromSuperview];
		if (completion) completion(finished);
	}];
}


#pragma mark -
- (UIView *)mainContentView {
	if (!_mainContentView) {
		_mainContentView = [[UIView alloc] init];
		_mainContentView.backgroundColor = Color_Whiter;
	}return _mainContentView;
}

- (UILabel *)titleLabel {
	if (!_titleLabel) {
		_titleLabel = [[UILabel alloc] init];
		
		_titleLabel.numberOfLines = 2;
		_titleLabel.font = [UIFont addHanSanSC:15.0f fontType:1];
		_titleLabel.textColor = Color_Black;
		
	}return _titleLabel;
}

- (UILabel *)messageLabel {
	if (!_messageLabel) {
		_messageLabel = [[UILabel alloc] init];
		
		_messageLabel.numberOfLines = 0;
		_messageLabel.font = [UIFont addHanSanSC:14.0f fontType:0];
		_messageLabel.textColor = Color_Grey;
		
	}return _messageLabel;
}

- (AMButton *)confirmBtn {
	if (!_confirmBtn) {
		_confirmBtn = [AMButton buttonWithType:UIButtonTypeCustom];
		
		[_confirmBtn setTitle:_buttonArray.firstObject forState:UIControlStateNormal];
		_confirmBtn.titleLabel.font = [UIFont addHanSanSC:15.0f fontType:0];
		[_confirmBtn setTitleColor:RGB(17,103,219) forState:UIControlStateNormal];
		_confirmBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
		
		[_confirmBtn addTarget:self action:@selector(clickToConfirm:) forControlEvents:UIControlEventTouchUpInside];
		
	}return _confirmBtn;
}

- (AMButton *)cancelBtn {
	if (!_cancelBtn) {
		_cancelBtn = [AMButton buttonWithType:UIButtonTypeCustom];
		
		[_cancelBtn setTitle:_buttonArray.lastObject forState:UIControlStateNormal];
		_cancelBtn.titleLabel.font = [UIFont addHanSanSC:15.0f fontType:0];
		[_cancelBtn setTitleColor:Color_Black forState:UIControlStateNormal];
		_cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
		
		[_cancelBtn addTarget:self action:@selector(clickToCancel:) forControlEvents:UIControlEventTouchUpInside];
		
	}return _cancelBtn;
}

#pragma mark -
- (void)clickToConfirm:(id)sender {
	if (_alertType == AMAlertTypeNonDissmiss) {
		if (_confirmBlock) _confirmBlock();
	}else {
		[self hide:^(BOOL finished) {
			if (_confirmBlock) _confirmBlock();
		}];
	}
}

- (void)clickToCancel:(id)sender {
	[self hide:^(BOOL finished) {
		if (_cancelBlock) _cancelBlock();
	}];
}


@end


#pragma mark -
@interface SingleAMAlertView () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet AMButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIView *marginLine;

@property (weak, nonatomic) IBOutlet AMButton *cancelBtn;

@end

@implementation SingleAMAlertView

+ (instancetype)shareInstance {
    if (!_hadInstance) {
        _hadInstance = YES;
        NSArray *objArray = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([AMAlertView class]) owner:self options:nil];
        for (id obj in objArray) {
            if ([obj isKindOfClass:self]) {
                return obj;
            }
        }
    }
    return nil;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _titleLabel.font = [UIFont addHanSanSC:18.0f fontType:2];
    _subTitleLabel.font = [UIFont addHanSanSC:14.0f fontType:0];
    _confirmBtn.titleLabel.font = [UIFont addHanSanSC:18.0f fontType:0];
    
    self.frame = [UIScreen mainScreen].bounds;
    self.contentView.backgroundColor = UIColor.whiteColor;
    
    self.canTouchBlank = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = _title;
    [_titleLabel adjustsFontSizeToFitWidth];
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    _titleLabel.font = _titleFont;
}

- (void)setSubTitle:(NSString *)subTitle {
    _subTitle = subTitle;
    _subTitleLabel.text = subTitle;
    [_subTitleLabel adjustsFontSizeToFitWidth];
}

- (void)setSubTitleFont:(UIFont *)subTitleFont {
    _subTitleFont = subTitleFont;
    _subTitleLabel.font = _subTitleFont;
}

- (void)setSubAttributedTitle:(NSAttributedString *)subAttributedTitle {
    _subAttributedTitle = subAttributedTitle;
    _subTitleLabel.attributedText = _subAttributedTitle;
    [_subTitleLabel adjustsFontSizeToFitWidth];
}

- (void)setNeedCancelShow:(BOOL)needCancelShow {
    _needCancelShow = needCancelShow;
    self.cancelBtn.hidden = !_needCancelShow;
    self.marginLine.hidden = !_needCancelShow;
}

#pragma mark -
- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^ {
    } completion:nil];
}

- (void)hide {
    [UIView animateWithDuration:0.4f delay:0.0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^ {
    }completion:^(BOOL finished) {
        _hadInstance = NO;
        [self removeFromSuperview];
    }];
}

- (void)hide:(void (^ __nullable)(void))completion {
    [UIView animateWithDuration:0.4f delay:0.0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^ {
    }completion:^(BOOL finished) {
        _hadInstance = NO;
        if (completion)  completion();
        [self removeFromSuperview];
    }];
}

- (IBAction)clickToConfirm:(id)sender {
    @weakify(self);
    [self hide:^{
        @strongify(self);
        if (self.confirmBlock) self.confirmBlock();
    }];
}

- (IBAction)clickToCancel:(id)sender {
    [self hide];
}


#pragma mark -
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.contentView]) {
        return NO;
    }
    return self.canTouchBlank;
}

@end


#pragma mark -
@interface AMMeetingSettingAlertView () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet AMButton *confirmBtn;
@property (weak, nonatomic) IBOutlet AMButton *cancelBtn;

@end

@implementation AMMeetingSettingAlertView

+ (instancetype)shareInstance {
    if (!_hadInstance) {
        _hadInstance = YES;
        NSArray *objArray = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([AMAlertView class]) owner:self options:nil];
        for (id obj in objArray) {
            if ([obj isKindOfClass:self]) {
                return obj;
            }
        }
    }
    return nil;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        self.canTouchBlank = YES;
        self.frame = [UIScreen mainScreen].bounds;
    }return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    _titleLabel.font = [UIFont addHanSanSC:18.0f fontType:2];
    _subTitleLabel.font = [UIFont addHanSanSC:14.0f fontType:0];
    _confirmBtn.titleLabel.font = [UIFont addHanSanSC:15.0f fontType:0];
    _cancelBtn.titleLabel.font = [UIFont addHanSanSC:15.0f fontType:0];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = _title;
    [_titleLabel adjustsFontSizeToFitWidth];
}

- (void)setSubTitle:(NSString *)subTitle {
    _subTitle = subTitle;
    _subTitleLabel.text = subTitle;
    [_subTitleLabel adjustsFontSizeToFitWidth];
}

#pragma mark -
- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^ {
    } completion:nil];
}

- (void)hide {
    [UIView animateWithDuration:0.4f delay:0.0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^ {
    }completion:^(BOOL finished) {
        _hadInstance = NO;
        [self removeFromSuperview];
    }];
}

- (IBAction)clickToConfirm:(id)sender {
    if (_confirmBlock) _confirmBlock();
    [self hide];
}

- (IBAction)clickToCancel:(id)sender {
    [self hide];
}

#pragma mark -
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.contentView]) {
        return NO;
    }
    return self.canTouchBlank;
}

@end

#pragma mark - AMMeetingNewAlertView
@interface AMMeetingNewAlertView () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *compoundView;
@property (weak, nonatomic) IBOutlet AMButton *cancelBtn;
@property (weak, nonatomic) IBOutlet AMButton *nextBtn;

@property (weak, nonatomic) IBOutlet AMButton *getBtn;

@end

@implementation AMMeetingNewAlertView

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [Color_Black colorWithAlphaComponent:0.2];
    }return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.font = [UIFont addHanSanSC:15.0f fontType:0];
    self.cancelBtn.titleLabel.font = [UIFont addHanSanSC:18.0f fontType:0];
    self.nextBtn.titleLabel.font = [UIFont addHanSanSC:18.0f fontType:0];
    
    self.getBtn.titleLabel.font = [UIFont addHanSanSC:18.0f fontType:0];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}

#pragma mark -
+ (instancetype)shareInstance {
    if (!_hadInstance) {
        _hadInstance = YES;
        NSArray *objArray = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([AMAlertView class]) owner:self options:nil];
        for (id obj in objArray) {
            if ([obj isKindOfClass:self]) {
                return obj;
            }
        }
    }
    return nil;
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^ {
    } completion:nil];
}

- (void)hide {
    [UIView animateWithDuration:0.4f delay:0.0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^ {
    }completion:^(BOOL finished) {
        _hadInstance = NO;
        [self removeFromSuperview];
    }];
}

- (void)hide:(void (^ __nullable)(void))completion {
    [UIView animateWithDuration:0.4f delay:0.0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^ {
    }completion:^(BOOL finished) {
        _hadInstance = NO;
        if (completion)  completion();
        [self removeFromSuperview];
    }];
}

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    self.titleLabel.text = _titleStr;
}

- (void)setType:(AMMeetingNewAlertViewType)type {
    _type = type;
    if (_type == AMMeetingNewAlertViewTypeNotOpen) {
        [self showBtnHidden:YES];
    }
    if (_type == AMMeetingNewAlertViewTypeUnderstaffed) {
        [self showBtnHidden:NO];
    }
}

- (void)showBtnHidden:(BOOL)hidden {
    self.getBtn.hidden = hidden;
    self.compoundView.hidden = !hidden;
}

#pragma mark -
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.contentView]) {
        return NO;
    }
    return YES;
}

#pragma mark -
- (IBAction)clickToNext:(id)sender {
    [self hide:^{
        if (self.confirmBlock)  self.confirmBlock();
    }];
}

- (IBAction)clickToCancel:(id)sender {
    [self hide];
}
@end
