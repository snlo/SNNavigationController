//
//  PushTransitionAnimation.m
//  CustomNavTransition
//
//  Created by Baoqin Huang on 2017/6/26.
//  Copyright © 2017年 Baoqin Huang. All rights reserved.
//

#import "PushTransitionAnimation.h"

@implementation PushTransitionAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.6;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [[transitionContext containerView] addSubview:toViewController.view];
    fromViewController.view.layer.anchorPoint = CGPointMake(0, 0);
    fromViewController.view.layer.position = CGPointMake(0, 0);
    toViewController.view.alpha = 0;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         fromViewController.view.transform = CGAffineTransformMakeRotation(- M_PI / 2);
                         toViewController.view.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                         [fromViewController.view setTransform:CGAffineTransformIdentity];
                         [transitionContext completeTransition:YES];
                     }];
}

@end
