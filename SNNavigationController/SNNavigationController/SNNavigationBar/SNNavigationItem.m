//
//  SNNavigationItem.m
//  SNNavigationController
//
//  Created by snlo on 2018/9/12.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "SNNavigationItem.h"

@implementation SNNavigationItem



#pragma mark -- getter / setter
- (UIColor *)barBackgroudColor {
    if (!_barBackgroudColor) {
        _barBackgroudColor = [UIColor whiteColor];
    } return _barBackgroudColor;
}
- (void)setPrefersLargeTitles:(BOOL)prefersLargeTitles {
    _prefersLargeTitles = prefersLargeTitles;
    if (_prefersLargeTitles) {
        self.barHeight = kNavigationBarHeight + 52;
    } else {
        self.barHeight = kNavigationBarHeight;
    }
}



@end
