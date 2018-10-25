//
//  UITabBarController+SNNavigationTransition.h
//  SNNavigationController
//
//  Created by snlo on 2018/10/23.
//  Copyright © 2018 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SNNASelectedTabBarItemBlock)(void);

@interface UITabBarController (SNNavigationTransition) 

/**
 点击 item 的回调
 */
@property (nonatomic, copy) SNNASelectedTabBarItemBlock sn_selectedItemBlock;

@end

