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
        
    });
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void)dealloc {
    [self.sn_navigationBar removeObserver:self forKeyPath:@"hidden" context:nil];
}
- (void)viewDidLoad {
    self.navigationBar.hidden = YES;
    [self.view addSubview:self.sn_navigationBar];
    [self.sn_navigationBar addObserver:self forKeyPath:@"hidden" options:NSKeyValueObservingOptionNew context:nil];
}
#pragma clang diagnostic pop

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([object isKindOfClass:[SNNavigationBar class]] && [keyPath isEqualToString:@"hidden"]) {
        
        if (!self.sn_navigationBar.hidden) {
            self.navigationBar.hidden = YES;
        } else {
            self.navigationBar.hidden = NO;
        }
    }
}

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

@end
