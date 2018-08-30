//
//  SNNavigationPushTransitionAnimation.m
//  SNNavigationController
//
//  Created by snlo on 2018/8/30.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "SNNavigationPushTransitionAnimation.h"

@implementation SNNavigationPushTransitionAnimation

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController fromView:(UIView *)fromView toView:(UIView *)toView {
    // Add the toView to the container
    UIView* containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    toView.frame = CGRectMake(SCREEN_WIDTH, toView.frame.origin.y, toView.frame.size.width, toView.frame.size.height);
    
    UIView * maskView = [[UIView alloc] init];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.frame = fromView.bounds;
    maskView.alpha = 0.0;
    [fromView addSubview:maskView];
    
    
    [containerView bringSubviewToFront:toView];
    
    
    toView.layer.shadowColor = [UIColor blackColor].CGColor;
    toView.layer.shadowOpacity = 0.2f;
    toView.layer.shadowOffset = CGSizeMake(3, 0);
    toView.layer.shadowRadius = 8;
    
    // animate
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        fromView.frame = CGRectMake(-SCREEN_WIDTH/2, fromView.frame.origin.y, fromView.frame.size.width, fromView.frame.size.height);
        toView.frame = CGRectMake(0, toView.frame.origin.y, toView.frame.size.width, toView.frame.size.height);
        maskView.alpha = 0.1;
        
        toViewController.navigationController.sn_navigationBar.backgroundColor = [UIColor blueColor];
        toViewController.navigationController.sn_navigationBar.alpha = 1;
        toViewController.navigationController.sn_navigationBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 128);
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            toView.frame = CGRectMake(0, toView.frame.origin.y, toView.frame.size.width, toView.frame.size.height);
            fromView.frame = CGRectMake(0, fromView.frame.origin.y, fromView.frame.size.width, fromView.frame.size.height);
        } else {
            // reset from- view to its original state
            [fromView removeFromSuperview];
            fromView.frame = CGRectMake(-SCREEN_WIDTH/2, fromView.frame.origin.y, fromView.frame.size.width, fromView.frame.size.height);
            toView.frame = CGRectMake(0, toView.frame.origin.y, toView.frame.size.width, toView.frame.size.height);
        }
        [maskView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}


@end
