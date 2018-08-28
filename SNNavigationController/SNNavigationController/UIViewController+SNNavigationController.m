//
//  UIViewController+SNNavigationController.m
//  SNNavigationController
//
//  Created by snlo on 2018/8/23.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "UIViewController+SNNavigationController.h"

#import <objc/runtime.h>

#import "SNNavigationControllerTool.h"

#import "UINavigationController+SNNavigationController.h"

@implementation UIViewController (SNNavigationController)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
		
    });
}

#pragma mark -- life cycle
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void)dealloc {
//    [self.sn_navigationController.sn_navigationBar removeObserver:self forKeyPath:@"hidden"];
}
- (void)viewWillAppear:(BOOL)animated {
    
    
    if ([self isKindOfClass:[UINavigationController class]] ||
        [self isKindOfClass:[UITabBarController class]]) {
        
        return;
    }
    
    
//
//    self.tabBarController.navigationController.navigationBar.hidden = YES;
//    self.navigationController.navigationBar.hidden = YES;
////    self.tabBarController.tabBarController.tabBar.hidden = YES;
//    NSLog(@"self:%@\n.:%@\n..:%@",self,self.tabBarController,self.tabBarController.tabBarController);
////    if (self.tabBarController.tabBarController) {
////        self.tabBarController.tabBarController.tabBar.hidden = YES;
////    } else {
//        self.tabBarController.tabBar.hidden = NO;
////    }
//    [self handleController:self.tabBarController];
//
//    return;
//    if ([self isKindOfClass:[UINavigationController class]]) {
//        return;
//    }
//    [self.sn_navigationController.view addSubview:[SNNavigationControllerTool sharedManager].navigationBar];
//
    
//    NSLog(@" -- -- -- - - -- - - %@",scrollview);
//    NSLog(@"%@",self);
//    NSLog(@"---%@",self.navigationController);
//    NSLog(@"+++%@",self.tabBarController.navigationController);
	
//    if (self.tabBarController) {
//        if ([self.tabBarController.navigationController isEqual:self.navigationController]) {
//            self.tabBarController.navigationController.navigationBar.hidden = NO;
//        } else {
//            self.tabBarController.navigationController.navigationBar.hidden = YES;
//        }
//        self.tabBarController.navigationItem.title = self.title;
//    } else {
//        self.navigationController.navigationBar.hidden = NO;
//    }
	
}
//- (void)handleController:(UITabBarController *)VC {
//    if (VC.tabBarController) {
//        VC.tabBarController.tabBar.hidden = YES;
//        [self handleController:VC.tabBarController];
//    }
//}
- (void)viewDidLoad {
//    [self.sn_navigationController.sn_navigationBar addObserver:self forKeyPath:@"hidden" options:NSKeyValueObservingOptionNew context:nil];
    __block UIScrollView * scrollview;
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIScrollView class]]) {
            scrollview = obj;
        }
    }];
    if (scrollview) {
        NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:scrollview attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.sn_navigationController.sn_navigationBar.frame.size.height];
        [self.view addConstraint:constraint1];
    }
}
#pragma clang diagnostic pop

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    if ([object isKindOfClass:[SNNavigationBar class]] && [keyPath isEqualToString:@"hidden"]) {
//
//    }
//}

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
