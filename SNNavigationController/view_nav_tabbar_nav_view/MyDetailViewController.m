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
@property (weak, nonatomic) IBOutlet UIView *viewTest;

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
    
	self.sn_rightScreenEdgePanGesture.enabled = YES;
    
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.title = @"详情页";
    self.sn_navigationBarBackgroudColor = [UIColor blueColor];
//    self.sn_prefersLargeTitles = YES;
    self.sn_navigationBarHeight = 100;
    
    self.view.backgroundColor = [UIColor whiteColor];

    [RACObserve(self.tableView, contentOffset) subscribeNext:^(id  _Nullable x) {
        NSLog(@"77777777");
    }];
    [RACObserve(self.tableView, contentOffset) subscribeNext:^(id  _Nullable x) {
        NSLog(@"888888888");
    }];
	
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
	self.viewTest.layer.shadowColor = [UIColor redColor].CGColor;
	self.viewTest.layer.shadowOpacity = 0.2f;
	self.viewTest.layer.shadowOffset = CGSizeMake(3, 0);
	self.viewTest.layer.shadowRadius = 8;
	
	self.navigationController.sn_navigationBar.backgroundColor = [UIColor clearColor];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"00 00 0 0 0");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleButton:(id)sender {
    NSLog(@"----- -- ---------- --- - %@",self.tableView.constraints);
	NSLog(@"%@",self.sn_leftScreenEdgePanGesture);
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
    [self.navigationController pushViewController:VC animated:YES];
}



@end
