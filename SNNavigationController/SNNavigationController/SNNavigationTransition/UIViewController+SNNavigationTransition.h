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
 展示自定义导航栏，这类导航栏在外部实现
 */
@property (nonatomic, assign) BOOL isShowCustomNavigationBar;

/**
 展示‘sn_navigationBar’导航栏
 */
@property (nonatomic, assign) BOOL isShowSNNavigationBar;
/**
 展示系统导航栏
 */
@property (nonatomic, assign) BOOL isShowSystemNavigationBar;

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

/**
 先设置大小标题如果需要

 @param height 搜索栏高度
 @return 搜索栏视图
 */
- (UIView *)setSearchBarWith:(CGFloat)height __attribute__((deprecated("waiting for update.")));

@end
