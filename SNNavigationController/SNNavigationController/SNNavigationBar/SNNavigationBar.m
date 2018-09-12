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
	
    
	[self labelTitle];
    [self separatorLine];
    
    [RACObserve(self.labelTitle, text) subscribeNext:^(NSString * _Nullable x) {
        [self updateTitleLabel:self.labelTitle];
    }];
    [RACObserve(self.labelFromTile, text) subscribeNext:^(NSString * _Nullable x) {
        [self updateTitleLabel:self.labelFromTile];
    }];
    [RACObserve(self, frame) subscribeNext:^(id  _Nullable x) {
        self.separatorLine.frame = CGRectMake(0, self.bounds.size.height, SCREEN_WIDTH, 0.5);
    }];
}

- (void)updateTitleLabel:(UILabel *)label {
    CGSize size = [label sizeThatFits:CGSizeMake(SCREEN_WIDTH, MAXFLOAT)];
    CGFloat width = (size.width + 1) > (self.viewTitle.bounds.size.width-20) ? (self.viewTitle.bounds.size.width-20) : (size.width + 1);
    label.frame = CGRectMake(0, 0, width, size.height +1);
    label.center = CGPointMake(self.viewTitle.bounds.size.width/2, self.viewTitle.bounds.size.height/2);
}
- (void)updateBarButtonItems:(NSArray <UIButton *> *)buttonItems from:(UIView *)barButtonItemsView {
    __block CGFloat width = 0;
    [buttonItems enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGSize size = [obj.titleLabel sizeThatFits:CGSizeMake(SCREEN_WIDTH, MAXFLOAT)];
        CGFloat X = width;
        CGFloat WIDTH = size.width + obj.imageView.image.size.width;
        if (obj.frame.size.width > 0) {
            WIDTH = obj.frame.size.width;
        }
        width += WIDTH + 8;
        [barButtonItemsView addSubview:obj];
        obj.frame = CGRectMake(8+X, 0, WIDTH+1, 44);
        [obj setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }];
    barButtonItemsView.frame = CGRectMake(8, kIs_iPhoneX?44:20, width+8, 44);
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
		_labelTitle.textColor = [UIColor blackColor];
		_labelTitle.textAlignment = NSTextAlignmentCenter;
		[self.viewTitle addSubview:_labelTitle];
        
	} return _labelTitle;
}
- (UILabel *)labelFromTile {
	if (!_labelFromTile) {
		_labelFromTile = [[UILabel alloc] init];
		_labelFromTile.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
		_labelFromTile.textColor = [UIColor blackColor];
		_labelFromTile.textAlignment = NSTextAlignmentCenter;
		[self.viewTitle addSubview:_labelFromTile];
        
	} return _labelFromTile;
}

- (void)setalhpaBackgroud:(CGFloat)alhpaBackgroud {
    _alhpaBackgroud = alhpaBackgroud;
    self.backgroundColor = [self.backgroundColor colorWithAlphaComponent:_alhpaBackgroud];
}

- (UIView *)separatorLine {
    if (!_separatorLine) {
        _separatorLine = [[UIView alloc] init];
        _separatorLine.backgroundColor = [UIColor colorWithWhite:0.766 alpha:1.0f];
        _separatorLine.frame = CGRectMake(0, self.bounds.size.height, SCREEN_WIDTH, 1.000f/3);
        [self addSubview:_separatorLine];
    } return _separatorLine;
}



- (UIView *)viewLeftBarButtonStack {
    if (!_viewLeftBarButtonStack) {
        _viewLeftBarButtonStack = [[UIView alloc] init];
        [self addSubview:_viewLeftBarButtonStack];
    } return _viewLeftBarButtonStack;
}
- (UIView *)viewFromLeftBarButtonStack {
    if (!_viewFromLeftBarButtonStack) {
        NSData * archiveData = [NSKeyedArchiver archivedDataWithRootObject:self.viewLeftBarButtonStack];
        _viewFromLeftBarButtonStack = [NSKeyedUnarchiver unarchiveObjectWithData:archiveData];
        [self addSubview:_viewFromLeftBarButtonStack];
    } return _viewFromLeftBarButtonStack;
}
- (UIView *)viewRightBarButtonStack {
    if (!_viewRightBarButtonStack) {
        _viewRightBarButtonStack = [[UIView alloc] init];
        [self addSubview:_viewRightBarButtonStack];
    } return _viewRightBarButtonStack;
}
- (UIView *)viewFromRightBarButtonStack {
    if (!_viewFromRightBarButtonStack) {
        _viewFromRightBarButtonStack = [[UIView alloc] init];
        [self addSubview:_viewFromRightBarButtonStack];
    } return _viewFromRightBarButtonStack;
}
- (void)setLeftBarButtonItems:(NSArray<UIButton *> *)leftBarButtonItems {
    _leftBarButtonItems = leftBarButtonItems;
    [self updateBarButtonItems:_leftBarButtonItems from:self.viewLeftBarButtonStack];
}
- (void)setRightBarButtonItems:(NSArray<UIButton *> *)rightBarButtonItems {
    _rightBarButtonItems = rightBarButtonItems;
    [self updateBarButtonItems:_rightBarButtonItems from:self.viewRightBarButtonStack];
}

@end
