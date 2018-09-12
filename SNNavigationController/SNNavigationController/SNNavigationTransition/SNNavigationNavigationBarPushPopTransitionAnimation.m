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
	
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    SNNavigationBar * navigationBar = toViewController.sn_navigationController.sn_navigationBar;
    
    //处理视图控制器为标签栏视图控制器的情况
    if ([toViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController * tabbarController = (UITabBarController *)toViewController;
        toViewController = tabbarController.selectedViewController;
    }
    if ([fromViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController * tabbarController = (UITabBarController *)fromViewController;
        fromViewController = tabbarController.selectedViewController;
    }
    
    SNNavigationItem * navigationItemFrom = fromViewController.sn_navigationItem;
    SNNavigationItem * navigationItemTo = toViewController.sn_navigationItem;
    
    navigationBar.labelTitle.text = toViewController.title;
    navigationBar.labelFromTile.text = fromViewController.title;
    
    navigationBar.labelTitle.alpha = 0;
    navigationBar.labelFromTile.alpha = 1;
    
    navigationBar.viewLeftBarButtonStack.alpha = 0;
    navigationBar.viewFromLeftBarButtonStack.alpha = 1;
    
    navigationBar.backgroundColor = navigationItemFrom.barBackgroudColor;
    
    if (self.reverse) { // pop
        navigationBar.labelFromTile.center = CGPointMake(SCREEN_WIDTH/2, navigationBar.labelFromTile.center.y);
    } else {
        navigationBar.labelTitle.center = CGPointMake(SCREEN_WIDTH, navigationBar.labelFromTile.center.y);
    }
    
    [UIView animateWithDuration:duration/2 animations:^{
        
        navigationBar.viewFromLeftBarButtonStack.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration/2 animations:^{
            navigationBar.viewLeftBarButtonStack.alpha = 1;
        }];
    }];
    
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        navigationBar.labelTitle.alpha = 1;
        navigationBar.labelFromTile.alpha = 0;
        
        
        
        if (self.reverse) { // pop
            
            navigationBar.backgroundColor = navigationItemTo.barBackgroudColor;
            navigationBar.alpha = 1;
            navigationBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, navigationItemTo.barHeight);
            navigationBar.labelFromTile.center = CGPointMake(SCREEN_WIDTH, navigationBar.labelFromTile.center.y);
        } else { // push
            
            navigationBar.backgroundColor = navigationItemTo.barBackgroudColor;
            navigationBar.alpha = 1;
            navigationBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, navigationItemTo.barHeight);
            navigationBar.labelTitle.center = CGPointMake(SCREEN_WIDTH/2, navigationBar.labelFromTile.center.y);
        }


    } completion:^(BOOL finished) {
        navigationBar.labelTitle.center = CGPointMake(SCREEN_WIDTH/2, navigationBar.labelFromTile.center.y);
        navigationBar.labelFromTile.center = CGPointMake(SCREEN_WIDTH/2, navigationBar.labelFromTile.center.y);
    }];
    [self navigationAnimateTransition:transitionContext fromViewController:fromViewController toViewController:toViewController fromView:fromView toView:toView];
}

- (void)navigationAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController fromView:(UIView *)fromView toView:(UIView *)toView {
    
}

@end
