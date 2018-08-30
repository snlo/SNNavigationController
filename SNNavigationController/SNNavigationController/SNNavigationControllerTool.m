//
//  SNNavigationControllerTool.m
//  SNNavigationController
//
//  Created by snlo on 2018/8/23.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "SNNavigationControllerTool.h"

#import <objc/runtime.h>
#import <objc/message.h>

//@implementation SNNavigationControllerTool

singletonImplemention(SNNavigationControllerTool)

void replaceMethod(Class aClass, SEL aMethod, Class newClass, SEL newMethod) {
    Method aMethods = class_getInstanceMethod(aClass, aMethod);
    Method newMethods = class_getInstanceMethod(newClass, newMethod);

    if(class_addMethod(aClass, aMethod, method_getImplementation(newMethods), method_getTypeEncoding(newMethods))) {
        
        class_replaceMethod(aClass, newMethod, method_getImplementation(aMethods), method_getTypeEncoding(aMethods));
    } else {
        method_exchangeImplementations(aMethods, newMethods);
    }
}

@synthesize navigationBar = _navigationBar;
- (void)setNavigationBar:(UIView *)navigationBar {
    _navigationBar.frame = navigationBar.frame;
    _navigationBar.backgroundColor = navigationBar.backgroundColor;
}
- (UIView *)navigationBar {
    if (!_navigationBar) {
        _navigationBar = [[UIView alloc] init];
        _navigationBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
        _navigationBar.backgroundColor = [UIColor yellowColor];
    }
    return _navigationBar;
}

@end
