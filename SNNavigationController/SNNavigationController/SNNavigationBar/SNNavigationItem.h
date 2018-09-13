//
//  SNNavigationItem.h
//  SNNavigationController
//
//  Created by snlo on 2018/9/12.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNNavigationItem : NSObject

//导航栏背景色，默认白色
@property (nonatomic, strong) UIColor * barBackgroudColor;
//标题色

//导航栏高度，默认
@property (nonatomic, assign) CGFloat barHeight;
//导航栏大标题，默认不是
@property (nonatomic, assign) BOOL prefersLargeTitles;

//首页强制大标题
@property (nonatomic, assign) BOOL forcePrefersLargeTitles;

@property (nonatomic, strong) NSArray <UIButton *> *leftBarButtonItems;
@property (nonatomic, strong) NSArray <UIButton *> *rightBarButtonItems;

@property (nonatomic, assign) CGPoint centerLabelTitle;

@end
