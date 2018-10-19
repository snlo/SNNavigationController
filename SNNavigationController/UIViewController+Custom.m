//
//  UIViewController+Custom.m
//  SNNavigationController
//
//  Created by snlo on 2018/9/11.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "UIViewController+Custom.h"

@implementation UIViewController (Custom)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        snna_replaceMethod(self, @selector(viewWillAppear:), self, @selector(cu_viewWillAppear:));
    });
}
- (void)cu_viewWillAppear:(BOOL)animated {
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
    [self cu_viewWillAppear:animated];
}

@end
