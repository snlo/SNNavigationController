//
//  UINavigationController+SNNavigationTransition.m
//  SNNavigationController
//
//  Created by snlo on 2018/8/30.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "UINavigationController+SNNavigationTransition.h"



@interface UINavigationController ()

@end

@implementation UINavigationController (SNNavigationTransition)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        replaceMethod(self, @selector(pushViewController:animated:), self, @selector(sn_pushViewController:animated:));
    });
}

- (void)sn_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.delegate = self.sn_navigationDelegate;
    [self pushViewController:viewController animated:YES];
}



@end
