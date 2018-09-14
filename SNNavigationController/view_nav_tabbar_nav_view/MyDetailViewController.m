//
//  MyDetailViewController.m
//  SNNavigationController
//
//  Created by snlo on 2018/8/27.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "MyDetailViewController.h"

#import "ViewControllerCell.h"

@interface MyDetailViewController () <UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *viewTest;

@property (weak, nonatomic) IBOutlet UILabel *labelTest;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition * percentDrivenTransition;

@property (nonatomic, weak) SNNavigationTransitionDelegate * sn_navigationDelegate;

@end

@implementation MyDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.title = @"详情页";
    
    self.sn_navigationItem.barBackgroudColor = [UIColor whiteColor];
    self.sn_navigationItem.prefersLargeTitles = YES;
    self.sn_rightScreenEdgePanGesture.enabled = YES;
    self.sn_pullScreenBackPanGesture.enabled = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"sssssss" forState:UIControlStateNormal];
    
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setTitle:@"ddddd" forState:UIControlStateNormal];
    
//    self.sn_navigationController.sn_navigationBar.leftBarButtonItems = @[button,button1];
    
    self.sn_navigationItem.leftBarButtonItems = @[button];
    self.sn_navigationItem.rightBarButtonItems = @[button1];
    
	self.viewTest.layer.shadowColor = [UIColor redColor].CGColor;
	self.viewTest.layer.shadowOpacity = 0.2f;
	self.viewTest.layer.shadowOffset = CGSizeMake(3, 0);
	self.viewTest.layer.shadowRadius = 8;
	
	self.navigationController.sn_navigationBar.backgroundColor = [UIColor clearColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO; //隐藏滚动条
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 14, 0, 0); //设置分割线缩颈
    self.tableView.separatorColor = [UIColor redColor]; //分割线颜色
    self.tableView.allowsSelection = NO; //cell交互
    self.tableView.delaysContentTouches = NO; //延迟（能让cell上的事件响应灵敏，但也会带来交互误触的弊端）
}
- (void)test:(UIBarButtonItem *)sender {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleButton:(id)sender {
    
    NSLog(@"%@",self.labelTest.constraints);
    
//    NSLog(@"%@",[self.sn_navigationController popViewControllerAnimated:YES]);
//	[CATransaction begin];
//	[CATransaction setDisableActions:YES];
////	[CATransaction setAnimationDuration:3.0];
//	self.viewTest.layer.shadowOffset = CGSizeMake(10, 10);
//	[CATransaction commit];
	
	
//	CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"shadowOffset"];
//	anim.toValue = [NSValue valueWithCGSize:CGSizeMake(10, 10)];
//	anim.duration = 3.0;
//	anim.beginTime = 0;
//	anim.removedOnCompletion = NO;
//	anim.fillMode = kCAFillModeForwards;
//	[self.viewTest.layer addAnimation:anim forKey:@"animName"];
	
	[UIView animateWithDuration:3.0 animations:^{
		self.viewTest.alpha = 0.0f;
	}];
}
- (IBAction)handlePushButton:(id)sender {
    UIViewController * VC = [[UIViewController alloc] init];
    VC.view.backgroundColor = [UIColor greenColor];
	VC.title = @"什么👻";
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"asd" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleASDbutton:) forControlEvents:UIControlEventTouchUpInside];
    VC.sn_navigationItem.leftBarButtonItems = @[button];
    VC.sn_pullScreenBackPanGesture.enabled = YES;
    VC.sn_navigationItem.prefersLargeTitles = NO;
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)handleASDbutton:(UIButton *)sender {
    NSLog(@"sdjandgjnalg");
    [self.sn_navigationController popViewControllerAnimated:YES];
}

#pragma mark -- <UITableViewDelegate, UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * identifier = @"ViewControllerCell";
    [tableView registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellReuseIdentifier:identifier];
    ViewControllerCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
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
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
