//
//  UITabBarController+SNNavigationTransition.m
//  SNNavigationController
//
//  Created by snlo on 2018/10/23.
//  Copyright © 2018 snlo. All rights reserved.
//

#import "UITabBarController+SNNavigationTransition.h"

#import "SNNavigationControllerTool.h"

@interface UITabBarController () <UITabBarControllerDelegate>

@end

@implementation UITabBarController (SNNavigationTransition)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        snna_replaceMethod(self, @selector(viewDidLoad), self, @selector(snta_viewDidLoad));
    });
}

- (void)snta_viewDidLoad {
    
    self.delegate = self;
    
    @weakify(self);
    [self aspect_hookSelector:@selector(tabBarController:didSelectViewController:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo, UITabBarController* tabBarController, UIViewController* viewController) {
        
        @strongify(self);
        if (self.sn_selectedItemBlock) {
            self.sn_selectedItemBlock();
        }
        
    } error:NULL];
    
    [self snta_viewDidLoad];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {

}


#pragma mark -- getter
- (void)setSn_selectedItemBlock:(SNNASelectedTabBarItemBlock)sn_selectedItemBlock {
    objc_setAssociatedObject(self, @selector(sn_selectedItemBlock), sn_selectedItemBlock, OBJC_ASSOCIATION_COPY);
}
- (SNNASelectedTabBarItemBlock)sn_selectedItemBlock {
    return objc_getAssociatedObject(self, _cmd);
}

@end
