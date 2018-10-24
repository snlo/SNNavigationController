//
//  UITabBarController+SNNavigationTransition.h
//  SNNavigationController
//
//  Created by snlo on 2018/10/23.
//  Copyright © 2018 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SNSelectedTabBarItemBlock)(void);

@interface UITabBarController (SNNavigationTransition) 

@property (nonatomic, copy) SNSelectedTabBarItemBlock selectedItemBlock;

@end

