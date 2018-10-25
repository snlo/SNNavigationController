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
    
    [self handleTitleLabelAnimateTransition:transitionContext to:navigationItemTo from:navigationItemFrom with:navigationBar and:duration and:toViewController and:fromViewController];
    
    toViewController.sn_navigationController.sn_navigationDelegate.percentDrivenTransition.interactionInProgress = YES;
    fromViewController.sn_navigationController.sn_navigationDelegate.percentDrivenTransition.interactionInProgress = YES;
	[UIView animateKeyframesWithDuration:duration delay:0.0 options:0 animations:^{
		
		[UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
			// rotate the from view
			navigationBar.viewFromLeftBarButtonStack.alpha = 0.5;
			navigationBar.viewFromRightBarButtonStack.alpha = 0.5;
		}];
		[UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
			// rotate the to view
			navigationBar.viewLeftBarButtonStack.alpha = 1;
			navigationBar.viewRightBarButtonStack.alpha = 1;

            navigationBar.viewFromRightBarButtonStack.alpha = 0.0;
            navigationBar.viewFromLeftBarButtonStack.alpha = 0.0;

		}];
		
		CGFloat leftWidth = navigationBar.viewLeftBarButtonStack.bounds.size.width;
		CGFloat rightWidth = navigationBar.viewRightBarButtonStack.bounds.size.width;
        if (leftWidth < rightWidth) {
            leftWidth = rightWidth;
        }
		navigationBar.viewTitle.frame = CGRectMake(ksMargin+leftWidth, navigationBar.viewTitle.frame.origin.y, ks_SCREEN_WIDTH-ksMargin*2-leftWidth-leftWidth, navigationBar.viewTitle.frame.size.height);
		
        if (self.reverse) { // pop
            navigationBar.backgroundColor = navigationItemTo.barBackgroudColor;
            navigationBar.frame = CGRectMake(0, 0, ks_SCREEN_WIDTH, navigationItemTo.barHeight);
            
        } else { // push
            navigationBar.backgroundColor = navigationItemTo.barBackgroudColor;
            navigationBar.frame = CGRectMake(0, 0, ks_SCREEN_WIDTH, navigationItemTo.barHeight);
        }

    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            
        } else {
            navigationBar.viewFromLeftBarButtonStack.hidden = YES;
            navigationBar.viewFromRightBarButtonStack.hidden = YES;
        }
        toViewController.sn_navigationController.sn_navigationDelegate.percentDrivenTransition.interactionInProgress = NO;
        fromViewController.sn_navigationController.sn_navigationDelegate.percentDrivenTransition.interactionInProgress = NO;
    }];
    
    
    
    [self navigationAnimateTransition:transitionContext fromViewController:fromViewController toViewController:toViewController fromView:fromView toView:toView];
}

