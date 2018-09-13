//
//  SNNavigationPopRightTransitionAnimation.m
//  SNNavigationController
//
//  Created by snlo on 2018/8/31.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "SNNavigationPopRightTransitionAnimation.h"

@implementation SNNavigationPopRightTransitionAnimation

- (void)navigationAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController fromView:(UIView *)fromView toView:(UIView *)toView {
    // Add the toView to the container
    UIView* containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    [containerView sendSubviewToBack:toView];
    
    toView.frame = CGRectMake(SCREEN_WIDTH/2, toView.frame.origin.y, toView.frame.size.width, toView.frame.size.height);
    
    
    UIView * maskView = [[UIView alloc] init];
	maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
	maskView.alpha = 1.0;
    maskView.frame = toView.bounds;
    [toView addSubview:maskView];
    
	UIView * viewShadown = [[UIView alloc] init];
	viewShadown.backgroundColor = [UIColor redColor];
	viewShadown.frame = CGRectMake(SCREEN_WIDTH/2-10, 0, 10, SCREEN_HEIGHT);
	viewShadown.layer.shadowColor = [UIColor blackColor].CGColor;
	viewShadown.layer.shadowOpacity = 0.5f;
	viewShadown.layer.shadowOffset = CGSizeMake(-3, 0);
	viewShadown.layer.shadowRadius = 8;
	[maskView addSubview:viewShadown];
    
    // animate
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
        
        fromView.frame = CGRectMake(-SCREEN_WIDTH, fromView.frame.origin.y, fromView.frame.size.width, fromView.frame.size.height);
        toView.frame = CGRectMake(0, toView.frame.origin.y, toView.frame.size.width, toView.frame.size.height);
        maskView.alpha = 0.0;
		viewShadown.frame = CGRectMake(-10, 0, 10, SCREEN_HEIGHT);
        
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            toView.frame = CGRectMake(0, toView.frame.origin.y, toView.frame.size.width, toView.frame.size.height);
            fromView.frame = CGRectMake(0, fromView.frame.origin.y, fromView.frame.size.width, fromView.frame.size.height);
        } else {
            // reset from- view to its original state
            [fromView removeFromSuperview];
            fromView.frame = CGRectMake(-SCREEN_WIDTH, fromView.frame.origin.y, fromView.frame.size.width, fromView.frame.size.height);
            toView.frame = CGRectMake(0, toView.frame.origin.y, toView.frame.size.width, toView.frame.size.height);
        }
        [maskView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
