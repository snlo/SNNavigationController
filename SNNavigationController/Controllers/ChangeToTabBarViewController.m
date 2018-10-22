//
//  ChangeToTabBarViewController.m
//  SNNavigationController
//
//  Created by snlo on 2018/10/22.
//  Copyright © 2018 snlo. All rights reserved.
//

#import "ChangeToTabBarViewController.h"

@interface ChangeToTabBarViewController ()

@end

@implementation ChangeToTabBarViewController

#pragma mark -- life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // update form data
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // update position
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // do something
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // add subviews
    [self configureUserInterface];
    
    // add dataSource configure
    [self configureDataSource];
}

- (void)updateViewConstraints {
    
    // update position
    
    [super updateViewConstraints];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // set autolayout
}

#pragma mark -- <UITableViewDelegate>、、

#pragma mark -- CustomDelegate

#pragma mark -- event response

#pragma mark -- ___VARIABLE_moduleName___ methods

#pragma mark -- private methods
- (void)configureUserInterface {
    self.title = @"选择跳转";
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"root" forState:UIControlStateNormal];
    self.sn_navigationItem.rightBarButtonItems = @[button];
    self.sn_navigationItem.rightBarButtonItems = @[button];
    
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
}
- (void)configureDataSource {
    
    [self updateDataSource];
    
}
- (void)updateDataSource {
    
}

#pragma mark -- getter setter


@end
