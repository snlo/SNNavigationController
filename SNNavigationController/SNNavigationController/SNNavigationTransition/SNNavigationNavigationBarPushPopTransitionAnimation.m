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
    
    navigationBar.leftBarButtonItems = navigationItemTo.leftBarButtonItems;
    navigationBar.leftFromBarButtonItems = navigationItemFrom.leftBarButtonItems;
    
    navigationBar.rightBarButtonItems = navigationItemTo.rightBarButtonItems;
    navigationBar.rightFromBarButtonItems = navigationItemFrom.rightBarButtonItems;
    
    navigationBar.viewLeftBarButtonStack.alpha = 0;
    navigationBar.viewFromLeftBarButtonStack.alpha = 1;
    
    navigationBar.viewRightBarButtonStack.alpha = 0;
    navigationBar.viewFromRightBarButtonStack.alpha = 1;
    
    navigationBar.viewFromLeftBarButtonStack.hidden = NO;
    navigationBar.viewFromRightBarButtonStack.hidden = NO;
    
    navigationBar.backgroundColor = navigationItemFrom.barBackgroudColor;

    
    [UIView animateWithDuration:duration delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
        
        navigationBar.viewLeftBarButtonStack.alpha = 1;
        navigationBar.viewFromLeftBarButtonStack.alpha = 0;
        
        navigationBar.viewRightBarButtonStack.alpha = 1;
        navigationBar.viewFromRightBarButtonStack.alpha = 0;
        
        if (self.reverse) { // pop
            navigationBar.backgroundColor = navigationItemTo.barBackgroudColor;
            navigationBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, navigationItemTo.barHeight);
            
        } else { // push
            navigationBar.backgroundColor = navigationItemTo.barBackgroudColor;
            navigationBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, navigationItemTo.barHeight);
        }

    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            
        } else {
            navigationBar.viewFromLeftBarButtonStack.hidden = YES;
            navigationBar.viewFromRightBarButtonStack.hidden = YES;
        }
    }];
    
    [self handleTitleLabelAnimateTransition:transitionContext to:navigationItemTo from:navigationItemFrom with:navigationBar and:duration];
    
    [self navigationAnimateTransition:transitionContext fromViewController:fromViewController toViewController:toViewController fromView:fromView toView:toView];
}

