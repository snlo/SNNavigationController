//
//  FirstViewController.m
//  SNNavigationController
//
//  Created by snlo on 2018/10/22.
//  Copyright © 2018 snlo. All rights reserved.
//

#import "FirstViewController.h"

#import "ViewControllerCell.h"

#import "InterViewController.h"

@interface FirstViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FirstViewController

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

#pragma mark -- <UITableViewDelegate, UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * identifier = @"ViewControllerCell";
    [tableView registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellReuseIdentifier:identifier];
    ViewControllerCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.textLabel.text = @"...";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    switch (indexPath.row) {
        case 0: {
            UIViewController * vc = [[UIViewController alloc] init];
            vc.title = @"空白页";
            vc.view.backgroundColor = [UIColor whiteColor];
            
            [self.sn_navigationController pushViewController:vc animated:YES];
        } break;
        default: {
            InterViewController * vc = [[InterViewController alloc] init];
            [self.sn_navigationController pushViewController:vc animated:YES];
        } break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -- CustomDelegate

#pragma mark -- event response

#pragma mark -- ___VARIABLE_moduleName___ methods

#pragma mark -- private methods
- (void)configureUserInterface {
    self.title = @"小标题导航栏";
    self.sn_navigationItem.barBackgroudColor = [UIColor colorWithRed:((arc4random()%255)/255.00) green:((arc4random()%255)/255.00) blue:((arc4random()%255)/255.00) alpha:1.0];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO; //隐藏滚动条
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 14, 0, 0); //设置分割线缩颈
    self.tableView.separatorColor = [UIColor colorWithRed:((arc4random()%255)/255.00) green:((arc4random()%255)/255.00) blue:((arc4random()%255)/255.00) alpha:1.0];
    
    
    UIButton * buttonRoot = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonRoot setTitle:@"首页" forState:UIControlStateNormal];
    
    self.sn_navigationItem.leftBarButtonItems = @[buttonRoot];
    
    [[buttonRoot rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
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
