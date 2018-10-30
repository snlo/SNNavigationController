//
//  UIViewController+SNNavigationTransition.m
//  SNNavigationController
//
//  Created by snlo on 2018/8/30.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "UIViewController+SNNavigationTransition.h"

#import "SNNavigationControllerTool.h"

#import "SNTransitionInteractionController.h"

#import "UITabBarController+SNNavigationTransition.h"
#import "UINavigationController+SNNavigationTransition.h"

#import "SNNavigationBar.h"
#import "SNNavigationItem.h"


@interface UIViewController ()

@property (nonatomic, weak) UIScrollView * sn_currentScrollView;

@property (nonatomic, assign) BOOL isWillDisappear;
@property (nonatomic, assign) BOOL isScrollViewSignalMark;

@end

@implementation UIViewController (SNNavigationTransition)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        snna_replaceMethod(self, @selector(viewWillAppear:), self, @selector(sn_viewWillAppear:));
        snna_replaceMethod(self, @selector(viewDidAppear:), self, @selector(sn_viewDidAppear:));
        snna_replaceMethod(self, @selector(viewWillDisappear:), self, @selector(sn_viewWillDisappear:));
        snna_replaceMethod(self, @selector(viewDidDisappear:), self, @selector(sn_viewDidDisappear:));
        snna_replaceMethod(self, @selector(viewDidLoad), self, @selector(sn_viewDidLoad));
    });
}

- (void)sn_viewWillAppear:(BOOL)animated {
    if ([NSStringFromClass(self.class) hasPrefix:@"UI"]) {
        return;
    }
    if ([self isKindOfClass:[UINavigationController class]] ||
        [self isKindOfClass:[UITabBarController class]]) {
        return;
    }
    if (self.isShowCustomNavigationBar) {
        [self CustomNavigationBar_viewWillAppear];
    }
    if (self.isShowSNNavigationBar) {
        [self SNNavigationBar_viewWillAppear];
    }
    if (self.isShowSystemNavigationBar) {
        [self SystemNavigationBar_viewWillAppear];
    }
    
    self.isWillDisappear = NO;
    [self sn_viewWillAppear:animated];
}
- (void)sn_viewDidAppear:(BOOL)animated {
    if ([NSStringFromClass(self.class) hasPrefix:@"UI"]) {
        return;
    }
    if (self.isShowCustomNavigationBar) {
        [self CustomNavigationBar_viewDidAppear];
    }
    if (self.isShowSNNavigationBar) {
        [self SNNavigationBar_viewDidAppear];
    }
    if (self.isShowSystemNavigationBar) {
        [self SystemNavigationBar_viewDidAppear];
    }
    
    [self sn_viewDidAppear:animated];
}
- (void)sn_viewDidLoad {
    if ([NSStringFromClass(self.class) hasPrefix:@"UI"]) {
        return;
    }
    if (self.isShowCustomNavigationBar) {
        [self CustomNavigationBar_viewDidLoad];
    }
    if (self.isShowSNNavigationBar) {
        [self SNNavigationBar_viewDidLoad];
    }
    if (self.isShowSystemNavigationBar) {
        [self SystemNavigationBar_viewDidLoad];
    }

    [self sn_viewDidLoad];
}
- (void)sn_viewWillDisappear:(BOOL)animated {
    if ([NSStringFromClass(self.class) hasPrefix:@"UI"]) {
        return;
    }
    self.isWillDisappear = YES;
    self.isScrollViewSignalMark = YES;
    
    [self sn_viewWillDisappear:animated];
}
- (void)sn_viewDidDisappear:(BOOL)animated {
    if ([NSStringFromClass(self.class) hasPrefix:@"UI"]) {
        return;
    }
    [self sn_viewDidDisappear:animated];
}

