//
//  SNNavigationBar.m
//  SNNavigationController
//
//  Created by snlo on 2018/8/28.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "SNNavigationBar.h"

@implementation SNNavigationBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

@end
