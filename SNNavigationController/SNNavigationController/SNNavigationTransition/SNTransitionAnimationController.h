//
//  SNTransitionAnimationController.h
//  SNNavigationController
//
//  Created by snlo on 2018/8/30.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface SNTransitionAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

/**
 动画的逆转（push、pop）
 */
@property (nonatomic, assign) BOOL reverse;

/**
 动画方向
 */
@property (nonatomic, assign) UIRectEdge rectEdge;

/**
 动画时间
 */
@property (nonatomic, assign) NSTimeInterval duration;

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController fromView:(UIView *)fromView toView:(UIView *)toView;

@end
