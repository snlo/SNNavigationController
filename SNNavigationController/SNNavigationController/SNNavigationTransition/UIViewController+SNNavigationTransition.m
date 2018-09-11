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
        replaceMethod(self, @selector(observeValueForKeyPath:ofObject:change:context:), self, @selector(sn_observeValueForKeyPath:ofObject:change:context:));
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
    self.sn_navigationController.sn_navigationBar.labelToTitle.text = self.title;
    self.sn_navigationController.sn_navigationBar.backgroundColor = self.sn_navigationBarBackgroudColor;
//	self.navigationController.sn_navigationBar.labelMoveTile.
    
    //处理滑动视图偏移
//    __block UIScrollView * scrollview;
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIScrollView class]]) {
            self.sn_currentScrollView = obj;
        }
    }];
    if (self.sn_currentScrollView ) {
        [NSLayoutConstraint constraintWithItem:self.sn_currentScrollView
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.view
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1.0f
                                      constant:self.sn_navigationBarHeight].active = YES;
    }
    
    [self sn_viewWillAppear:animated];
}
- (void)sn_viewDidAppear:(BOOL)animated {
	
//    if (self.sn_currentScrollView.observationInfo) {
//        [self.sn_currentScrollView removeObserver:self forKeyPath:@"contentOffset"];
//    }
//    [self.sn_currentScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:@"sn_currentScrollView_contentOffset"];
    
    [RACObserve(self.sn_currentScrollView, contentOffset) subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",NSStringFromCGPoint(CGPointMake(100, 32)));
        NSLog(@" -- - -000 - -- -%f",self.sn_currentScrollView.contentOffset.y);
    }];
    
    [self sn_viewDidAppear:animated];
}
- (void)sn_viewWillDisappear:(BOOL)animated {
    
    [self sn_viewWillDisappear:animated];
}
- (void)sn_viewDidDisappear:(BOOL)animated {
    
//    [self.sn_currentScrollView removeObserver:self forKeyPath:@"contentOffset"];
    [self sn_viewDidDisappear:animated];
}
- (void)sn_viewDidLoad {
    
    NSLog(@" -- - -- %@",self.sn_currentScrollView);
    
    
    [self sn_viewDidLoad];
}
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
//    NSLog(@"keyPath=%@,object=%@,change=%@,context=%@",keyPath,object,change,context);
//}
- (void)sn_observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([[NSString stringWithFormat:@"%@",context] isEqualToString:@"sn_currentScrollView_contentOffset"]) {
        NSLog(@"-- -- - -- ");
        CGPoint * offset = (__bridge CGPoint *)([change objectForKey:NSKeyValueChangeNewKey]);
        self.sn_navigationController.sn_navigationBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.sn_navigationController.sn_navigationBar.frame.size.height+offset->y);
    } else {
        
    }
    [self sn_observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}
#pragma mark -- getter / setter

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

#pragma mark -- 导航栏属性
//
- (void)setSn_navigationBarBackgroudColor:(UIColor *)sn_navigationBarBackgroudColor {
    self.sn_navigationController.sn_navigationBar.backgroundColor = sn_navigationBarBackgroudColor;
    objc_setAssociatedObject(self, @selector(sn_navigationBarBackgroudColor), sn_navigationBarBackgroudColor, OBJC_ASSOCIATION_ASSIGN);
}
- (UIColor *)sn_navigationBarBackgroudColor {
    UIColor * color = objc_getAssociatedObject(self, _cmd);
    if (!color) {
        color = [UIColor whiteColor];
        objc_setAssociatedObject(self, @selector(sn_navigationBarBackgroudColor), color, OBJC_ASSOCIATION_ASSIGN);
    } return color;
}
//
- (void)setSn_navigationBarHeight:(CGFloat)sn_navigationBarHeight {
    NSNumber * number = [NSNumber numberWithFloat:sn_navigationBarHeight];
    objc_setAssociatedObject(self, @selector(sn_navigationBarHeight), number, OBJC_ASSOCIATION_RETAIN);
}
- (CGFloat)sn_navigationBarHeight {
    NSNumber * number = objc_getAssociatedObject(self, _cmd);
    if (!number) {
        number = [NSNumber numberWithFloat:kIs_iPhoneX ? 88:64];
        objc_setAssociatedObject(self, @selector(sn_navigationBarHeight), number, OBJC_ASSOCIATION_RETAIN);
    } return [number floatValue];
}
//
- (void)setSn_prefersLargeTitles:(BOOL)sn_prefersLargeTitles {
    NSNumber * number = [NSNumber numberWithBool:sn_prefersLargeTitles];
    if ([number boolValue]) {
        self.sn_navigationBarHeight = (kIs_iPhoneX ? 88:64)+52;
    } else {
        self.sn_navigationBarHeight = kIs_iPhoneX ? 88:64;
    }
    objc_setAssociatedObject(self, @selector(sn_prefersLargeTitles), number, OBJC_ASSOCIATION_RETAIN);
}
- (BOOL)sn_prefersLargeTitles {
    NSNumber * number = objc_getAssociatedObject(self, _cmd);
    if (!number) {
        number = [NSNumber numberWithBool:NO];
        objc_setAssociatedObject(self, @selector(sn_prefersLargeTitles), number, OBJC_ASSOCIATION_RETAIN);
    } return [number boolValue];
}


@end
