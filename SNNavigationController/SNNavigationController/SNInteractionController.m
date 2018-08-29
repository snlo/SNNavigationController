//
//  SNInteractionController.m
//  SNNavigationController
//
//  Created by snlo on 2018/8/29.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "SNInteractionController.h"

@implementation SNInteractionController

- (void)wireToViewController:(UIViewController *)viewController forOperation:(CEInteractionOperation)operation {
    
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
    
}

@end
