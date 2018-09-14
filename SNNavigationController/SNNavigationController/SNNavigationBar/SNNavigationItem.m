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
        _barBackgroudColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
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

//- (CGPoint)centerLabelTitle {
//    if (_centerLabelTitle.x < 1) {
//        _centerLabelTitle = CGPointMake(SCREEN_WIDTH / 2, 44/2);
//    } return _centerLabelTitle;
//}
//- (CGPoint)centerLabelFromTitle {
//    if (_centerLabelFromTitle.x < 1) {
//        _centerLabelFromTitle = CGPointMake(SCREEN_WIDTH / 2, 44/2);
//    } return _centerLabelFromTitle;
//}



@end
