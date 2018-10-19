//
//  SNNavigationBar.h
//  SNNavigationController
//
//  Created by snlo on 2018/8/28.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const ksLargeHeight = 52.00f;
static CGFloat const ksMargin = 16.00f;

@interface SNNavigationBar : UIView


/**
 标题视图
 */
@property (nonatomic, strong) UIView * viewTitle;
@property (nonatomic, strong) UILabel * labelTitle;
@property (nonatomic, strong) UILabel * labelFromTile;


/**
 大标题视图
 */
@property (nonatomic, strong) UIView * viewLargeTitle;
@property (nonatomic, strong) UILabel * labelLargeTitle;
@property (nonatomic, strong) UILabel * labelLargeFromTitle;


/**
 背景透明度
 */
@property (nonatomic, assign) CGFloat alhpaBackgroud;


/**
 分割线
 */
@property (nonatomic, strong) UIView * separatorLine;

/**
 搜索栏视图
 */
@property (nonatomic, strong) UIView * viewSearch;


/**
 设置首页强制大标题
 */
- (void)setForcePrefersLargeTitles;


/**
 左右按钮堆视图以及过渡视图
 */
@property (nonatomic, strong) UIView * viewLeftBarButtonStack;
@property (nonatomic, strong) UIView * viewFromLeftBarButtonStack;
@property (nonatomic, strong) UIView * viewRightBarButtonStack;
@property (nonatomic, strong) UIView * viewFromRightBarButtonStack;

/**
 左右按钮堆
 */
@property (nonatomic, strong) NSArray <UIButton *> *leftBarButtonItems;
@property (nonatomic, strong) NSArray <UIButton *> *leftFromBarButtonItems;
@property (nonatomic, strong) NSArray <UIButton *> *rightBarButtonItems;
@property (nonatomic, strong) NSArray <UIButton *> *rightFromBarButtonItems;

@end
