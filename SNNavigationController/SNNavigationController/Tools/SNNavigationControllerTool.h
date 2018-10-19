//
//  SNNavigationControllerTool.h
//  SNNavigationController
//
//  Created by snlo on 2018/8/23.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SNNa_Singletion.h"

#define ksIs_iPhoneX (SCREEN_HEIGHT / SCREEN_WIDTH > 2.1 ? YES : NO)
#define ksNavigationBarHeight (ksIs_iPhoneX ? 88:64)

snna_singletonInterface(SNNavigationControllerTool)

/**
 函数替换，不能被替换将被交换。
 */
void snna_replaceMethod(Class aClass, SEL aMethod, Class newClass, SEL newMethod);

@end
