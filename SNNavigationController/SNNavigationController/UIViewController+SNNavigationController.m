//
//  UIViewController+SNNavigationController.m
//  SNNavigationController
//
//  Created by snlo on 2018/8/23.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "UIViewController+SNNavigationController.h"

@interface UIViewController () 

@end

@implementation UIViewController (SNNavigationController)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        replaceMethod(self, @selector(viewWillAppear:), self, @selector(sn_viewWillAppear:));
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
                [scrollview layoutIfNeeded];
            }];
        }
    }];
}

#pragma mark -- getter / setter

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



@end
