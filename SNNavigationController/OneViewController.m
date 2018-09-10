//
//  OneViewController.m
//  SNNavigationController
//
//  Created by snlo on 2018/9/6.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "OneViewController.h"

@interface OneViewController () <UIGestureRecognizerDelegate>

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	// 删除导航栏左侧按钮
	self.navigationItem.leftBarButtonItem = nil;
	
	// 导航栏添加右侧按钮
	self.navigationItem.leftBarButtonItem = ({
		UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_nav_list.png"]
																	 style:UIBarButtonItemStyleDone target:self action:@selector(backButtonAction:)];
		rightBtn;
	});

	self.navigationController.interactivePopGestureRecognizer.delegate = self;
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
	if (self.navigationController.viewControllers.count < 1 ) {
		return NO;
	}
	return YES;
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
