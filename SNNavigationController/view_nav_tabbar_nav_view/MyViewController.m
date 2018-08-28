//
//  MyViewController.m
//  SNNavigationController
//
//  Created by snlo on 2018/8/27.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "MyViewController.h"

#import "MyDetailViewController.h"

#import "UIViewController+SNNavigationController.h"

#import "SNNavigationControllerTool.h"

@interface MyViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MyViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 98);
    [SNNavigationControllerTool sharedManager].navigationBar = view;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.title = @"我的";
	
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)handlePushButton:(UIButton *)sender {
    MyDetailViewController * VC = [[MyDetailViewController alloc] init];
	[self.sn_navigationController pushViewController:VC animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
