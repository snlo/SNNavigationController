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
#import "SNNavigationPopLeftTransitionAnimation.h"
#import "SNNavigationPopRightTransitionAnimation.h"


@interface SNNavigationTransitionDelegate () {
    
    UIViewController *  _viewController;
    UIRectEdge          _gestureEdge;
}

@property (nonatomic, strong) SNNavigationPushTransitionAnimation * pushAnimation;
@property (nonatomic, strong) SNNavigationPopLeftTransitionAnimation *  popLeftAnimation;
@property (nonatomic, strong) SNNavigationPopRightTransitionAnimation *  popRightAnimation;


@end

@implementation SNNavigationTransitionDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPop) {
        switch (_gestureEdge) {
            case UIRectEdgeLeft: {
                _gestureEdge = UIRectEdgeNone;
                self.popLeftAnimation.reverse = YES;
                return self.popLeftAnimation;
            } break;
            case UIRectEdgeRight: {
                _gestureEdge = UIRectEdgeNone;
                self.popRightAnimation.reverse = YES;
                return self.popRightAnimation;
            } break;
            default: {
                self.popLeftAnimation.reverse = YES;
                return self.popLeftAnimation;
            } break;
        }
    }
    if (operation == UINavigationControllerOperationPush) {
        
        [toVC.view addGestureRecognizer:toVC.sn_leftScreenEdgePanGesture];
        [toVC.view addGestureRecognizer:toVC.sn_rightScreenEdgePanGesture];
        _viewController = toVC;
        
        [toVC.sn_leftScreenEdgePanGesture addTarget:self action:@selector(handleGesture:)];
        [toVC.sn_rightScreenEdgePanGesture addTarget:self action:@selector(handleGesture:)];
        self.pushAnimation.reverse = NO;
        return self.pushAnimation;
    }
    return nil;
}
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    
    if([animationController isKindOfClass:[SNNavigationPopLeftTransitionAnimation class]] ||
       [animationController isKindOfClass:[SNNavigationPopRightTransitionAnimation class]]){
        if (self.percentDrivenTransition) {
            return self.percentDrivenTransition;
        }
        return nil;
    } else {
        return nil;
    }
}

- (void)handleGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
    _gestureEdge = gesture.edges;
    CGFloat progress = [gesture translationInView:_viewController.view].x / _viewController.view.bounds.size.width / 2;
    [self updateState:gesture.state progress:fabs(progress) forViewController:_viewController];
}
- (void)updateState:(UIGestureRecognizerState)state progress:(CGFloat)progress forViewController:(UIViewController *)viewController {
    switch (state) {
        case UIGestureRecognizerStateBegan: {
            self.percentDrivenTransition = [[SNTransitionInteractionController alloc] init];
            self.percentDrivenTransition.interactionInProgress = YES;
            [viewController.navigationController popViewControllerAnimated:YES];
        } break;
        case UIGestureRecognizerStateChanged: {
            self.percentDrivenTransition.interactionInProgress = YES;
            [self.percentDrivenTransition updateInteractiveTransition:progress];
        } break;
        case UIGestureRecognizerStateCancelled: case UIGestureRecognizerStateEnded: {
            self.percentDrivenTransition.interactionInProgress = NO;
            if(progress > 0.2){
                [self.percentDrivenTransition finishInteractiveTransition];
            }else{
                [self.percentDrivenTransition cancelInteractiveTransition];
            }
            self.percentDrivenTransition = nil;
        } break;
        default: {
            [self.percentDrivenTransition cancelInteractiveTransition];
            self.percentDrivenTransition = nil;
        } break;
    }
}

#pragma mark -- getter / setter

- (SNNavigationPushTransitionAnimation *)pushAnimation {
    if (!_pushAnimation) {
        _pushAnimation = [[SNNavigationPushTransitionAnimation alloc] init];
    } return _pushAnimation;
}
- (SNNavigationPopLeftTransitionAnimation *)popLeftAnimation {
    if (!_popLeftAnimation) {
        _popLeftAnimation = [[SNNavigationPopLeftTransitionAnimation alloc] init];
    } return _popLeftAnimation;
}
- (SNNavigationPopRightTransitionAnimation *)popRightAnimation {
    if (!_popRightAnimation) {
        _popRightAnimation = [[SNNavigationPopRightTransitionAnimation alloc] init];
    } return _popRightAnimation;
}

@end
