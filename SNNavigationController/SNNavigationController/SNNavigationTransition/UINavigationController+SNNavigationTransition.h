//
//  UINavigationController+SNNavigationTransition.h
//  SNNavigationController
//
//  Created by snlo on 2018/8/30.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SNNavigationBar.h"
#import "SNNavigationTransitionDelegate.h"

@interface UINavigationController (SNNavigationTransition)

@property (nonatomic, strong) SNNavigationBar * sn_navigationBar;

@property (nonatomic, weak) SNNavigationTransitionDelegate * sn_navigationDelegate;

@end
