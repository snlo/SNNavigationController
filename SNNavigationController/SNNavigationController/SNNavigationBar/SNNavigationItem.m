//
//  SNNavigationItem.m
//  SNNavigationController
//
//  Created by snlo on 2018/9/12.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "SNNavigationItem.h"

#import "SNNavigationControllerTool.h"

@implementation SNNavigationItem

#pragma mark -- getter / setter
- (UIColor *)barBackgroudColor {
    if (!_barBackgroudColor) {
        _barBackgroudColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    } return _barBackgroudColor;
}
- (void)setPrefersLargeTitles:(BOOL)prefersLargeTitles {
    _prefersLargeTitles = prefersLargeTitles;
    if (_prefersLargeTitles) {
        self.barHeight = ksNavigationBarHeight + ksLargeHeight;
    } else {
        self.barHeight = ksNavigationBarHeight;
    }
}

- (void)setShowSearchBar:(BOOL)showSearchBar {
    _showSearchBar = showSearchBar;
}

@end
