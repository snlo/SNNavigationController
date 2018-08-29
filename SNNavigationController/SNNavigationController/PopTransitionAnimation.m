//
//  PopTransitionAnimation.m
//  CustomNavTransition
//
//  Created by Baoqin Huang on 2017/6/26.
//  Copyright © 2017年 Baoqin Huang. All rights reserved.
//

#import "PopTransitionAnimation.h"

@implementation PopTransitionAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.6;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [transitionContext.containerView addSubview:toViewController.view];
    toViewController.view.alpha = 0;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         fromViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
                         toViewController.view.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         fromViewController.view.transform = CGAffineTransformIdentity;
                         [transitionContext completeTransition:YES];
                     }];
}

@end
