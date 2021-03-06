//
//  UIViewController+BackButtonHandler.m
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/10/24.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import "UIViewController+BackButtonHandler.h"
#import "MainNavigationController.h"

@implementation UIViewController (BackButtonHandler)

@end

@implementation MainNavigationController (ShouldPopOnBackButton)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
	
	if([self.viewControllers count] < [navigationBar.items count]) {
		return YES;
	}
	
	BOOL shouldPop = YES;
	UIViewController* vc = [self topViewController];
	if([vc respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
		shouldPop = [vc navigationShouldPopOnBackButton];
	}
	
	if(shouldPop) {
		dispatch_async(dispatch_get_main_queue(), ^{
			[self popViewControllerAnimated:YES];
		});
	}
	return NO;
}

@end
