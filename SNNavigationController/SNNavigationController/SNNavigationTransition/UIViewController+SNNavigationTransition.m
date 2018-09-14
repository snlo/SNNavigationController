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

@property (nonatomic, weak) UIScrollView * sn_currentScrollView;

@property (nonatomic, assign) BOOL isWillDisappear;
@property (nonatomic, assign) BOOL isScrollViewSignalMark;

@end

@implementation UIViewController (SNNavigationTransition)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        replaceMethod(self, @selector(viewWillAppear:), self, @selector(sn_viewWillAppear:));
        replaceMethod(self, @selector(viewDidAppear:), self, @selector(sn_viewDidAppear:));
        replaceMethod(self, @selector(viewWillDisappear:), self, @selector(sn_viewWillDisappear:));
        replaceMethod(self, @selector(viewDidDisappear:), self, @selector(sn_viewDidDisappear:));
        replaceMethod(self, @selector(viewDidLoad), self, @selector(sn_viewDidLoad));
        
    });
}

- (void)sn_viewWillAppear:(BOOL)animated {
    if ([self isKindOfClass:[UINavigationController class]] ||
        [self isKindOfClass:[UITabBarController class]]) {
        return;
    }
    //处理多导航栏
    if (self.tabBarController) {
        if ([self.tabBarController.sn_navigationController isEqual:self.sn_navigationController]) {
            self.tabBarController.sn_navigationController.sn_navigationBar.hidden = NO;
        } else {
            self.tabBarController.sn_navigationController.sn_navigationBar.hidden = YES;
        }
        self.tabBarController.navigationItem.title = self.title;
    } else {
        self.sn_navigationController.sn_navigationBar.hidden = NO;
    }
    
    //基本属性交接
    
    self.sn_navigationController.sn_navigationBar.labelTitle.text = self.title;
    if (self.sn_navigationItem.prefersLargeTitles) {
        if (self.sn_navigationItem.centerLabelTitle.x > 0) {
            
        } else {
            self.sn_navigationItem.centerLabelFromTitle = CGPointMake(16+self.sn_navigationController.sn_navigationBar.labelFromTile.bounds.size.width/2, 44+52/2);
            self.sn_navigationItem.centerLabelTitle = CGPointMake(16+self.sn_navigationController.sn_navigationBar.labelTitle.bounds.size.width/2, 44+52/2);
        }
    } else {
        if (self.sn_navigationItem.centerLabelTitle.x > 0) {
            
        } else {
            self.sn_navigationItem.centerLabelFromTitle = CGPointMake(SCREEN_WIDTH / 2, 44/2);
            self.sn_navigationItem.centerLabelTitle = CGPointMake(SCREEN_WIDTH / 2, 44/2);
        }
        
    }
    self.sn_navigationController.sn_navigationBar.backgroundColor = self.sn_navigationItem.barBackgroudColor;
    self.sn_navigationController.sn_navigationBar.labelTitle.center = self.sn_navigationItem.centerLabelTitle;
    self.sn_navigationController.sn_navigationBar.labelFromTile.center = self.sn_navigationItem.centerLabelFromTitle;
    if (self.sn_navigationItem.forcePrefersLargeTitles) {
        [self.sn_navigationController.sn_navigationBar setForcePrefersLargeTitles];
    }
    
    //处理滑动视图偏移
//    __block UIScrollView * scrollview;
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIScrollView class]]) {
            self.sn_currentScrollView = obj;
        }
    }];
    if (self.sn_currentScrollView && !self.isScrollViewSignalMark) {
        [NSLayoutConstraint constraintWithItem:self.sn_currentScrollView
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.view
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1.0f
                                      constant:kNavigationBarHeight].active = YES;
        self.sn_currentScrollView.contentInset = UIEdgeInsetsMake(self.sn_navigationItem.barHeight-kNavigationBarHeight, 0, 0, 0);
    }
    self.isWillDisappear = NO;
    
    [self sn_viewWillAppear:animated];
}
- (void)sn_viewDidAppear:(BOOL)animated {
    if (self.sn_currentScrollView && self.sn_navigationItem.prefersLargeTitles && !self.isScrollViewSignalMark) {
        __block CGFloat center_Y = self.sn_navigationItem.centerLabelTitle.y;
        __block CGFloat center_X = self.sn_navigationItem.centerLabelTitle.x;
        __block CGFloat barHeight = self.sn_navigationItem.barHeight;
        [RACObserve(self.sn_currentScrollView, contentOffset) subscribeNext:^(id  _Nullable x) {
            if (!self.sn_navigationItem.prefersLargeTitles) return ;
            if (self.isWillDisappear) return;
            CGFloat offset_y = self.sn_currentScrollView.contentOffset.y + self.sn_currentScrollView.contentInset.top;
            if (offset_y != 0) {
                CGFloat height = barHeight - offset_y;
                
                CGFloat center_y = center_Y + (-self.sn_currentScrollView.contentOffset.y - 52.000f);
                CGFloat center_x = center_X;
                
                if (center_y < center_Y) {
                    
                    center_x = center_X + ((self.sn_currentScrollView.contentOffset.y+52.000f)/(48.000f))*(SCREEN_WIDTH/2 - center_X);
                }
                
                height = height > kNavigationBarHeight ? height :kNavigationBarHeight;
                center_x = center_x < SCREEN_WIDTH/2 ? center_x :SCREEN_WIDTH/2;
                center_y = center_y > 22 ? center_y : 22;
                
                self.sn_navigationController.sn_navigationBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
                self.sn_navigationController.sn_navigationBar.labelTitle.center = CGPointMake(center_x, center_y);
                self.sn_navigationController.sn_navigationBar.labelFromTile.center = CGPointMake(center_x, center_y);
                
                self.sn_navigationItem.centerLabelTitle = CGPointMake(center_x, center_y);
                self.sn_navigationItem.centerLabelFromTitle = CGPointMake(center_x, center_y);
                self.sn_navigationItem.barHeight = height;
                
            }
        }];
        
        
        [self.sn_currentScrollView.panGestureRecognizer.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            if (self.isWillDisappear) return;
            if (x.state == UIGestureRecognizerStateEnded) {
                if ((self.sn_navigationController.sn_navigationBar.labelTitle.center.y < center_Y && self.sn_navigationController.sn_navigationBar.labelTitle.center.y > 22) || (self.sn_navigationController.sn_navigationBar.labelFromTile.center.y < center_Y && self.sn_navigationController.sn_navigationBar.labelFromTile.center.y > 22)) {
                    [self.sn_currentScrollView setContentOffset:CGPointMake(0, -52) animated:YES];
                }
            }
        }];
    }
    
    [self sn_viewDidAppear:animated];
}
- (void)sn_viewWillDisappear:(BOOL)animated {
    self.isWillDisappear = YES;
    self.isScrollViewSignalMark = YES;
    [self sn_viewWillDisappear:animated];
}
- (void)sn_viewDidDisappear:(BOOL)animated {
    
    [self sn_viewDidDisappear:animated];
}
- (void)sn_viewDidLoad {

    [self sn_viewDidLoad];
}