#pragma mark -- 标题动画
- (void)handleTitleLabelAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext to:(SNNavigationItem *)navigationItemTo from:(SNNavigationItem *)navigationItemFrom with:(SNNavigationBar *)navigationBar and:(NSTimeInterval)duration {
    
    navigationItemFrom.forcePrefersLargeTitles = NO;
    navigationItemTo.forcePrefersLargeTitles = NO;
    
    navigationBar.labelTitle.alpha = 0;
    navigationBar.labelFromTile.alpha = 1;
    
    navigationBar.labelFromTile.hidden = NO;
    
    navigationBar.labelTitle.layer.zPosition = 1;
    navigationBar.labelFromTile.layer.zPosition = 2;
    navigationBar.viewMaskTitleView.layer.zPosition = 0;
    if (self.reverse) { // pop
        
        if (navigationItemFrom.prefersLargeTitles) {
            if (navigationItemTo.prefersLargeTitles) {
                navigationBar.labelTitle.center = CGPointMake(16 + navigationBar.labelTitle.bounds.size.width/2, 44+52/2);
                navigationBar.labelFromTile.center = CGPointMake(16 + navigationBar.labelFromTile.bounds.size.width/2, 44+52/2);
            } else {
                navigationBar.labelFromTile.center = CGPointMake(16 + navigationBar.labelFromTile.bounds.size.width/2, 44+52/2);
                navigationBar.labelTitle.layer.zPosition = 2;
                navigationBar.labelFromTile.layer.zPosition = 0;
                navigationBar.viewMaskTitleView.layer.zPosition = 1;
            }
        } else {
            if (navigationItemTo.prefersLargeTitles) {
                navigationBar.labelTitle.center = CGPointMake(16 + navigationBar.labelTitle.bounds.size.width/2, 44/2);
            } else {
                navigationBar.labelFromTile.center = CGPointMake(SCREEN_WIDTH/2, navigationBar.labelFromTile.center.y);
            }
        }
    } else { //push
#pragma mark -- 兼容大小标题模式
        if (navigationItemFrom.prefersLargeTitles) {
            if (navigationItemTo.prefersLargeTitles) {
                navigationBar.labelTitle.center = CGPointMake(16 + navigationBar.labelTitle.bounds.size.width/2 + SCREEN_WIDTH/2, 44+52/2);
                navigationBar.labelFromTile.center = CGPointMake(16 + navigationBar.labelFromTile.bounds.size.width/2, 44+52/2);
            } else {
                navigationBar.labelTitle.center = CGPointMake(SCREEN_WIDTH/2, navigationBar.labelTitle.center.y);
                navigationBar.labelFromTile.center = CGPointMake(16 + navigationBar.labelFromTile.bounds.size.width/2, 44+52/2);
            }
        } else {
            if (navigationItemTo.prefersLargeTitles) {
                navigationBar.labelTitle.center = CGPointMake(16 + navigationBar.labelTitle.bounds.size.width/2, 44/2);
                navigationBar.labelTitle.layer.zPosition = 0;
                navigationBar.viewMaskTitleView.layer.zPosition = 1;
                navigationBar.labelFromTile.layer.zPosition = 2;
            } else {
                CGFloat moveCenterX = navigationBar.viewFromRightBarButtonStack.frame.origin.x;
                moveCenterX = moveCenterX < (SCREEN_WIDTH/2) ? SCREEN_WIDTH/2 : moveCenterX;
                navigationBar.labelTitle.center = CGPointMake(moveCenterX, navigationBar.labelTitle.center.y);
            }
        }
    }
    
    [UIView animateWithDuration:duration delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
        
        navigationBar.labelTitle.alpha = 1;
        navigationBar.labelFromTile.alpha = 0;
        
        if (self.reverse) { // pop
            
            if (navigationItemFrom.prefersLargeTitles) {
                if (navigationItemTo.prefersLargeTitles) {
                    navigationBar.labelFromTile.center = CGPointMake(16 + navigationBar.labelFromTile.bounds.size.width/2 + SCREEN_WIDTH/2, 44 + 52/2);
                } else {
                    navigationBar.labelFromTile.center = CGPointMake(16 + navigationBar.labelFromTile.bounds.size.width/2, 44/2);
                }
            } else {
                if (navigationItemTo.prefersLargeTitles) {
                    navigationBar.labelTitle.center = CGPointMake(16 + navigationBar.labelTitle.bounds.size.width/2, 44 + 52/2);
                } else {
                    CGFloat moveCenterX = SCREEN_WIDTH;
#pragma mark -- 判断动画方向
                    if (self.rectEdge == UIRectEdgeLeft) {
                        moveCenterX = navigationBar.viewRightBarButtonStack.frame.origin.x;
                        moveCenterX = moveCenterX < (SCREEN_WIDTH/2) ? SCREEN_WIDTH/2 : moveCenterX;
                    } else if (self.rectEdge == UIRectEdgeRight) {
                        moveCenterX = navigationBar.viewLeftBarButtonStack.frame.origin.x + navigationBar.viewLeftBarButtonStack.frame.size.width;
                        moveCenterX = moveCenterX > (SCREEN_WIDTH/2) ? SCREEN_WIDTH/2 : moveCenterX;
                    }
                    navigationBar.labelFromTile.center = CGPointMake(moveCenterX, navigationBar.labelFromTile.center.y);
                }
            }
        } else { // push
            
            if (navigationItemFrom.prefersLargeTitles) {
                if (navigationItemTo.prefersLargeTitles) {
                    navigationBar.labelTitle.center = CGPointMake(16 + navigationBar.labelTitle.bounds.size.width/2, 44+52/2);
                } else {
                    navigationBar.labelFromTile.center = CGPointMake(16 + navigationBar.labelFromTile.bounds.size.width/2, 44/2);
                }
            } else {
                if (navigationItemTo.prefersLargeTitles) {
                    navigationBar.labelTitle.center = CGPointMake(16 + navigationBar.labelTitle.bounds.size.width/2, 44 + 52/2);
                } else {
                    navigationBar.labelTitle.center = CGPointMake(SCREEN_WIDTH/2, navigationBar.labelTitle.center.y);
                }
            }
        }
        
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            
        } else {
            navigationBar.labelFromTile.hidden = YES;
            navigationItemTo.centerLabelTitle = navigationBar.labelTitle.center;
        }
    }];
}

#pragma mark -- API
- (void)navigationAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController fromView:(UIView *)fromView toView:(UIView *)toView {
    
}

@end
