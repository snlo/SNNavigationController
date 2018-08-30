//
//  SNTransitionInteractionController.h
//  SNNavigationController
//
//  Created by snlo on 2018/8/30.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNTransitionInteractionController : UIPercentDrivenInteractiveTransition

typedef NS_ENUM(NSInteger, SNTransitionInteractionOperation) {
    /**
     Indicates that the interaction controller should start a navigation controller 'pop' navigation.
     */
    SNTransitionInteractionOperationPop,
    /**
     Indicates that the interaction controller should initiate a modal 'dismiss'.
     */
    SNTransitionInteractionOperationDismiss,
    /**
     Indicates that the interaction controller should navigate between tabs.
     */
    SNTransitionInteractionOperationTab
};

/**
 Connects this interaction controller to the given view controller.
 */
- (void)wireToViewController:(UIViewController*)viewController forOperation:(SNTransitionInteractionOperation)operation;

/**
 是否正在进行交互转场
 */
@property (nonatomic, assign) BOOL interactionInProgress;

@end