#pragma mark -- 标题动画
- (void)handleTitleLabelAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext to:(SNNavigationItem *)navigationItemTo from:(SNNavigationItem *)navigationItemFrom with:(SNNavigationBar *)navigationBar and:(NSTimeInterval)duration and:(UIViewController *)toViewController and:(UIViewController *)fromViewController {
    
    navigationBar.labelTitle.text = toViewController.title;
    navigationBar.labelFromTile.text = fromViewController.title;
	
	navigationBar.labelLargeTitle.text = toViewController.title;
	navigationBar.labelLargeFromTitle.text = fromViewController.title;
	
    
    navigationItemFrom.forcePrefersLargeTitles = NO;
    navigationItemTo.forcePrefersLargeTitles = NO;
    
    
	navigationBar.labelLargeTitle.alpha = 0;
	navigationBar.labelLargeFromTitle.alpha = 1;
	navigationBar.labelLargeFromTitle.hidden = NO;
    
    navigationBar.labelTitle.alpha = 0;
    navigationBar.labelFromTile.alpha = 1;
    navigationBar.labelFromTile.hidden = NO;
	
	CGFloat centerX = ks_SCREEN_WIDTH/2;
	CGFloat centerY = (ksIs_iPhoneX?44:20) + 22;
    
    if (self.reverse) { // pop
        
        navigationBar.labelFromTile.center = CGPointMake(centerX, centerY);
        navigationBar.labelLargeFromTitle.frame = CGRectMake(ksMargin , 0, ks_SCREEN_WIDTH-ksMargin*2, ksLargeHeight);
        navigationBar.labelLargeTitle.frame = CGRectMake(ksMargin, 0, ks_SCREEN_WIDTH-ksMargin*2, ksLargeHeight);
        
        if (navigationItemFrom.prefersLargeTitles == navigationItemTo.prefersLargeTitles) {
            navigationBar.labelFromTile.hidden = navigationItemFrom.prefersLargeTitles;
            navigationBar.labelTitle.hidden = navigationItemFrom.prefersLargeTitles;
        } else {
            navigationBar.labelFromTile.hidden = navigationItemFrom.prefersLargeTitles;
            navigationBar.labelTitle.hidden = navigationItemTo.prefersLargeTitles;
            navigationBar.labelLargeFromTitle.hidden = !navigationItemFrom.prefersLargeTitles;
        }
        
    } else { //push
		CGFloat moveCenterX = navigationBar.viewFromRightBarButtonStack.frame.origin.x;
		moveCenterX = moveCenterX < centerX ? centerX : moveCenterX;
		navigationBar.labelTitle.center = CGPointMake(moveCenterX, centerY);
        navigationBar.labelFromTile.center = CGPointMake(centerX, centerY);
        
        navigationBar.labelLargeTitle.frame = CGRectMake(ksMargin + ks_SCREEN_WIDTH/2, 0, ks_SCREEN_WIDTH-ksMargin*2, ksLargeHeight);
        navigationBar.labelLargeFromTitle.frame = CGRectMake(ksMargin, 0, ks_SCREEN_WIDTH-ksMargin*2, ksLargeHeight);
        
        
        if (navigationItemTo.prefersLargeTitles == navigationItemFrom.prefersLargeTitles) {
            navigationBar.labelFromTile.hidden = navigationItemTo.prefersLargeTitles;
            navigationBar.labelTitle.hidden = navigationItemTo.prefersLargeTitles;
        } else {
            navigationBar.labelFromTile.hidden = navigationItemFrom.prefersLargeTitles;
            navigationBar.labelTitle.hidden = navigationItemTo.prefersLargeTitles;
            navigationBar.labelLargeFromTitle.hidden = !navigationItemFrom.prefersLargeTitles;
        }
    }
	navigationBar.viewTitle.alpha = 1;
	navigationBar.viewSearch.alpha = navigationItemFrom.showSearchBar? 0 : 1;
    if (navigationItemFrom.showSearchBar) {
        navigationBar.viewSearch.alpha = 1;
        if (!navigationItemFrom.prefersLargeTitles) {
            navigationBar.labelLargeFromTitle.alpha = 0;
            navigationBar.labelLargeTitle.alpha = 0;
        }
    } else {
        navigationBar.viewSearch.alpha = 0;
        if (!navigationItemTo.showSearchBar) {
//            navigationBar.viewSearch.alpha = 1;
        }
        if (navigationItemTo.showSearchBar && !navigationItemFrom.prefersLargeTitles) {
            navigationBar.labelLargeFromTitle.alpha = 0;
            navigationBar.labelLargeTitle.alpha = 0;
        }
    }
    
	[UIView animateKeyframesWithDuration:duration delay:0.0 options:0 animations:^{

		[UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
			// rotate the from view
			navigationBar.viewTitle.alpha = 0;
            navigationBar.labelTitle.alpha = 0;
            navigationBar.labelFromTile.alpha = 0;
			navigationBar.labelLargeTitle.alpha = 0;
			navigationBar.labelLargeFromTitle.alpha = 0;
            navigationBar.viewSearch.alpha = 0;
            if (!navigationItemTo.showSearchBar) {
                navigationBar.viewSearch.alpha = 1;
            }
            navigationBar.viewSearch.alpha = navigationItemTo.showSearchBar? 1 : 0;
		}];
		[UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
			// rotate the to view
			navigationBar.viewTitle.alpha = 1;
            navigationBar.labelTitle.alpha = 1;
			navigationBar.labelLargeTitle.alpha = 1;
            if (navigationItemTo.showSearchBar) {
                navigationBar.viewSearch.alpha = 1;
            }
            if (!navigationItemTo.prefersLargeTitles) {
                navigationBar.labelLargeTitle.alpha = 0;
            }
            
		}];
	} completion:^(BOOL finished) {
		[transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            if (self.reverse) {
                if (navigationItemFrom.showSearchBar || navigationItemFrom.showSearchBarMark) {
                    navigationBar.viewSearch.alpha = 1;
                }
            }
        }
	}];
	
    CGRect labelTitleFrame = CGRectMake(navigationBar.labelTitle.frame.origin.x, navigationBar.labelTitle.frame.origin.y, navigationBar.labelTitle.frame.size.width, navigationBar.labelTitle.frame.size.height);
    
	[UIView animateKeyframesWithDuration:duration delay:0.0 options:0 animations:^{
        
        CGFloat leftWidth = navigationBar.viewLeftBarButtonStack.bounds.size.width;
        CGFloat rightWidth = navigationBar.viewRightBarButtonStack.bounds.size.width;
        if (leftWidth < rightWidth) {
            leftWidth = rightWidth;
        }
        navigationBar.labelTitle.frame = CGRectMake(navigationBar.labelTitle.frame.origin.x, navigationBar.labelTitle.frame.origin.y, ks_SCREEN_WIDTH-ksMargin*2-leftWidth*2, navigationBar.labelTitle.frame.size.height);
        navigationBar.labelTitle.center = CGPointMake(centerX, centerY);

        if (self.reverse) { // pop
			CGFloat moveCenterX = ks_SCREEN_WIDTH-ksMargin;
#pragma mark -- 判断动画方向
			if (self.rectEdge == UIRectEdgeLeft) {
				moveCenterX = navigationBar.viewRightBarButtonStack.frame.origin.x;
				moveCenterX = moveCenterX < centerX ? centerX : moveCenterX;
			} else if (self.rectEdge == UIRectEdgeRight) {
				moveCenterX = navigationBar.viewLeftBarButtonStack.frame.origin.x + navigationBar.viewLeftBarButtonStack.frame.size.width;
				moveCenterX = moveCenterX > centerX ? centerX : moveCenterX;
			}
            
			navigationBar.labelFromTile.center = CGPointMake(moveCenterX, centerY);
            
            navigationBar.labelLargeFromTitle.frame = CGRectMake(ksMargin + ks_SCREEN_WIDTH/2, 0, ks_SCREEN_WIDTH-ksMargin*2, ksLargeHeight);
            
            
        } else { // push
            
            navigationBar.labelFromTile.center = CGPointMake(centerX, centerY);
            
            navigationBar.labelLargeTitle.frame = CGRectMake(ksMargin, 0, ks_SCREEN_WIDTH-2*ksMargin, ksLargeHeight);
            
        }
        
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            navigationBar.labelTitle.frame = labelTitleFrame;
        } else {
            navigationBar.labelFromTile.hidden = YES;
			navigationBar.labelLargeFromTitle.hidden = YES;
            if (self.reverse && !navigationItemTo.prefersLargeTitles) {
                if (navigationItemTo.showSearchBarMark) {
                    navigationBar.viewSearch.alpha = 1;
                }
            }
        }
    }];
}
- (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber {
	float diff = bigNumber - smallNumber;
	return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}
#pragma mark -- API
- (void)navigationAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController fromView:(UIView *)fromView toView:(UIView *)toView {
    
}

@end
