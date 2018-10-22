//
//  UITabBar+SNTabBar.m
//  SNNavigationController
//
//  Created by snlo on 2018/8/28.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "UITabBar+SNTabBar.h"

@implementation UITabBar (SNTabBar)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void)awakeFromNib {
    [super awakeFromNib];
    
//    self.backgroundColor = [UIColor blueColor];
}
#pragma clang diagnostic pop

@end
