//
//  OtherTestViewController.m
//  SNNavigationController
//
//  Created by snlo on 2018/9/11.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "OtherTestViewController.h"

@interface OtherTestViewController ()

@end

@implementation OtherTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.sn_navigationController.sn_navigationBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"xxxxxxxxxxxxxxxxxxxxxxxxAxxxxxxxxxxxxxxxxxxxxxxxxxx";
    
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.navigationItem.leftBarButtonItems = @[[[UIBarButtonItem alloc] initWithTitle:@"xxxxxxxx" style:UIBarButtonItemStyleDone target:self action:@selector(test:)], [[UIBarButtonItem alloc] initWithTitle:@"sssssssddddddddd" style:UIBarButtonItemStyleDone target:self action:@selector(test:)]];
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithTitle:@"xxxxxxxx" style:UIBarButtonItemStyleDone target:self action:@selector(test:)], [[UIBarButtonItem alloc] initWithTitle:@"sssssdd" style:UIBarButtonItemStyleDone target:self action:@selector(test:)]];
}

- (void)test:(UIBarButtonItem *)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