#pragma mark -- public methods
- (UIView *)setSearchBarWith:(CGFloat)height {
    return [UIView new]; //禁止设置搜索栏
    CGFloat height_Large = 0.00f;
    if (self.sn_navigationItem.prefersLargeTitles) {
        height_Large = ksLargeHeight;
    }
    self.sn_navigationItem.barHeight = ksNavigationBarHeight + height_Large + height;
    self.sn_navigationItem.showSearchBar = YES;
    self.sn_navigationController.sn_navigationBar.viewSearch.frame = CGRectMake(0, ksNavigationBarHeight+height_Large, ks_SCREEN_WIDTH, height);
    [self.sn_navigationController.sn_navigationBar.viewSearch layoutIfNeeded];

    self.sn_navigationController.sn_navigationBar.viewSearch.backgroundColor = [UIColor redColor];
    return self.sn_navigationController.sn_navigationBar.viewSearch;
}

#pragma mark -- CustomNavigationBar
- (void)CustomNavigationBar_viewWillAppear {
    
}
- (void)CustomNavigationBar_viewDidLoad {
    
}
- (void)CustomNavigationBar_viewDidAppear {
    
}

#pragma mark -- SNNavigationBar :
- (void)SNNavigationBar_viewWillAppear {
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
    
    if ([self.tabBarController.viewControllers containsObject:self]) { //标签栏首次进入配置
        if (self.tabBarController) {
            @weakify(self);
            self.tabBarController.sn_selectedItemBlock = ^{
                @strongify(self);
                //高度
                self.sn_navigationController.sn_navigationBar.frame = CGRectMake(0, 0, ks_SCREEN_WIDTH, self.sn_navigationItem.barHeight);
                
                //大标题视图展示
                if (self.sn_navigationItem.prefersLargeTitles) {
                    self.sn_navigationController.sn_navigationBar.labelLargeTitle.hidden = NO;
                } else {
                    self.sn_navigationController.sn_navigationBar.labelLargeTitle.hidden = YES;
                }
            };
            if ([self.sn_navigationController.viewControllers.firstObject isEqual:self.tabBarController]) {
                
                //导航栏按钮
                self.sn_navigationController.sn_navigationBar.leftBarButtonItems = self.sn_navigationItem.leftBarButtonItems;
                self.sn_navigationController.sn_navigationBar.rightBarButtonItems = self.sn_navigationItem.rightBarButtonItems;
            }
            //搜索视图
            self.sn_navigationController.sn_navigationBar.viewSearch.alpha = self.sn_navigationItem.showSearchBar?1:0;
            
            //小标题展示
            self.sn_navigationController.sn_navigationBar.labelTitle.alpha = 1.0;
            self.sn_navigationController.sn_navigationBar.labelTitle.hidden = self.sn_navigationItem.prefersLargeTitles;
            
            if (!self.sn_navigationController.sn_navigationBar.labelFromTile.hidden) {
                self.sn_navigationController.sn_navigationBar.labelTitle.hidden = YES;
                self.sn_navigationController.sn_navigationBar.labelFromTile.hidden = self.sn_navigationItem.prefersLargeTitles;
            }
            
            //强制大小标题式样
            if (self.sn_navigationItem.forcePrefersLargeTitles) {
                [self.sn_navigationController.sn_navigationBar setForcePrefersLargeTitles:self.sn_navigationItem.forcePrefersLargeTitles];
            }
        }
    } else {
        if (!self.isWillDisappear) {
            
            //大标题视图展示
            if (self.sn_navigationItem.prefersLargeTitles) {
                self.sn_navigationController.sn_navigationBar.labelLargeTitle.hidden = NO;
            } else {
                self.sn_navigationController.sn_navigationBar.labelLargeTitle.hidden = YES;
            }
            
            //搜索视图
            self.sn_navigationController.sn_navigationBar.viewSearch.alpha = self.sn_navigationItem.showSearchBar?1:0;
            
            //小标题展示
            self.sn_navigationController.sn_navigationBar.labelTitle.alpha = 1.0;
            self.sn_navigationController.sn_navigationBar.labelTitle.hidden = self.sn_navigationItem.prefersLargeTitles;
            
            if (!self.sn_navigationController.sn_navigationBar.labelFromTile.hidden) {
                self.sn_navigationController.sn_navigationBar.labelTitle.hidden = YES;
                self.sn_navigationController.sn_navigationBar.labelFromTile.hidden = self.sn_navigationItem.prefersLargeTitles;
            }
            
            //强制大小标题式样
            if (self.sn_navigationItem.forcePrefersLargeTitles) {
                [self.sn_navigationController.sn_navigationBar setForcePrefersLargeTitles:self.sn_navigationItem.forcePrefersLargeTitles];
            }
        }
    }
    
    self.sn_navigationController.sn_navigationBar.backgroundColor = self.sn_navigationItem.barBackgroudColor;
    
    //处理滑动视图偏移
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIScrollView class]]) {
            self.sn_currentScrollView = obj;
        }
    }];
    if (self.sn_currentScrollView && !self.isScrollViewSignalMark) {
//        [NSLayoutConstraint constraintWithItem:self.sn_currentScrollView
//                                     attribute:NSLayoutAttributeTop
//                                     relatedBy:NSLayoutRelationEqual
//                                        toItem:self.view
//                                     attribute:NSLayoutAttributeTop
//                                    multiplier:1.0f
//                                      constant:ksNavigationBarHeight].active = YES;
        
        for (NSLayoutConstraint * constraint in self.view.constraints) {
            if (constraint.firstAttribute == NSLayoutAttributeTop) {
                constraint.constant = ksNavigationBarHeight;
            }
        }
        self.sn_currentScrollView.contentInset = UIEdgeInsetsMake(self.sn_navigationItem.barHeight-ksNavigationBarHeight, 0, 0, 0);
    }
}
- (void)SNNavigationBar_viewDidLoad {
    [RACObserve(self.sn_navigationItem, leftBarButtonItems) subscribeNext:^(id  _Nullable x) {
        if (self.sn_navigationController.sn_navigationBar.viewLeftBarButtonStack.alpha < 1) {
            self.sn_navigationController.sn_navigationBar.leftFromBarButtonItems = self.sn_navigationItem.leftBarButtonItems;
        } else {
            self.sn_navigationController.sn_navigationBar.leftBarButtonItems = self.sn_navigationItem.leftBarButtonItems;
        }
    }];
    [RACObserve(self.sn_navigationItem, rightBarButtonItems) subscribeNext:^(id  _Nullable x) {
        if (self.sn_navigationController.sn_navigationBar.viewRightBarButtonStack.alpha < 1) {
            self.sn_navigationController.sn_navigationBar.rightFromBarButtonItems = self.sn_navigationItem.rightBarButtonItems;
        } else {
            self.sn_navigationController.sn_navigationBar.rightBarButtonItems = self.sn_navigationItem.rightBarButtonItems;
        }
    }];
    [RACObserve(self.sn_navigationItem, barBackgroudColor) subscribeNext:^(id  _Nullable x) {
        self.sn_navigationController.sn_navigationBar.backgroundColor = self.sn_navigationItem.barBackgroudColor;
    }];
    [RACObserve(self, title) subscribeNext:^(id  _Nullable x) {
        self.sn_navigationController.sn_navigationBar.labelTitle.text = self.title;
        self.sn_navigationController.sn_navigationBar.labelLargeTitle.text = self.title;
    }];
}
- (void)SNNavigationBar_viewDidAppear {
    BOOL isShowSearchBar = self.sn_navigationItem.showSearchBar;
    BOOL isPrefersLargeTitles = self.sn_navigationItem.prefersLargeTitles;
    
    if (self.sn_currentScrollView && (isPrefersLargeTitles || isShowSearchBar) && !self.isScrollViewSignalMark) {
        
        //常量记录
        __block CGFloat center_Y = self.sn_navigationController.sn_navigationBar.viewLargeTitle.center.y;
        __block CGFloat barHeight = self.sn_navigationItem.barHeight;
        __block CGFloat center_search_Y = self.sn_navigationController.sn_navigationBar.viewSearch.center.y;
        __block CGFloat center_label_y = self.sn_navigationController.sn_navigationBar.labelLargeTitle.center.y;
        //记录当前监听到的偏移
        __block CGFloat end = 0;
        __block CGFloat center_sreach_y = self.sn_navigationController.sn_navigationBar.viewSearch.center.y;
        __block CGFloat height_sreach = isShowSearchBar ? self.sn_navigationController.sn_navigationBar.viewSearch.bounds.size.height : 0;
        __block CGFloat height_Large = isPrefersLargeTitles ? ksLargeHeight : 0.00f;
        
        @weakify(self);
        [RACObserve(self.sn_currentScrollView, contentOffset) subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            if (self.isWillDisappear) return;
            CGFloat offset_y = self.sn_currentScrollView.contentOffset.y + self.sn_currentScrollView.contentInset.top;
            if (offset_y == end || offset_y == height_Large) {
                return; //当不是当前偏移监听时
            }
            
            if (offset_y != 0) { //排除首次偏移
                self.sn_navigationController.sn_navigationBar.viewLargeTitle.center = CGPointMake(ks_SCREEN_WIDTH/2, center_Y-(offset_y<0?offset_y:0));
                if (isShowSearchBar) {
                    
                    self.sn_navigationController.sn_navigationBar.viewSearch.center = CGPointMake(ks_SCREEN_WIDTH/2, center_search_Y-(offset_y<height_Large?offset_y:height_Large));
                    self.sn_navigationController.sn_navigationBar.frame = CGRectMake(0, 0, ks_SCREEN_WIDTH, barHeight-((offset_y)<(height_Large+height_sreach)?(offset_y):(height_Large+height_sreach)));
                    
                } else {
                    
                    self.sn_navigationController.sn_navigationBar.frame = CGRectMake(0, 0, ks_SCREEN_WIDTH, barHeight-(offset_y<height_Large? offset_y : height_Large));
                }
                
                self.sn_navigationController.sn_navigationBar.labelLargeTitle.alpha = 1;
                self.sn_navigationController.sn_navigationBar.labelLargeTitle.hidden = NO;
                self.sn_navigationController.sn_navigationBar.labelLargeTitle.center = CGPointMake(ks_SCREEN_WIDTH/2 , center_label_y -(offset_y > 0 ? offset_y: 0));
                self.sn_navigationController.sn_navigationBar.labelLargeFromTitle.center = CGPointMake(ks_SCREEN_WIDTH/2 , center_label_y -(offset_y > 0 ? offset_y: 0));
                
                if (isPrefersLargeTitles) {
                    self.sn_navigationController.sn_navigationBar.labelTitle.hidden = NO;
                    self.sn_navigationController.sn_navigationBar.labelTitle.alpha = (offset_y - 40.00f) / 12.00f;
                    self.sn_navigationController.sn_navigationBar.labelFromTile.alpha =  (offset_y - 40.00f) / 12.00f;
                }
                
            }
        }];
        
        [self.sn_currentScrollView.panGestureRecognizer.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) { //手势结束时处理
            if (self.isWillDisappear) return;
            if (x.state == UIGestureRecognizerStateEnded) {
                end = self.sn_currentScrollView.contentOffset.y + self.sn_currentScrollView.contentInset.top;
                
                CGFloat sreach_height = height_sreach;
                
                if (isShowSearchBar) {
                    if (center_sreach_y - self.sn_navigationController.sn_navigationBar.viewSearch.center.y == height_Large && self.sn_navigationController.sn_navigationBar.frame.size.height - ksNavigationBarHeight < height_sreach && self.sn_navigationController.sn_navigationBar.frame.size.height - ksNavigationBarHeight > 0) {
                        
                        [self.sn_currentScrollView setContentOffset:CGPointMake(0, -height_sreach) animated:YES];
                        self.sn_navigationItem.showSearchBar = YES;
                        self.sn_navigationItem.showSearchBarMark = YES;
                        sreach_height = height_sreach;
                        
                    } else if (center_sreach_y - self.sn_navigationController.sn_navigationBar.viewSearch.center.y == height_Large && self.sn_navigationController.sn_navigationBar.frame.size.height - ksNavigationBarHeight <= 0) {
                        
                        self.sn_navigationItem.showSearchBar = NO;
                        self.sn_navigationItem.showSearchBarMark = YES;
                        sreach_height = 0;
                        
                    } else {
                        
                        self.sn_navigationItem.showSearchBar = YES;
                        self.sn_navigationItem.showSearchBarMark = YES;
                        sreach_height = height_sreach;
                    }
                }
                if (center_label_y - self.sn_navigationController.sn_navigationBar.labelLargeTitle.center.y < height_Large) {
                    if (isShowSearchBar) {
                        [self.sn_currentScrollView setContentOffset:CGPointMake(0, -height_Large-height_sreach) animated:YES];
                    } else {
                        [self.sn_currentScrollView setContentOffset:CGPointMake(0, -height_Large) animated:YES];
                    }
                    
                    self.sn_navigationItem.prefersLargeTitles = YES;
                    self.sn_navigationItem.barHeight = ksNavigationBarHeight + height_Large + sreach_height;
                } else {
                    self.sn_navigationItem.prefersLargeTitles = NO;
                    self.sn_navigationItem.barHeight = ksNavigationBarHeight + sreach_height;
                    self.sn_navigationController.sn_navigationBar.labelLargeTitle.center = CGPointMake(ks_SCREEN_WIDTH/2 , center_label_y);
                }
            }
        }];
    }
}

