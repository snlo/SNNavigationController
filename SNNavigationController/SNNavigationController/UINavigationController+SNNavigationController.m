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

#import "CustonNavigationControllerDelegate.h"

@interface UINavigationController ()

@property (nonatomic, weak) CustonNavigationControllerDelegate * custonDelegate;

@end

@implementation UINavigationController (SNNavigationController)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
}



#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void)viewDidLoad {
    self.navigationBar.hidden = YES;
    [self.view addSubview:self.sn_navigationBar];

    self.delegate = self.custonDelegate;
}
#pragma clang diagnostic pop


- (UIViewController *)sn_popViewControllerAnimated:(BOOL)animated {
    return [UIViewController new];
}

#pragma mark -- getter / setter
- (void)setSn_navigationBar:(SNNavigationBar *)sn_navigationBar {
    objc_setAssociatedObject(self, @selector(sn_navigationBar), sn_navigationBar, OBJC_ASSOCIATION_ASSIGN);
}
- (SNNavigationBar *)sn_navigationBar {
    SNNavigationBar * view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = [[SNNavigationBar alloc] init];
        objc_setAssociatedObject(self, @selector(sn_navigationBar), view, OBJC_ASSOCIATION_ASSIGN);
    } return view;
}


- (void)setCustonDelegate:(CustonNavigationControllerDelegate *)custonDelegate {
    objc_setAssociatedObject(self, @selector(custonDelegate), custonDelegate, OBJC_ASSOCIATION_RETAIN);
}
- (CustonNavigationControllerDelegate *)custonDelegate {
    CustonNavigationControllerDelegate * delegate = objc_getAssociatedObject(self, _cmd);
    if (!delegate) {
        delegate = [[CustonNavigationControllerDelegate alloc] init];
        objc_setAssociatedObject(self, @selector(custonDelegate), delegate, OBJC_ASSOCIATION_RETAIN);
    } return delegate;
}








//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//
//    [self wirePopInteractionControllerTo:viewController];
//}
//
//- (void)wirePopInteractionControllerTo:(UIViewController *)viewController
//{
//    // when a push occurs, wire the interaction controller to the to- view controller
//    if (!AppDelegateAccessor.navigationControllerInteractionController) {
//        return;
//    }
//
//    [AppDelegateAccessor.navigationControllerInteractionController wireToViewController:viewController forOperation:CEInteractionOperationPop];
//}
//
//
//- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
//
//    if (AppDelegateAccessor.navigationControllerAnimationController) {
//        AppDelegateAccessor.navigationControllerAnimationController.reverse = operation == UINavigationControllerOperationPop;
//    }
//
//    return (id)AppDelegateAccessor.navigationControllerAnimationController;
//}
//
//- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
//
//    // if we have an interaction controller - and it is currently in progress, return it
//    return AppDelegateAccessor.navigationControllerInteractionController && AppDelegateAccessor.navigationControllerInteractionController.interactionInProgress ? AppDelegateAccessor.navigationControllerInteractionController : nil;
//}


@end
