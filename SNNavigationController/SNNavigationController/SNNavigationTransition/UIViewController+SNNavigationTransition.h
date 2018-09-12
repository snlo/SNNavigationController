//
//  UIViewController+SNNavigationTransition.h
//  SNNavigationController
//
//  Created by snlo on 2018/8/30.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SNNavigationItem.h"

@interface UIViewController (SNNavigationTransition)

/**
 包含了tabBarController.navigationController
 */
@property (nonatomic, strong) UINavigationController * sn_navigationController;

/**
 手势，默认只开启左边缘手势
 */
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer * sn_leftScreenEdgePanGesture;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer * sn_rightScreenEdgePanGesture;
@property (nonatomic, strong) UIPanGestureRecognizer * sn_pullScreenBackPanGesture;

/**
 导航栏相关设置
 */
@property (nonatomic, readonly, strong) SNNavigationItem * sn_navigationItem;

@end