#pragma mark -- getter / setter

- (void)setIsWillDisappear:(BOOL)isWillDisappear {
    NSNumber * number = [NSNumber numberWithBool:isWillDisappear];
    objc_setAssociatedObject(self, @selector(isWillDisappear), number, OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)isWillDisappear {
    NSNumber * number = objc_getAssociatedObject(self, _cmd);
    return [number boolValue];
}

- (void)setIsScrollViewSignalMark:(BOOL)isScrollViewSignalMark {
    NSNumber * number = [NSNumber numberWithBool:isScrollViewSignalMark];
    objc_setAssociatedObject(self, @selector(isScrollViewSignalMark), number, OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)isScrollViewSignalMark {
    NSNumber * number = objc_getAssociatedObject(self, _cmd);
    return [number boolValue];
}

#pragma mark -- 多导航栏
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
    } else if ([self isKindOfClass:[UITabBarController class]]) {
        return ((UITabBarController *)self).navigationController;
    } else {
        return objc_getAssociatedObject(self, _cmd);
    }
}

#pragma mark -- 转场代理
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

#pragma mark -- 滑动视图
- (void)setSn_currentScrollView:(UIScrollView *)sn_currentScrollView {
    objc_setAssociatedObject(self, @selector(sn_currentScrollView), sn_currentScrollView, OBJC_ASSOCIATION_ASSIGN);
}
- (UIScrollView *)sn_currentScrollView {
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark -- 手势
- (void)setSn_leftScreenEdgePanGesture:(UIScreenEdgePanGestureRecognizer *)sn_leftScreenEdgePanGesture {
    objc_setAssociatedObject(self, @selector(setSn_leftScreenEdgePanGesture:), sn_leftScreenEdgePanGesture, OBJC_ASSOCIATION_RETAIN);
}
- (UIScreenEdgePanGestureRecognizer *)sn_leftScreenEdgePanGesture {
    UIScreenEdgePanGestureRecognizer * gesture = objc_getAssociatedObject(self, _cmd);
    if (!gesture) {
        gesture = [[UIScreenEdgePanGestureRecognizer alloc] init];
        gesture.edges = UIRectEdgeLeft;
        objc_setAssociatedObject(self, @selector(sn_leftScreenEdgePanGesture), gesture, OBJC_ASSOCIATION_RETAIN);
    } return gesture;
}

- (void)setSn_rightScreenEdgePanGesture:(UIScreenEdgePanGestureRecognizer *)sn_rightScreenEdgePanGesture {
    objc_setAssociatedObject(self, @selector(sn_rightScreenEdgePanGesture), sn_rightScreenEdgePanGesture, OBJC_ASSOCIATION_RETAIN);
}
- (UIScreenEdgePanGestureRecognizer *)sn_rightScreenEdgePanGesture {
    UIScreenEdgePanGestureRecognizer * gesture = objc_getAssociatedObject(self, _cmd);
    if (!gesture) {
        gesture = [[UIScreenEdgePanGestureRecognizer alloc] init];
        gesture.edges = UIRectEdgeRight;
        gesture.enabled = NO;
        objc_setAssociatedObject(self, @selector(sn_rightScreenEdgePanGesture), gesture, OBJC_ASSOCIATION_RETAIN);
    } return gesture;
}
- (void)setSn_pullScreenBackPanGesture:(UIPanGestureRecognizer *)sn_pullScreenBackPanGesture {
    objc_setAssociatedObject(self, @selector(sn_pullScreenBackPanGesture), sn_pullScreenBackPanGesture, OBJC_ASSOCIATION_RETAIN);
}
- (UIPanGestureRecognizer *)sn_pullScreenBackPanGesture {
    UIPanGestureRecognizer * gesture = objc_getAssociatedObject(self, _cmd);
    if (!gesture) {
        gesture = [[UIPanGestureRecognizer alloc] init];
        gesture.enabled = NO;
        objc_setAssociatedObject(self, @selector(sn_pullScreenBackPanGesture), gesture, OBJC_ASSOCIATION_RETAIN);
    } return gesture;
}

#pragma mark -- SNNavigationItem
- (void)setSn_navigationItem:(SNNavigationItem *)sn_navigationItem {
    objc_setAssociatedObject(self, @selector(sn_navigationItem), sn_navigationItem, OBJC_ASSOCIATION_RETAIN);
}
- (SNNavigationItem *)sn_navigationItem {
    SNNavigationItem * navigationItem = objc_getAssociatedObject(self, _cmd);
    if (!navigationItem) {
        navigationItem = [[SNNavigationItem alloc] init];
        navigationItem.barBackgroudColor = [UIColor whiteColor];
        navigationItem.prefersLargeTitles = NO;
        objc_setAssociatedObject(self, @selector(sn_navigationItem), navigationItem, OBJC_ASSOCIATION_RETAIN);
    } return navigationItem;
}

@end
