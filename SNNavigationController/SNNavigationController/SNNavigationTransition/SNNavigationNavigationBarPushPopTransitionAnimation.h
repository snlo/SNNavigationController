//
//  SNNavigationNavigationBarPushPopTransitionAnimation.h
//  SNNavigationController
//
//  Created by snlo on 2018/8/31.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "SNTransitionAnimationController.h"

@interface SNNavigationNavigationBarPushPopTransitionAnimation : SNTransitionAnimationController <UIViewControllerAnimatedTransitioning>

/**
 用于继承者们调用
 */
- (void)navigationAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController fromView:(UIView *)fromView toView:(UIView *)toView;

@end
