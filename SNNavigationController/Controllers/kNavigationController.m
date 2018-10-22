//
//  kNavigationController.m
//  SNNavigationController
//
//  Created by snlo on 2018/10/22.
//  Copyright © 2018 snlo. All rights reserved.
//

#import "kNavigationController.h"

@interface kNavigationController ()

@end

@implementation kNavigationController

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
    self.view.backgroundColor = [UIColor redColor];
}
- (void)configureDataSource {
    
    [self updateDataSource];
    
}
- (void)updateDataSource {
    
}

#pragma mark -- getter setter


@end
