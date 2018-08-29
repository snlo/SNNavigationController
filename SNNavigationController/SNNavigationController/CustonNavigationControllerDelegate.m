//
//  CustonNavigationControllerDelegate.m
//  CustomNavTransition
//
//  Created by Baoqin Huang on 2017/6/26.
//  Copyright © 2017年 Baoqin Huang. All rights reserved.
//

#import "CustonNavigationControllerDelegate.h"
#import "PushTransitionAnimation.h"
#import "PopTransitionAnimation.h"

@interface CustonNavigationControllerDelegate () {
    PushTransitionAnimation *_pushAnimation;
    PopTransitionAnimation *_popAnimation;
}

@end

@implementation CustonNavigationControllerDelegate

- (instancetype)init {
    self = [super init];
    if (self) {
        _pushAnimation = [[PushTransitionAnimation alloc] init];
        _popAnimation = [[PopTransitionAnimation alloc] init];
    }
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
        return _popAnimation;
    }
    if (operation == UINavigationControllerOperationPush) {
        return _pushAnimation;
    }
    return nil;
}

@end
