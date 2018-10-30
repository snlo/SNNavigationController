//
//  UINavigationController+SNNavigationTransition.h
//  SNNavigationController
//
//  Created by snlo on 2018/8/30.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SNNavigationBar.h"
#import "SNNavigationTransitionDelegate.h"

@interface UINavigationController (SNNavigationTransition)

/**
 导航栏
 */
@property (nonatomic, strong) SNNavigationBar * sn_navigationBar;

/**
 导航视图控制器间的转场代理
 */
@property (nonatomic, weak) SNNavigationTransitionDelegate * sn_navigationDelegate;

/**
 是否为‘SNNavigationBar’默认为‘NO’
 */
@property (nonatomic, assign) BOOL isSNNavigationBar;

@end
