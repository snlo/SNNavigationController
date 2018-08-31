//
//  MyDetailViewController.m
//  SNNavigationController
//
//  Created by snlo on 2018/8/27.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "MyDetailViewController.h"


@interface MyDetailViewController () <UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

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
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    self.sn_leftScreenEdgePanGesture.enabled = NO;
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.title = @"详情页";
    
    self.view.backgroundColor = [UIColor whiteColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleButton:(id)sender {
    NSLog(@"%@",[self.sn_navigationController popViewControllerAnimated:YES]);
}
- (IBAction)handlePushButton:(id)sender {
    UIViewController * VC = [[UIViewController alloc] init];
    VC.view.backgroundColor = [UIColor greenColor];
    [self.navigationController pushViewController:VC animated:YES];
}



@end
