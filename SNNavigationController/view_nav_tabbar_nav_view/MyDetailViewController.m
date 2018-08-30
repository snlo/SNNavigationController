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

#import "UIViewController+SNNavigationTransition.h"

#import "SNNavigationPopTransitionAnimation.h"
#import "SNNavigationPushTransitionAnimation.h"

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
    
//    [self startLeftScreenEdgePanGesture];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.title = @"详情页";
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"000000");
    
    // 加入左侧边界手势
    
//    [self startLeftScreenEdgePanGesture];
    
    self.navigationController.delegate = self;
    UIScreenEdgePanGestureRecognizer * leftScreenEdgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftScreenEdgePanGesturess:)];

    leftScreenEdgePan.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:leftScreenEdgePan];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleButton:(id)sender {
    NSLog(@"%@",[self.sn_navigationController popViewControllerAnimated:YES]);
}

- (void)handleLeftScreenEdgePanGesturess:(UIScreenEdgePanGestureRecognizer *)gesture {
    
    CGFloat progress = [gesture translationInView:self.view].x / self.view.bounds.size.width / 2;
    [self updateState:gesture.state progress:progress forViewController:self];
}


- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
        return [[SNNavigationPopTransitionAnimation alloc] init];
    }
    if (operation == UINavigationControllerOperationPush) {
        return [[SNNavigationPushTransitionAnimation alloc] init];
    }
    return nil;
}
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    
    if([animationController isKindOfClass:[SNNavigationPopTransitionAnimation class]]){
        return self.percentDrivenTransition;
    } else {
        return nil;
    }
}

- (void)updateState:(UIGestureRecognizerState)state progress:(CGFloat)progress forViewController:(UIViewController *)viewController {
    switch (state) {
        case UIGestureRecognizerStateBegan: {
            self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
            [viewController.navigationController popViewControllerAnimated:YES];
        } break;
        case UIGestureRecognizerStateChanged: {
            [self.percentDrivenTransition updateInteractiveTransition:progress];
        } break;
        case UIGestureRecognizerStateCancelled: case UIGestureRecognizerStateEnded: {
            if(progress > 0.2){
                [self.percentDrivenTransition finishInteractiveTransition];
            }else{
                [self.percentDrivenTransition cancelInteractiveTransition];
            }
            self.percentDrivenTransition = nil;
        } break;
        default: {
            
        } break;
    }
}

@end
