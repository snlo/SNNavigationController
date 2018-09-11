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

@end

@implementation UIViewController (SNNavigationTransition)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        replaceMethod(self, @selector(viewWillAppear:), self, @selector(sn_viewWillAppear:));
        replaceMethod(self, @selector(viewDidAppear:), self, @selector(sn_viewDidAppear:));
        replaceMethod(self, @selector(viewWillDisappear:), self, @selector(sn_viewWillDisappear:));
        replaceMethod(self, @selector(viewDidLoad), self, @selector(sn_viewDidLoad));
    });
}

- (void)sn_viewWillAppear:(BOOL)animated {
    if ([self isKindOfClass:[UINavigationController class]] ||
        [self isKindOfClass:[UITabBarController class]]) {
        return;
    }
    if (self.tabBarController) {
        if ([self.tabBarController.navigationController isEqual:self.navigationController]) {
            self.tabBarController.navigationController.sn_navigationBar.hidden = NO;
        } else {
            self.tabBarController.navigationController.sn_navigationBar.hidden = YES;
        }
        self.tabBarController.navigationItem.title = self.title;
    } else {
        self.navigationController.sn_navigationBar.hidden = NO;
    }
    
    [self sn_viewWillAppear:animated];
}
- (void)sn_viewDidAppear:(BOOL)animated {
    
    [self sn_viewDidAppear:animated];
}
- (void)sn_viewWillDisappear:(BOOL)animated {
    
    [self sn_viewWillDisappear:animated];
}
- (void)sn_viewDidLoad {
    [RACObserve(self.sn_navigationController.sn_navigationBar, frame) subscribeNext:^(id  _Nullable x) {
        __block UIScrollView * scrollview;
        [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UIScrollView class]]) {
                scrollview = obj;
            }
        }];
        if (scrollview) {
            [scrollview mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.mas_top).offset(self.sn_navigationController.sn_navigationBar.frame.size.height);
            }];
        }
    }];
    [self sn_viewDidLoad];
}

#pragma mark -- getter / setter

//多导航栏
- (void)setSn_navigationController:(UINavigationController *)sn_navigationController {
    objc_setAssociatedObject(self, @selector(sn_navigationController), sn_navigationController, OBJC_ASSOCIATION_ASSIGN);
}
- (UINavigationController *)sn_navigationController {
    if (self.navigationController) {
        return self.navigationController;
    } else if (self.tabBarController) {
        return self.tabBarController.navigationController;
    } else if ([self isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)self;
    } else {
        return objc_getAssociatedObject(self, _cmd);
    }
}

//转场代理
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

#pragma mark -- 手势
- (void)setSn_leftScreenEdgePanGesture:(UIScreenEdgePanGestureRecognizer *)sn_leftScreenEdgePanGesture {
    objc_setAssociatedObject(self, @selector(setSn_leftScreenEdgePanGesture:), sn_leftScreenEdgePanGesture, OBJC_ASSOCIATION_ASSIGN);
}
- (UIScreenEdgePanGestureRecognizer *)sn_leftScreenEdgePanGesture {
    UIScreenEdgePanGestureRecognizer * gesture = objc_getAssociatedObject(self, _cmd);
    if (!gesture) {
        gesture = [[UIScreenEdgePanGestureRecognizer alloc] init];
        gesture.edges = UIRectEdgeLeft;
        objc_setAssociatedObject(self, @selector(sn_leftScreenEdgePanGesture), gesture, OBJC_ASSOCIATION_ASSIGN);
    } return gesture;
}

- (void)setSn_rightScreenEdgePanGesture:(UIScreenEdgePanGestureRecognizer *)sn_rightScreenEdgePanGesture {
    objc_setAssociatedObject(self, @selector(sn_rightScreenEdgePanGesture), sn_rightScreenEdgePanGesture, OBJC_ASSOCIATION_ASSIGN);
}
- (UIScreenEdgePanGestureRecognizer *)sn_rightScreenEdgePanGesture {
    UIScreenEdgePanGestureRecognizer * gesture = objc_getAssociatedObject(self, _cmd);
    if (!gesture) {
        gesture = [[UIScreenEdgePanGestureRecognizer alloc] init];
        gesture.edges = UIRectEdgeRight;
		gesture.enabled = NO;
        objc_setAssociatedObject(self, @selector(sn_rightScreenEdgePanGesture), gesture, OBJC_ASSOCIATION_ASSIGN);
    } return gesture;
}
- (void)setSn_pullScreenBackPanGesture:(UIPanGestureRecognizer *)sn_pullScreenBackPanGesture {
	objc_setAssociatedObject(self, @selector(sn_pullScreenBackPanGesture), sn_pullScreenBackPanGesture, OBJC_ASSOCIATION_ASSIGN);
}
- (UIPanGestureRecognizer *)sn_pullScreenBackPanGesture {
	UIPanGestureRecognizer * gesture = objc_getAssociatedObject(self, _cmd);
	if (!gesture) {
		gesture = [[UIPanGestureRecognizer alloc] init];
		gesture.enabled = NO;
		objc_setAssociatedObject(self, @selector(sn_pullScreenBackPanGesture), gesture, OBJC_ASSOCIATION_ASSIGN);
	} return gesture;
}

@end
