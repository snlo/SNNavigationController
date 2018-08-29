//
//  SNInteractionController.h
//  SNNavigationController
//
//  Created by snlo on 2018/8/29.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNInteractionController : UIPercentDrivenInteractiveTransition

typedef NS_ENUM(NSInteger, CEInteractionOperation) {
    /**
     Indicates that the interaction controller should start a navigation controller 'pop' navigation.
     */
    CEInteractionOperationPop,
    /**
     Indicates that the interaction controller should initiate a modal 'dismiss'.
     */
    CEInteractionOperationDismiss,
    /**
     Indicates that the interaction controller should navigate between tabs.
     */
    CEInteractionOperationTab
};

/**
 Connects this interaction controller to the given view controller.
 @param viewController The view controller which this interaction should add a gesture recognizer to.
 @param operation The operation that this interaction initiates when.
 */
- (void)wireToViewController:(UIViewController*)viewController forOperation:(CEInteractionOperation)operation;

/**
 This property indicates whether an interactive transition is in progress.
 */
@property (nonatomic, assign) BOOL interactionInProgress;

@end
