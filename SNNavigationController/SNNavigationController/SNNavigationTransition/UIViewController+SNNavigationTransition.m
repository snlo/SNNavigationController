//
//  UIViewController+SNNavigationTransition.m
//  SNNavigationController
//
//  Created by snlo on 2018/8/30.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "UIViewController+SNNavigationTransition.h"

#import <objc/runtime.h>

#import "SNTransitionInteractionController.h"

@interface UIViewController ()

@property (nonatomic, weak) SNNavigationTransitionDelegate * sn_navigationDelegate;

@end

@implementation UIViewController (SNNavigationTransition)

- (UIScreenEdgePanGestureRecognizer *)startRightScreenEdgePanGesture {
    
    self.navigationController.delegate = self.sn_navigationDelegate;
    
    UIScreenEdgePanGestureRecognizer * rightScreenEdgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightScreenEdgePanGesture:)];
    
    rightScreenEdgePan.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:rightScreenEdgePan];
    
    return rightScreenEdgePan;
}

- (UIScreenEdgePanGestureRecognizer *)startLeftScreenEdgePanGesture {
    
    self.navigationController.delegate = self.sn_navigationDelegate;
    UIScreenEdgePanGestureRecognizer * leftScreenEdgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftScreenEdgePanGesture:)];
    
    leftScreenEdgePan.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:leftScreenEdgePan];
    
    return leftScreenEdgePan;
}
#pragma mark -- action
- (void)handleRightScreenEdgePanGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
    CGFloat progress = self.view.bounds.size.width / [gesture translationInView:self.view].x / 2;
    [self.navigationController.sn_navigationDelegate updateState:gesture.state progress:progress forViewController:self];
}

- (void)handleLeftScreenEdgePanGesture:(UIScreenEdgePanGestureRecognizer *)gesture {

    CGFloat progress = [gesture translationInView:self.view].x / self.view.bounds.size.width / 2;
    [self.navigationController.sn_navigationDelegate updateState:gesture.state progress:progress forViewController:self];
}

#pragma mark -- UINavigationControllerDelegate

#pragma mark -- getter / setter

- (void)setSn_navigationDelegate:(SNNavigationTransitionDelegate *)sn_navigationDelegate {
    objc_setAssociatedObject(self, @selector(sn_navigationDelegate), sn_navigationDelegate, OBJC_ASSOCIATION_RETAIN);
}
- (SNNavigationTransitionDelegate *)sn_navigationDelegate {
    SNNavigationTransitionDelegate * delegate = objc_getAssociatedObject(self, _cmd);
    if (!delegate) {
        delegate = [[SNNavigationTransitionDelegate alloc] init];
        objc_setAssociatedObject(self, @selector(sn_navigationDelegate), delegate, OBJC_ASSOCIATION_RETAIN);
    } return delegate;
}

@end
