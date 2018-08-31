//
//  SNNavigationPopLeftTransitionAnimation.m
//  SNNavigationController
//
//  Created by snlo on 2018/8/31.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "SNNavigationPopLeftTransitionAnimation.h"

@implementation SNNavigationPopLeftTransitionAnimation

- (void)navigationAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController fromView:(UIView *)fromView toView:(UIView *)toView {
    // Add the toView to the container
    UIView* containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    [containerView sendSubviewToBack:toView];
    
    toView.frame = CGRectMake(-SCREEN_WIDTH/2, toView.frame.origin.y, toView.frame.size.width, toView.frame.size.height);
    
    
    UIView * maskView = [[UIView alloc] init];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.1;
    maskView.frame = toView.bounds;
    [toView addSubview:maskView];
    

    fromView.layer.shadowColor = [UIColor blackColor].CGColor;
    fromView.layer.shadowOpacity = 0.2f;
    fromView.layer.shadowOffset = CGSizeMake(3, 0);
    fromView.layer.shadowRadius = 8;
    
    
    // animate
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        fromView.frame = CGRectMake(SCREEN_WIDTH, fromView.frame.origin.y, fromView.frame.size.width, fromView.frame.size.height);
        toView.frame = CGRectMake(0, toView.frame.origin.y, toView.frame.size.width, toView.frame.size.height);
        maskView.alpha = 0;
        
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            toView.frame = CGRectMake(0, toView.frame.origin.y, toView.frame.size.width, toView.frame.size.height);
            fromView.frame = CGRectMake(0, fromView.frame.origin.y, fromView.frame.size.width, fromView.frame.size.height);
        } else {
            // reset from- view to its original state
            [fromView removeFromSuperview];
            fromView.frame = CGRectMake(SCREEN_WIDTH, fromView.frame.origin.y, fromView.frame.size.width, fromView.frame.size.height);
            toView.frame = CGRectMake(0, toView.frame.origin.y, toView.frame.size.width, toView.frame.size.height);
        }
        [maskView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
