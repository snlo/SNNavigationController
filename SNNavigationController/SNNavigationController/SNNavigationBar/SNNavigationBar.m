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
		self.frame = CGRectMake(0, 0, SCREEN_WIDTH, (kIs_iPhoneX?44:20)+44);
        self.backgroundColor = [UIColor whiteColor];
		[self loadInterFace];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)loadInterFace {
	
	[self labelToTitle];
}

#pragma mark -- getter / setter
- (UIView *)viewTitle {
	if (!_viewTitle) {
		_viewTitle = [[UIView alloc] init];
		_viewTitle.frame = CGRectMake(0, kIs_iPhoneX?44:20, SCREEN_WIDTH, 44);
		_viewTitle.backgroundColor = [UIColor clearColor];
		[self addSubview:_viewTitle];
	} return _viewTitle;
}
- (UILabel *)labelToTitle {
	if (!_labelToTitle) {
		_labelToTitle = [[UILabel alloc] init];
		_labelToTitle.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
        _labelToTitle.frame = self.viewTitle.bounds;
//        _labelToTitle.center = self.viewTitle.center;
		_labelToTitle.textColor = [UIColor blackColor];
		_labelToTitle.textAlignment = NSTextAlignmentCenter;
		[self.viewTitle addSubview:_labelToTitle];
	} return _labelToTitle;
}
- (UILabel *)labelFromTile {
	if (!_labelFromTile) {
		_labelFromTile = [[UILabel alloc] init];
		_labelFromTile.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
		_labelFromTile.frame = self.viewTitle.bounds;
		_labelFromTile.textColor = [UIColor blackColor];
		_labelFromTile.textAlignment = NSTextAlignmentCenter;
		[self.viewTitle addSubview:_labelFromTile];
	} return _labelFromTile;
}

@end
