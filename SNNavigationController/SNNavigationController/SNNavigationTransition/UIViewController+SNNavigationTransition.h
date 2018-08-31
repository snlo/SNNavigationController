//
//  UIViewController+SNNavigationTransition.h
//  SNNavigationController
//
//  Created by snlo on 2018/8/30.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SNNavigationTransition)

/**
 包含了tabBarController.navigationController
 */
@property (nonatomic, strong) UINavigationController * sn_navigationController;

@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer * sn_leftScreenEdgePanGesture;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer * sn_rightScreenEdgePanGesture;

@end
