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

//手势
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer * sn_leftScreenEdgePanGesture;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer * sn_rightScreenEdgePanGesture;
@property (nonatomic, strong) UIPanGestureRecognizer * sn_pullScreenBackPanGesture;

//导航栏背景色，默认白色
@property (nonatomic, strong) UIColor * sn_navigationBarBackgroudColor;
//导航栏高度，默认
@property (nonatomic, assign) CGFloat sn_navigationBarHeight;
//导航栏大标题，默认不是
@property (nonatomic, assign) BOOL sn_prefersLargeTitles;

@end
