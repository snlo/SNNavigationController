//
//  SNNavigationTransitionDelegate.h
//  SNNavigationController
//
//  Created by snlo on 2018/8/30.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import "SNTransitionInteractionController.h"


@interface SNNavigationTransitionDelegate : NSObject <UINavigationControllerDelegate>

/**
 交互驱动
 */
@property (nonatomic, strong) SNTransitionInteractionController * percentDrivenTransition;

/**
 更新交互驱动进度

 @param state 手势交互状态
 @param progress 进度
 @param viewController 承载手势的视图控制器
 */
- (void)updateState:(UIGestureRecognizerState)state progress:(CGFloat)progress forViewController:(UIViewController *)viewController;

@end
