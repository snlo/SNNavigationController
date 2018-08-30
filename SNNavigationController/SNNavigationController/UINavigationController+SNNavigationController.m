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

@interface UINavigationController ()

@property (nonatomic, weak) SNNavigationTransitionDelegate * sn_navigationDelegate;

@end

@implementation UINavigationController (SNNavigationController)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        replaceMethod(self, @selector(viewDidLoad), self, @selector(sn_viewDidLoad));
    });
}

- (void)sn_viewDidLoad {
//    self.navigationBar.hidden = YES;
//    [self.view addSubview:self.sn_navigationBar];

//    self.delegate = self.custonDelegate;
    self.delegate = self.sn_navigationDelegate;
    
    UIScreenEdgePanGestureRecognizer * leftScreenEdgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftScreenEdgePanGesturexx:)];
    
    leftScreenEdgePan.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:leftScreenEdgePan];
}

- (void)handleLeftScreenEdgePanGesturexx:(UIScreenEdgePanGestureRecognizer *)gesture {
    
    CGFloat progress = [gesture translationInView:self.view].x / self.view.bounds.size.width / 2;
    [self.sn_navigationDelegate updateState:gesture.state progress:progress forViewController:self];
}


#pragma mark -- getter / setter
- (void)setSn_navigationBar:(SNNavigationBar *)sn_navigationBar {
    objc_setAssociatedObject(self, @selector(sn_navigationBar), sn_navigationBar, OBJC_ASSOCIATION_ASSIGN);
}
- (SNNavigationBar *)sn_navigationBar {
    SNNavigationBar * view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = [[SNNavigationBar alloc] init];
        self.navigationBar.hidden = YES;
        [self.view addSubview:view];
        objc_setAssociatedObject(self, @selector(sn_navigationBar), view, OBJC_ASSOCIATION_ASSIGN);
    } return view;
}

- (void)setSn_navigationDelegate:(SNNavigationTransitionDelegate *)sn_navigationDelegate {
    objc_setAssociatedObject(self, @selector(sn_navigationDelegate), sn_navigationDelegate, OBJC_ASSOCIATION_RETAIN);
}
- (SNNavigationTransitionDelegate *)sn_navigationDelegate {
    SNNavigationTransitionDelegate * delegate = objc_getAssociatedObject(self, _cmd);
    if (!delegate) {
        delegate = [[SNNavigationTransitionDelegate alloc] init];
        objc_setAssociatedObject(self, @selector(sn_navigationDelegate), delegate, OBJC_ASSOCIATION_RETAIN);
    } return delegate;
}


@end
