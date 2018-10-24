//
//  UITabBarController+SNNavigationTransition.m
//  SNNavigationController
//
//  Created by snlo on 2018/10/23.
//  Copyright © 2018 snlo. All rights reserved.
//

#import "UITabBarController+SNNavigationTransition.h"

@interface UITabBarController () <UITabBarControllerDelegate>

@end

@implementation UITabBarController (SNNavigationTransition)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        snna_replaceMethod(self, @selector(viewDidLoad), self, @selector(sn_viewDidLoad));
        
    });
}

- (void)sn_viewDidLoad {
    
    self.delegate = self;
    [self aspect_hookSelector:@selector(tabBarController:didSelectViewController:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo, UITabBarController* tabBarController, UIViewController* viewController) {
        if (self.selectedItemBlock) {
            self.selectedItemBlock();
        }
        
    } error:NULL];
    
    [self sn_viewDidLoad];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {

}



#pragma mark -- getter
- (void)setSelectedItemBlock:(SNSelectedTabBarItemBlock)selectedItemBlock {
    objc_setAssociatedObject(self, @selector(selectedItemBlock), selectedItemBlock, OBJC_ASSOCIATION_COPY);
}
- (SNSelectedTabBarItemBlock)selectedItemBlock {
    return objc_getAssociatedObject(self, _cmd);
}

@end
