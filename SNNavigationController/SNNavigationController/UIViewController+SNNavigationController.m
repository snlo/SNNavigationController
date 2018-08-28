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

@implementation UIViewController (SNNavigationController)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
		
    });
}

#pragma mark -- life cycle
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void)viewWillAppear:(BOOL)animated {
	if ([self isKindOfClass:[UINavigationController class]]) {
		return;
	}
	NSLog(@"%@",self);
	NSLog(@"---%@",self.navigationController);
	NSLog(@"+++%@",self.tabBarController.navigationController);
	
	if (self.tabBarController) {
		if ([self.tabBarController.navigationController isEqual:self.navigationController]) {
			self.tabBarController.navigationController.navigationBar.hidden = NO;
		} else {
			self.tabBarController.navigationController.navigationBar.hidden = YES;
		}
		self.tabBarController.navigationItem.title = self.title;
	} else {
		self.navigationController.navigationBar.hidden = NO;
	}
	
}
- (void)viewDidLoad {
	
}
#pragma clang diagnostic pop

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
