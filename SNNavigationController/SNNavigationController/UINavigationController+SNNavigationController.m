//
//  UINavigationController+SNNavigationController.m
//  SNNavigationController
//
//  Created by snlo on 2018/8/23.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "UINavigationController+SNNavigationController.h"

#import <objc/runtime.h>

#import "SNNavigationControllerTool.h"

@implementation UINavigationController (SNNavigationController)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        replaceMethod(self, @selector(popViewControllerAnimated:), self, @selector(sn_popViewControllerAnimated:));
    });
}

- (UIViewController *)sn_popViewControllerAnimated:(BOOL)animated {
    return [UIViewController new];
}

@end
