//
//  SNAnimationController.h
//  SNNavigationController
//
//  Created by snlo on 2018/8/29.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SNAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

/**
 The direction of the animation.
 */
@property (nonatomic, assign) BOOL reverse;

/**
 The animation duration.
 */
@property (nonatomic, assign) NSTimeInterval duration;

@end
