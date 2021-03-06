//
//  SNNavigationPushTransitionAnimation.m
//  SNNavigationController
//
//  Created by snlo on 2018/8/30.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "SNNavigationPushTransitionAnimation.h"

#import "SNNavigationControllerTool.h"

@implementation SNNavigationPushTransitionAnimation

- (void)navigationAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController fromView:(UIView *)fromView toView:(UIView *)toView {
	
    UIView* containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    [containerView bringSubviewToFront:toView];
    
    toView.frame = CGRectMake(ks_SCREEN_WIDTH, toView.frame.origin.y, toView.frame.size.width, toView.frame.size.height);
    
    
    UIView * maskView = [[UIView alloc] init];
    maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    maskView.frame = fromView.bounds;
    maskView.alpha = 0.0;
    [fromView addSubview:maskView];

    
	UIView * viewShadown = [[UIView alloc] init];
	viewShadown.backgroundColor = [UIColor whiteColor];
	viewShadown.frame = CGRectMake(ks_SCREEN_WIDTH, 0, 10, ks_SCREEN_HEIGHT);
	viewShadown.layer.shadowColor = [UIColor blackColor].CGColor;
	viewShadown.layer.shadowOpacity = 0.5f;
	viewShadown.layer.shadowOffset = CGSizeMake(3, 0);
	viewShadown.layer.shadowRadius = 8;
	[maskView addSubview:viewShadown];
	
    
    // animate
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
	[UIView animateKeyframesWithDuration:duration
								   delay:0.0
								 options:0
							  animations:^{
        
        fromView.frame = CGRectMake(-ks_SCREEN_WIDTH/2, fromView.frame.origin.y, fromView.frame.size.width, fromView.frame.size.height);
        toView.frame = CGRectMake(0, toView.frame.origin.y, toView.frame.size.width, toView.frame.size.height);
        maskView.alpha = 1.0;
		viewShadown.frame = CGRectMake(ks_SCREEN_WIDTH/2, 0, 10, ks_SCREEN_HEIGHT);
        
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            toView.frame = CGRectMake(0, toView.frame.origin.y, toView.frame.size.width, toView.frame.size.height);
            fromView.frame = CGRectMake(0, fromView.frame.origin.y, fromView.frame.size.width, fromView.frame.size.height);
        } else {
            // reset from- view to its original state
            [fromView removeFromSuperview];
            fromView.frame = CGRectMake(-ks_SCREEN_WIDTH/2, fromView.frame.origin.y, fromView.frame.size.width, fromView.frame.size.height);
            toView.frame = CGRectMake(0, toView.frame.origin.y, toView.frame.size.width, toView.frame.size.height);
        }
        [maskView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];

}


@end
