//
//  SNNavigationBar.m
//  SNNavigationController
//
//  Created by snlo on 2018/8/28.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "SNNavigationBar.h"

#define kIs_iPhoneX (SCREEN_HEIGHT / SCREEN_WIDTH > 2.1 ? YES : NO)

@implementation SNNavigationBar

- (instancetype)init
{
    self = [super init];
    if (self) {
		self.frame = CGRectMake(0, 0, SCREEN_WIDTH, (kIs_iPhoneX?44:20)+44);
        self.backgroundColor = [UIColor blueColor];
		[self loadInterFace];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)loadInterFace {
	
	[self labelTitle];
	
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
- (UILabel *)labelTitle {
	if (!_labelTitle) {
		_labelTitle = [[UILabel alloc] init];
		_labelTitle.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
		_labelTitle.frame = self.viewTitle.bounds;
		_labelTitle.textColor = [UIColor blackColor];
		_labelTitle.textAlignment = NSTextAlignmentCenter;
		[self.viewTitle addSubview:_labelTitle];
	} return _labelTitle;
}
- (UILabel *)labelMoveTile {
	if (!_labelMoveTile) {
		_labelMoveTile = [[UILabel alloc] init];
		_labelMoveTile.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
		_labelMoveTile.frame = self.viewTitle.bounds;
		_labelMoveTile.textColor = [UIColor blackColor];
		_labelMoveTile.textAlignment = NSTextAlignmentCenter;
		[self.viewTitle addSubview:_labelMoveTile];
	} return _labelMoveTile;
}

@end
