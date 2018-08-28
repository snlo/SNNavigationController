//
//  UIViewController+SNNavigationController.h
//  SNNavigationController
//
//  Created by snlo on 2018/8/23.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SNNavigationController)

/**
 包含了tabBarController.navigationController
 */
@property (nonatomic, strong) UINavigationController * sn_navigationController;

@end
