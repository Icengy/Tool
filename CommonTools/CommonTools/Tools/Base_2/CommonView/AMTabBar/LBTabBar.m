//
//  LBTabBar.m
//  XianYu
//
//  Created by li  bo on 16/5/28.
//  Copyright © 2016年 li  bo. All rights reserved.
//

#import "LBTabBar.h"
#import <objc/runtime.h>
//#import "UIImage+Image.h"
#import "UIView+LBExtension.h"

#define LBMagin 10
@interface LBTabBar ()

/** plus按钮 */
@property (nonatomic, strong) AMButton *plusBtn ;
@property (nonatomic, strong) UIView *topLine;

@end

@implementation LBTabBar

- (AMButton *)plusBtn {
    if (!_plusBtn) {
        _plusBtn = [AMButton buttonWithType:UIButtonTypeCustom];
        _plusBtn.backgroundColor = [UIColor clearColor];
        [_plusBtn setBackgroundImage:[UIImage imageNamed:@"main_upload_big"] forState:UIControlStateNormal];
        [_plusBtn setBackgroundImage:[UIImage imageNamed:@"main_upload_big"] forState:UIControlStateHighlighted];
        [_plusBtn addTarget:self action:@selector(plusBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        
        _plusBtn.centerX = self.centerX;
        //调整发布按钮的中线点Y值
        _plusBtn.centerY = self.centerY;
        _plusBtn.size = CGSizeMake(_plusBtn.currentBackgroundImage.size.width*0.9, _plusBtn.currentBackgroundImage.size.height*0.9);
    }return _plusBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        //        ----runtime - test----

        //        unsigned int count = 0;
        //        Ivar *ivarList = class_copyIvarList([UITabBar class], &count);
        //        for (int i =0; i<count; i++) {
        //            Ivar ivar = ivarList[i];
        //            LBLog(@"%s",ivar_getName(ivar));
        //        }

        //[self setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]]];

//        self.backgroundColor = Color_Whiter;
//        [self setShadowImage:[self imageWithColor:[UIColor clearColor]]];
		
		UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, K_Width, TabBar_Height+SafeAreaBottomHeight)];

		backView.image = [UIImage imageWithColor:RGBA(247, 247, 247, 0.4f)  size:backView.size];
		UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
		UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
		effectView.frame = backView.bounds;
		[backView addSubview:effectView];
		//这两句话缺一不可
		[self insertSubview:backView atIndex:0];//添加到 tabbar 底层
		self.backgroundImage = backView.image;//替换掉原生毛玻璃图层
		self.shadowImage = [UIImage imageWithColor:RGB(230, 230, 230) size:CGSizeMake(1.0f, 0.5f)];
		self.translucent = YES;

        [self addSubview:self.plusBtn];
		
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
	//防止高度动态改变 这里写死self的frame
	CGFloat height = TabBar_Height + SafeAreaBottomHeight;
	if (self.height != height) {
		CGRect frame = self.frame;
		frame.size.height = height;
		frame.origin.y = K_Height - height;
		self.frame = frame;
	}
	
    //系统自带的按钮类型是UITabBarButton，找出这些类型的按钮，然后重新排布位置，空出中间的位置
    self.plusBtn.centerX = self.centerX;
    //调整发布按钮的中线点Y值
//    self.plusBtn.centerY = self.plusBtn.currentBackgroundImage.size.height*0.25;
	self.plusBtn.centerY = self.plusBtn.currentBackgroundImage.size.height*0.8f;

    self.plusBtn.size = CGSizeMake(self.plusBtn.currentBackgroundImage.size.width*0.9, self.plusBtn.currentBackgroundImage.size.height*0.9);

//        UILabel *label = [[UILabel alloc] init];
//        label.text = @"";
//        label.font = [UIFont systemFontOfSize:11];
//        [label sizeToFit];
//        label.textColor = [UIColor grayColor];
//        [self addSubview:label];
//        label.centerX = self.plusBtn.centerX;
//        label.centerY = CGRectGetMaxY(self.plusBtn.frame) + LBMagin ;

	Class class = NSClassFromString(@"UITabBarButton");
    int btnIndex = 0;
    for (UIView *btn in self.subviews) {//遍历tabbar的子控件
        if ([btn isKindOfClass:class]) {//如果是系统的UITabBarButton，那么就调整子控件位置，空出中间位置
            //每一个按钮的宽度==tabbar的三分之一
            btn.width = self.width / 5;

            btn.x = btn.width * btnIndex;

            btnIndex++;
            //如果是索引是2(从0开始的)，直接让索引++，目的就是让消息按钮的位置向右移动，空出来发布按钮的位置
            if (btnIndex == 2) {
                btnIndex++;
            }
            
        }
    }
    
    [self bringSubviewToFront:self.plusBtn];
}

//点击了发布按钮
- (void)plusBtnDidClick
{
    //如果tabbar的代理实现了对应的代理方法，那么就调用代理的该方法
    if ([self.delegate respondsToSelector:@selector(tabBarPlusBtnClick:)]) {
        [self.myDelegate tabBarPlusBtnClick:self];
    }

}

//重写hitTest方法，去监听发布按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO) {

        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.plusBtn];

        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.plusBtn pointInside:newP withEvent:event]) {
            return self.plusBtn;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了

            return [super hitTest:point withEvent:event];
        }
    }

    else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}

@end
