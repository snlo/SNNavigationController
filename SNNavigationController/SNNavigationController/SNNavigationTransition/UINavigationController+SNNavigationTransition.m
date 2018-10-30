//
//  UINavigationController+SNNavigationTransition.m
//  SNNavigationController
//
//  Created by snlo on 2018/8/30.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "UINavigationController+SNNavigationTransition.h"

#import "SNNavigationControllerTool.h"

#import "SNNavigationBar.h"
#import "SNNavigationItem.h"

@interface UINavigationController ()

@end

@implementation UINavigationController (SNNavigationTransition)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        snna_replaceMethod(self, @selector(viewDidLoad), self, @selector(snna_viewDidLoad));
    });
}

- (void)snna_viewDidLoad {
    
    if (self.isSNNavigationBar) {
        self.navigationBar.hidden = YES;
        [self sn_navigationBar];
        self.delegate = self.sn_navigationDelegate;
    }
    
    [self snna_viewDidLoad];
}
#pragma mark -- getter / setter
- (void)setSn_navigationBar:(SNNavigationBar *)sn_navigationBar {
    objc_setAssociatedObject(self, @selector(sn_navigationBar), sn_navigationBar, OBJC_ASSOCIATION_RETAIN);
}
- (SNNavigationBar *)sn_navigationBar {
    SNNavigationBar * view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = [[SNNavigationBar alloc] init];
        [self.view addSubview:view];
        objc_setAssociatedObject(self, @selector(sn_navigationBar), view, OBJC_ASSOCIATION_RETAIN);
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

- (void)setIsSNNavigationBar:(BOOL)isSNNavigationBar {
    NSNumber * number = [NSNumber numberWithBool:isSNNavigationBar];
    objc_setAssociatedObject(self, @selector(isSNNavigationBar), number, OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)isSNNavigationBar {
    NSNumber * number = objc_getAssociatedObject(self, _cmd);
    return [number boolValue];
}

@end
