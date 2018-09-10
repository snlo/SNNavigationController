//
//  SNNavigationNavigationBarPushPopTransitionAnimation.m
//  SNNavigationController
//
//  Created by snlo on 2018/8/31.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "SNNavigationNavigationBarPushPopTransitionAnimation.h"

@implementation SNNavigationNavigationBarPushPopTransitionAnimation

#pragma mark -- 只针对导航栏动画
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController fromView:(UIView *)fromView toView:(UIView *)toView {

//	toViewController.navigationController.sn_navigationBar.viewTitle.alpha = 1;
	
    NSTimeInterval duration = [self transitionDuration:transitionContext];
	
	if (self.reverse) { // pop
		toViewController.navigationController.sn_navigationBar.labelTitle.text = toViewController.title;
		toViewController.navigationController.sn_navigationBar.labelMoveTile.text = fromViewController.title;
		toViewController.navigationController.sn_navigationBar.labelTitle.alpha = 0;
		toViewController.navigationController.sn_navigationBar.labelMoveTile.alpha = 1;
		toViewController.navigationController.sn_navigationBar.labelMoveTile.center = CGPointMake(SCREEN_WIDTH/2, toViewController.navigationController.sn_navigationBar.labelMoveTile.center.y);
	} else {
		toViewController.navigationController.sn_navigationBar.labelTitle.text = toViewController.title;
		toViewController.navigationController.sn_navigationBar.labelMoveTile.text = fromViewController.title;
		toViewController.navigationController.sn_navigationBar.labelTitle.alpha = 0;
		toViewController.navigationController.sn_navigationBar.labelMoveTile.alpha = 1;
		toViewController.navigationController.sn_navigationBar.labelTitle.center = CGPointMake(SCREEN_WIDTH, toViewController.navigationController.sn_navigationBar.labelMoveTile.center.y);
	}
	
	
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        if (self.reverse) { // pop
			
            toViewController.navigationController.sn_navigationBar.backgroundColor = [UIColor redColor];
            toViewController.navigationController.sn_navigationBar.alpha = 1;
            toViewController.navigationController.sn_navigationBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
			
			
			toViewController.navigationController.sn_navigationBar.labelTitle.alpha = 1;
			toViewController.navigationController.sn_navigationBar.labelMoveTile.alpha = 0;
			toViewController.navigationController.sn_navigationBar.labelMoveTile.center = CGPointMake(SCREEN_WIDTH, toViewController.navigationController.sn_navigationBar.labelMoveTile.center.y);
			
        } else { // push
			
            toViewController.navigationController.sn_navigationBar.backgroundColor = [UIColor blueColor];
            toViewController.navigationController.sn_navigationBar.alpha = 1;
            toViewController.navigationController.sn_navigationBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 128);

			toViewController.navigationController.sn_navigationBar.labelTitle.alpha = 1;
			toViewController.navigationController.sn_navigationBar.labelMoveTile.alpha = 0;
			toViewController.navigationController.sn_navigationBar.labelTitle.center = CGPointMake(SCREEN_WIDTH/2, toViewController.navigationController.sn_navigationBar.labelMoveTile.center.y);
        }
    } completion:^(BOOL finished) {
		toViewController.navigationController.sn_navigationBar.labelTitle.center = CGPointMake(SCREEN_WIDTH/2, toViewController.navigationController.sn_navigationBar.labelMoveTile.center.y);
		toViewController.navigationController.sn_navigationBar.labelMoveTile.center = CGPointMake(SCREEN_WIDTH/2, toViewController.navigationController.sn_navigationBar.labelMoveTile.center.y);
    }];
    [self navigationAnimateTransition:transitionContext fromViewController:fromViewController toViewController:toViewController fromView:fromView toView:toView];
}

- (void)navigationAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController fromView:(UIView *)fromView toView:(UIView *)toView {
    
}

@end
