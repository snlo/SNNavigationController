//
//  SNNavigationControllerTool.h
//  SNNavigationController
//
//  Created by snlo on 2018/8/23.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Singletion.h"

//@interface SNNavigationControllerTool : NSObject

singletonInterface(SNNavigationControllerTool)

/**
 函数替换，不能被替换将被交换。
 */
void replaceMethod(Class aClass, SEL aMethod, Class newClass, SEL newMethod);

@property (nonatomic, strong) UIView * navigationBar;


@end
