//
//  MyDetailViewController.m
//  SNNavigationController
//
//  Created by snlo on 2018/8/27.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "MyDetailViewController.h"

#import "UIViewController+SNNavigationController.h"
#import "UINavigationController+SNNavigationController.h"

@interface MyDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MyDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.sn_navigationController.sn_navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.sn_navigationController.sn_navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.title = @"详情页";
	
    self.view.backgroundColor = [UIColor redColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleButton:(id)sender {
    
//    [self.sn_navigationController popViewControllerAnimated:YES];
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
