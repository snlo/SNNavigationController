//
//  SNNavigationNavigationBarPushPopTransitionAnimation.m
//  SNNavigationController
//
//  Created by snlo on 2018/8/31.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "SNNavigationNavigationBarPushPopTransitionAnimation.h"

#import "SNNavigationBar.h"
#import "SNNavigationItem.h"

#import "SNNavigationControllerTool.h"

#import "SNNavigationTransitionDelegate.h"

#import "UIViewController+SNNavigationTransition.h"
#import "UINavigationController+SNNavigationTransition.h"

@implementation SNNavigationNavigationBarPushPopTransitionAnimation

#pragma mark -- 只针对导航栏动画
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController fromView:(UIView *)fromView toView:(UIView *)toView {
	
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    SNNavigationBar * navigationBar = toViewController.sn_navigationController.sn_navigationBar;
    
    if ([toViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController * tabbarController = (UITabBarController *)toViewController;
        toViewController = tabbarController.selectedViewController;
    }//处理视图控制器为标签栏视图控制器的情况
    if ([fromViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController * tabbarController = (UITabBarController *)fromViewController;
        fromViewController = tabbarController.selectedViewController;
    }
    SNNavigationItem * navigationItemFrom = fromViewController.sn_navigationItem;
    SNNavigationItem * navigationItemTo = toViewController.sn_navigationItem;
    
    toViewController.sn_navigationController.sn_navigationDelegate.percentDrivenTransition.interactionInProgress = YES;
    fromViewController.sn_navigationController.sn_navigationDelegate.percentDrivenTransition.interactionInProgress = YES;
    
    if (toViewController.isShowCustomNavigationBar || fromViewController.isShowCustomNavigationBar) {
        
    }
    if (toViewController.isShowSNNavigationBar || fromViewController.isShowSNNavigationBar) {
        
        [self handleTitleLabelAnimateTransition:transitionContext to:navigationItemTo from:navigationItemFrom with:navigationBar and:duration and:toViewController and:fromViewController];
    }
    if (toViewController.isShowSystemNavigationBar || fromViewController.isShowSystemNavigationBar) {
        
    }
    
    [self navigationAnimateTransition:transitionContext fromViewController:fromViewController toViewController:toViewController fromView:fromView toView:toView];
}

#pragma mark -- SNNavigationBar
- (void)handleTitleLabelAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext to:(SNNavigationItem *)navigationItemTo from:(SNNavigationItem *)navigationItemFrom with:(SNNavigationBar *)navigationBar and:(NSTimeInterval)duration and:(UIViewController *)toViewController and:(UIViewController *)fromViewController {
    
//    return; //未实现
    if (self.reverse) { // pop
        
    } else { //push
        
    }
    navigationBar.backgroundColor = navigationItemFrom.barBackgroudColor;
    [UIView animateKeyframesWithDuration:duration delay:0.0 options:0 animations:^{

        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{

        }];
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{

        }];
        navigationBar.backgroundColor = navigationItemTo.barBackgroudColor;
    } completion:^(BOOL finished) {

        if (transitionContext.transitionWasCancelled) {

        } else {

        }
    }];
}

#pragma mark -- API
- (void)navigationAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController fromView:(UIView *)fromView toView:(UIView *)toView {
    
}

@end
