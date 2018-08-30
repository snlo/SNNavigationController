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
 启动屏幕左边缘拖拽手势

 @return 屏幕边缘手势识别器，可用于区分手势冲突
 */
- (UIScreenEdgePanGestureRecognizer *)startLeftScreenEdgePanGesture;

/**
 启动屏幕右边缘拖拽手势

 @return 屏幕边缘手势识别器，可用于区分手势冲突
 */
- (UIScreenEdgePanGestureRecognizer *)startRightScreenEdgePanGesture;

@end
