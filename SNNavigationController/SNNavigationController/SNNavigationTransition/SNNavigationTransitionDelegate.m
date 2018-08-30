//
//  SNNavigationTransitionDelegate.m
//  SNNavigationController
//
//  Created by snlo on 2018/8/30.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "SNNavigationTransitionDelegate.h"

//animations
#import "SNNavigationPushTransitionAnimation.h"
#import "SNNavigationPopTransitionAnimation.h"

@interface SNNavigationTransitionDelegate ()

@property (nonatomic, strong) SNNavigationPushTransitionAnimation * pushAnimation;
@property (nonatomic, strong) SNNavigationPopTransitionAnimation *  popAnimation;

@end

@implementation SNNavigationTransitionDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
        return [[SNNavigationPopTransitionAnimation alloc] init];
    }
    if (operation == UINavigationControllerOperationPush) {
        return [[SNNavigationPushTransitionAnimation alloc] init];
    }
    return nil;
}
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{

    if([animationController isKindOfClass:[SNNavigationPopTransitionAnimation class]]){
        return self.percentDrivenTransition;
    } else {
        return nil;
    }
}

- (void)updateState:(UIGestureRecognizerState)state progress:(CGFloat)progress forViewController:(UIViewController *)viewController {
    switch (state) {
        case UIGestureRecognizerStateBegan: {
            self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
            [viewController.navigationController popViewControllerAnimated:YES];
        } break;
        case UIGestureRecognizerStateChanged: {
            [self.percentDrivenTransition updateInteractiveTransition:progress];
        } break;
        case UIGestureRecognizerStateCancelled: case UIGestureRecognizerStateEnded: {
            if(progress > 0.2){
                [self.percentDrivenTransition finishInteractiveTransition];
            }else{
                [self.percentDrivenTransition cancelInteractiveTransition];
            }
            self.percentDrivenTransition = nil;
        } break;
        default: {

        } break;
    }
}

#pragma mark -- getter / setter

- (SNNavigationPushTransitionAnimation *)pushAnimation {
    if (!_pushAnimation) {
        _pushAnimation = [[SNNavigationPushTransitionAnimation alloc] init];
    } return _pushAnimation;
}
- (SNNavigationPopTransitionAnimation *)popAnimation {
    if (!_popAnimation) {
        _popAnimation = [[SNNavigationPopTransitionAnimation alloc] init];
    } return _popAnimation;
}
- (UIPercentDrivenInteractiveTransition *)percentDrivenTransition {
    if (!_percentDrivenTransition) {
        _percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
    } return _percentDrivenTransition;
}

@end
