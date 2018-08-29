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

#import "UINavigationController+SNNavigationController.h"

@interface MyViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MyViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.title = @"我的";
	
    self.sn_navigationController.sn_navigationBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    UILabel *label = [[UILabel alloc] init];
    label.text = @"左标题";
    label.textColor = [UIColor blackColor];
    [self.sn_navigationController.sn_navigationBar addSubview:label];
    [label mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.sn_navigationController.sn_navigationBar.mas_top).offset(0);
        make.left.equalTo(self.sn_navigationController.sn_navigationBar.mas_left).offset(20);
        make.bottom.equalTo(self.sn_navigationController.sn_navigationBar.mas_bottom).offset(-20);
        make.right.equalTo(self.sn_navigationController.sn_navigationBar.mas_right).offset(0);
    }];
    [RACObserve(self.tableView, contentOffset) subscribeNext:^(id  _Nullable x) {
        CGFloat X = self.tableView.contentOffset.y;
        if (X > SCREEN_WIDTH/2) {
            X = SCREEN_WIDTH/2;
        }
        if (X < 0) {
            X = 0;
        }
        label.transform = CGAffineTransformMakeTranslation(X, -self.tableView.contentOffset.y);
    }];
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