#pragma mark -- SystemNavigationBar
- (void)SystemNavigationBar_viewWillAppear {
    
}
- (void)SystemNavigationBar_viewDidLoad {
    
}
- (void)SystemNavigationBar_viewDidAppear {
    
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
    } else if (self.tabBarController.navigationController) {
        return self.tabBarController.navigationController;
    } else if ([self isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)self;
    } else if ([self isKindOfClass:[UITabBarController class]]) {
        if (((UITabBarController *)self).navigationController) {
            return ((UITabBarController *)self).navigationController;
        } else {
            return objc_getAssociatedObject(self, _cmd);
        }
    } else {
        return objc_getAssociatedObject(self, _cmd);
    }
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
#pragma mark -- BOOL
- (void)setIsShowCustomNavigationBar:(BOOL)isShowCustomNavigationBar {
    if (isShowCustomNavigationBar) {
        self.isShowSNNavigationBar = NO;
        self.isShowSystemNavigationBar = NO;
    }
    NSNumber * number = [NSNumber numberWithBool:isShowCustomNavigationBar];
    objc_setAssociatedObject(self, @selector(isShowCustomNavigationBar), number, OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)isShowCustomNavigationBar {
    NSNumber * number = objc_getAssociatedObject(self, _cmd);
    return [number boolValue];
}

- (void)setIsShowSNNavigationBar:(BOOL)isShowSNNavigationBar {
    if (isShowSNNavigationBar) {
        self.isShowCustomNavigationBar = NO;
        self.isShowSystemNavigationBar = NO;
    }
    NSNumber * number = [NSNumber numberWithBool:isShowSNNavigationBar];
    objc_setAssociatedObject(self, @selector(isShowSNNavigationBar), number, OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)isShowSNNavigationBar {
    NSNumber * number = objc_getAssociatedObject(self, _cmd);
    return [number boolValue];
}

- (void)setIsShowSystemNavigationBar:(BOOL)isShowSystemNavigationBar {
    if (isShowSystemNavigationBar) {
        self.isShowCustomNavigationBar = NO;
        self.isShowSNNavigationBar = NO;
    }
    NSNumber * number = [NSNumber numberWithBool:isShowSystemNavigationBar];
    objc_setAssociatedObject(self, @selector(isShowSystemNavigationBar), number, OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)isShowSystemNavigationBar {
    NSNumber * number = objc_getAssociatedObject(self, _cmd);
    return [number boolValue];
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
        navigationItem.barHeight = ksNavigationBarHeight;
        objc_setAssociatedObject(self, @selector(sn_navigationItem), navigationItem, OBJC_ASSOCIATION_RETAIN);
    } return navigationItem;
}

@end
