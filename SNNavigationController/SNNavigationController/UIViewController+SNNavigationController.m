//
//  UIViewController+SNNavigationController.m
//  SNNavigationController
//
//  Created by snlo on 2018/8/23.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "UIViewController+SNNavigationController.h"

#import "SNNavigationControllerTool.h"

@implementation UIViewController (SNNavigationController)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        replaceMethod(self, @selector(loadView), self, @selector(ahudahudsh));
    });
}

- (void)ahudahudsh {
    
}

@end
