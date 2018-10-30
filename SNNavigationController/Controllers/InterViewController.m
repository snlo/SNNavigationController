//
//  InterViewController.m
//  SNNavigationController
//
//  Created by snlo on 2018/10/22.
//  Copyright © 2018 snlo. All rights reserved.
//

#import "InterViewController.h"

#import "ViewControllerCell.h"

@interface InterViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation InterViewController

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
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * identifier = @"ViewControllerCell";
    [tableView registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellReuseIdentifier:identifier];
    ViewControllerCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    switch (indexPath.row) {
        case 0: {
            cell.textLabel.text = @"小标题导航栏";
        } break;
        case 1: {
            cell.textLabel.text = @"带搜索栏的小标题导航栏";
        } break;
        case 2: {
            cell.textLabel.text = @"大标题导航栏";
        } break;
        case 3: {
            cell.textLabel.text = @"带搜索栏的大标题导航栏";
        } break;
        default: {
            cell.textLabel.text = @"...";
        } break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
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
    
    InterViewController * vc = [[InterViewController alloc] init];
    
    switch (indexPath.row) {
        case 0: {
            vc.sn_navigationItem.prefersLargeTitles = NO;
        } break;
        case 1: {
            vc.sn_navigationItem.prefersLargeTitles = NO;
            [vc setSearchBarWith:78];
        } break;
        case 2: {
            vc.sn_navigationItem.prefersLargeTitles = YES;
        } break;
        case 3: {
            vc.sn_navigationItem.prefersLargeTitles = YES;
            [vc setSearchBarWith:100];
        } break;
        default:
            break;
    }
    
    [self.sn_navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -- CustomDelegate

#pragma mark -- event response

#pragma mark -- ___VARIABLE_moduleName___ methods

#pragma mark -- private methods
- (void)configureUserInterface {
    self.title = @"详情页";
    
    
    self.isShowSystemNavigationBar = YES;
    self.isShowSNNavigationBar = YES;
    self.isShowCustomNavigationBar = YES;
    
    self.sn_navigationItem.barBackgroudColor = [UIColor colorWithRed:((arc4random()%255)/255.00) green:((arc4random()%255)/255.00) blue:((arc4random()%255)/255.00) alpha:1.0];
    self.sn_pullScreenBackPanGesture.enabled = YES;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO; //隐藏滚动条
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 14, 0, 0); //设置分割线缩颈
    self.tableView.separatorColor = [UIColor colorWithRed:((arc4random()%255)/255.00) green:((arc4random()%255)/255.00) blue:((arc4random()%255)/255.00) alpha:1.0];
    
    
    UIButton * buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonBack setTitle:@"返回" forState:UIControlStateNormal];
    UIButton * buttonRoot = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonRoot setTitle:@"首页" forState:UIControlStateNormal];
    self.sn_navigationItem.leftBarButtonItems = @[buttonBack];
    self.sn_navigationItem.rightBarButtonItems = @[buttonRoot];
    
    [[buttonBack rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self.sn_navigationController popViewControllerAnimated:YES];
    }];
    [[buttonRoot rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIButton * buttonRootx = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonRootx setTitle:@"回到首页" forState:UIControlStateNormal];
//        [UIView animateWithDuration:0.3 animations:^{
//            self.sn_navigationItem.leftBarButtonItems = @[buttonRootx];
//            self.sn_navigationItem.barBackgroudColor = [UIColor redColor];
//
//        }];
//        self.sn_navigationItem.barBackgroudColor = [SNNavigationControllerTool setColor:self.sn_navigationItem.barBackgroudColor alpha:0.00];
        self.sn_navigationController.sn_navigationBar.separatorLine.hidden = YES;
    });
    
    
}
- (void)configureDataSource {
    
    [self updateDataSource];
    
}
- (void)updateDataSource {
    
}

#pragma mark -- getter setter

@end
