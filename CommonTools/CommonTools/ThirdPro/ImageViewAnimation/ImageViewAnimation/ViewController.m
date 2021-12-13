//
//  ViewController.m
//  ImageViewAnimation
//
//  Created by 美术传媒 on 2019/12/16.
//  Copyright © 2019年 美术传媒. All rights reserved.
//

#import "ViewController.h"

@interface AnimationBtn : UIButton

@end

@implementation AnimationBtn

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self initAnimation];
	}return self;
}

- (void)initAnimation {
	CABasicAnimation *animation = [ CABasicAnimation animationWithKeyPath:@"transform"];
	animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
	//围绕Z轴旋转，垂直与屏幕
	animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI*0.99, 0.0, 0.0, 1.0)];
	animation.duration = 3;
	//旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
	animation.cumulative = YES;
	animation.repeatCount = MAXFLOAT;
	//下面可以不需要
	 CGRect imageRrect = CGRectMake(0, 0 ,self.imageView.frame.size.width, self.imageView.frame.size.height);
	 UIGraphicsBeginImageContext(imageRrect.size);
	 //在图片边缘添加一个像素的透明区域，去图片锯齿
	 [self.currentImage drawInRect:CGRectMake(1,1,self.imageView.frame.size.width-2,self.imageView.frame.size.height-2)];
	 [self setImage: UIGraphicsGetImageFromCurrentImageContext() forState:UIControlStateNormal];
	 UIGraphicsEndImageContext();
	[self.layer addAnimation:animation forKey:nil];
}

@end

@interface ViewController ()
@property (nonatomic ,strong) UIImageView *imageView;
@property (nonatomic ,strong) AnimationBtn *button;

@property (nonatomic ,assign) CGFloat angle;
@property (nonatomic ,assign) CGFloat angle2;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.angle = 0.0f;
	self.angle2 = 0.0f;
	
	_imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detail_flower_af"]];
	_imageView.frame = CGRectMake(100, 100, 50, 50);
	[self.view addSubview:_imageView];
	[self startAnimation];
	
	_button = [AnimationBtn buttonWithType:UIButtonTypeCustom];
	[self.view addSubview:_button];
	_button.frame = CGRectMake(100, 200, 50, 50);
	[_button setImage:[UIImage imageNamed:@"detail_flower_af"] forState:UIControlStateNormal];
	
}

- (void)startAnimation {
	CGAffineTransform endAngle = CGAffineTransformMakeRotation(self.angle * (M_PI /180.0f));
	[UIView animateWithDuration:0.33f delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
		self.imageView.transform = endAngle;
	} completion:^(BOOL finished) {
		self.angle += 15.0f;
		[self startAnimation];
	}];
//	[UIView beginAnimations:nil context:nil];
//	[UIView setAnimationDuration:0.01];
//	[UIView setAnimationDelegate:self];
//	[UIView setAnimationDidStopSelector:@selector(endAnimation)];
//	_imageView.transform = CGAffineTransformMakeRotation(angle * (M_PI /180.0f));
//	[UIView commitAnimations];
}

//-(void)endAnimation {
//	angle2 += 15;
//	[self startAnimation];
//}

- (void)startBtnAnimation {
	CGAffineTransform endAngle = CGAffineTransformMakeRotation(self.angle2 * (M_PI /180.0f));
	[UIView animateWithDuration:0.33f delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
		self.button.imageView.transform = endAngle;
	} completion:^(BOOL finished) {
		self.angle2 += 15.0f;
		[self startBtnAnimation];
	}];
//	[UIView beginAnimations:nil context:nil];
//	[UIView setAnimationDuration:0.01];
//	[UIView setAnimationDelegate:self];
//	[UIView setAnimationDidStopSelector:@selector(endBtnAnimation)];
//	_button.imageView.transform = CGAffineTransformMakeRotation(angle2 * (M_PI /180.0f));
//	[UIView commitAnimations];
}

//-(void)endBtnAnimation {
//	angle2 += 15;
//	[self startAnimation];
//}


@end
