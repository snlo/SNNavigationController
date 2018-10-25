//
//  SNNavigationControllerTool.h
//  SNNavigationController
//
//  Created by snlo on 2018/8/23.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <objc/runtime.h>
#import <objc/message.h>

#import <Masonry.h>
#import <ReactiveObjC.h>
#import <Aspects.h>

#import "SNNa_Singletion.h"

#define ksIs_iPhoneX (ks_SCREEN_HEIGHT / ks_SCREEN_WIDTH > 2.1 ? YES : NO)
#define ksNavigationBarHeight (ksIs_iPhoneX ? 88:64)

#define ks_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define ks_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define ksLargeHeight 52.00f
#define ksMargin 16.00f

snna_singletonInterface(SNNavigationControllerTool)

/**
 函数替换，不能被替换将被交换。
 */
void snna_replaceMethod(Class aClass, SEL aMethod, Class newClass, SEL newMethod);


/**
 设置颜色透明度
 */
+ (UIColor *)setColor:(UIColor *)color alpha:(CGFloat)alpha;

@end
