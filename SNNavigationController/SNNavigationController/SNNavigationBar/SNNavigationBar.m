//
//  SNNavigationBar.m
//  SNNavigationController
//
//  Created by snlo on 2018/8/28.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "SNNavigationBar.h"

#import "SNNavigationControllerTool.h"

@interface SNNavigationBar ()

@end

@implementation SNNavigationBar

- (instancetype)init
{
    self = [super init];
    if (self) {
		self.frame = CGRectMake(0, 0, ks_SCREEN_WIDTH, (ksIs_iPhoneX?44:20)+44);
        self.backgroundColor = [UIColor whiteColor];
		[self loadInterFace];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)loadInterFace {
	
    self.layer.masksToBounds = YES;
	[self labelTitle];
    [self separatorLine];

    [RACObserve(self.labelTitle, text) subscribeNext:^(NSString * _Nullable x) {
        [self updateTitleLabel:self.labelTitle];
    }];
    [RACObserve(self.labelFromTile, text) subscribeNext:^(NSString * _Nullable x) {
        [self updateTitleLabel:self.labelFromTile];
    }];
    [RACObserve(self, frame) subscribeNext:^(id  _Nullable x) {
        self.separatorLine.frame = CGRectMake(0, self.bounds.size.height-0.5, ks_SCREEN_WIDTH, 0.5);
        [self insertSubview:self.separatorLine atIndex:self.subviews.count];
    }];
	
}

- (void)updateTitleLabel:(UILabel *)label {
    CGSize size = [label sizeThatFits:CGSizeMake(ks_SCREEN_WIDTH, MAXFLOAT)];
    CGFloat width = (size.width + 1) > (self.viewTitle.bounds.size.width) ? (self.viewTitle.bounds.size.width) : (size.width + 1);
    label.frame = CGRectMake(label.center.x-width/2, label.center.y-(size.height+1)/2, width, size.height +1);
}
- (void)clearAlloc:(id)object {
    object = nil;
}
- (void)updateBarButtonItems:(NSArray <UIButton *> *)buttonItems from:(UIView *)barButtonItemsView atLeft:(BOOL)left {
    __block CGFloat width = 0;
    [barButtonItemsView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [barButtonItemsView.subviews makeObjectsPerformSelector:@selector(clearAlloc:)];
    [buttonItems enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGSize size = [obj.titleLabel sizeThatFits:CGSizeMake(ks_SCREEN_WIDTH, MAXFLOAT)];
        CGFloat X = width;
        CGFloat WIDTH = size.width + obj.imageView.image.size.width;
        WIDTH = obj.frame.size.width > 0 ? obj.frame.size.width : WIDTH + 1;
        width += WIDTH + 8;
        obj.frame = CGRectMake(8+X, 0, WIDTH, 44);
        [obj setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [barButtonItemsView addSubview:obj];
    }];
	if (buttonItems.count < 1) {
		width = 0;
	} else {
		width += 8;
	}
    barButtonItemsView.frame = CGRectMake(left?8:(ks_SCREEN_WIDTH-(width+8)), ksIs_iPhoneX?44:20, width, 44);
}

- (void)setForcePrefersLargeTitles:(BOOL)isPrefersLargeTitles {
    self.frame = CGRectMake(0, 0, ks_SCREEN_WIDTH, ksNavigationBarHeight + ksLargeHeight);
	self.viewLargeTitle.hidden = NO;
	self.viewTitle.hidden = YES;
}

#pragma mark -- getter / setter
- (UIView *)viewTitle {
	if (!_viewTitle) {
		_viewTitle = [[UIView alloc] init];
		_viewTitle.frame = CGRectMake(ksMargin, ksIs_iPhoneX?44:20, ks_SCREEN_WIDTH-ksMargin*2, 44);
		_viewTitle.backgroundColor = [UIColor clearColor];
		[self addSubview:_viewTitle];
        
	} return _viewTitle;
}
- (UILabel *)labelTitle {
	if (!_labelTitle) {
		_labelTitle = [[UILabel alloc] init];
        _labelTitle.center = CGPointMake(ks_SCREEN_WIDTH/2, (ksIs_iPhoneX?44:20) + 22);
		_labelTitle.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
		_labelTitle.textColor = [UIColor blackColor];
		_labelTitle.textAlignment = NSTextAlignmentCenter;
		[self insertSubview:_labelTitle aboveSubview:self.viewTitle];
	} return _labelTitle;
}
- (UILabel *)labelFromTile {
	if (!_labelFromTile) {
		_labelFromTile = [[UILabel alloc] init];
		_labelFromTile.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
		_labelFromTile.textColor = [UIColor blackColor];
		_labelFromTile.textAlignment = NSTextAlignmentCenter;
        _labelFromTile.hidden = YES;
		[self insertSubview:_labelFromTile aboveSubview:self.viewTitle];
	} return _labelFromTile;
}


- (UIView *)separatorLine {
    if (!_separatorLine) {
        _separatorLine = [[UIView alloc] init];
        _separatorLine.frame = CGRectMake(0, self.bounds.size.height, ks_SCREEN_WIDTH, 0.5f);
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.frame = _separatorLine.bounds;
        imageView.backgroundColor = [UIColor colorWithRed:0.00f green:0.00f blue:0.00f alpha:0.30f];
        [_separatorLine addSubview:imageView];
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
        _viewFromLeftBarButtonStack = [[UIView alloc] init];
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
    [self updateBarButtonItems:_leftBarButtonItems from:self.viewLeftBarButtonStack atLeft:YES];
}
- (void)setLeftFromBarButtonItems:(NSArray<UIButton *> *)leftFromBarButtonItems {
    _leftFromBarButtonItems = leftFromBarButtonItems;
    [self updateBarButtonItems:_leftFromBarButtonItems from:self.viewFromLeftBarButtonStack atLeft:YES];
}
- (void)setRightBarButtonItems:(NSArray<UIButton *> *)rightBarButtonItems {
    _rightBarButtonItems = rightBarButtonItems;
    [self updateBarButtonItems:_rightBarButtonItems from:self.viewRightBarButtonStack atLeft:NO];
}
- (void)setRightFromBarButtonItems:(NSArray<UIButton *> *)rightFromBarButtonItems {
    _rightFromBarButtonItems = rightFromBarButtonItems;
    [self updateBarButtonItems:_rightFromBarButtonItems from:self.viewFromRightBarButtonStack atLeft:NO];
}

//大标题
- (UIView *)viewLargeTitle {
	if (!_viewLargeTitle) {
		_viewLargeTitle = [[UIView alloc] init];
		_viewLargeTitle.frame = CGRectMake(0, ksNavigationBarHeight, ks_SCREEN_WIDTH, ksLargeHeight);
		_viewLargeTitle.backgroundColor = [UIColor clearColor];
        _viewLargeTitle.layer.masksToBounds = YES;
		[self addSubview:_viewLargeTitle];
	} return _viewLargeTitle;
}
- (UILabel *)labelLargeTitle {
	if (!_labelLargeTitle) {
		_labelLargeTitle = [[UILabel alloc] init];
		_labelLargeTitle.frame = CGRectMake(ksMargin, 0, ks_SCREEN_WIDTH-ksMargin*2, ksLargeHeight);
        _labelLargeTitle.font = [UIFont systemFontOfSize:24 weight:UIFontWeightMedium];
		[self.viewLargeTitle addSubview:_labelLargeTitle];
	} return _labelLargeTitle;
}
- (UILabel *)labelLargeFromTitle {
	if (!_labelLargeFromTitle) {
		_labelLargeFromTitle = [[UILabel alloc] init];
		_labelLargeFromTitle.frame = CGRectMake(ksMargin, 0, ks_SCREEN_WIDTH-ksMargin*2, ksLargeHeight);
        _labelLargeFromTitle.font = [UIFont systemFontOfSize:24 weight:UIFontWeightMedium];
        _labelLargeFromTitle.hidden = YES;
		[self.viewLargeTitle addSubview:_labelLargeFromTitle];
	} return _labelLargeFromTitle;
}

- (UIView *)viewSearch {
	if (!_viewSearch) {
		_viewSearch = [[UIView alloc] init];
		_viewSearch.frame = CGRectMake(0, ksNavigationBarHeight + ksLargeHeight, ks_SCREEN_WIDTH, ksLargeHeight);
		_viewSearch.backgroundColor = [UIColor whiteColor];
        [self insertSubview:_viewSearch aboveSubview:self.viewLargeTitle];
	} return _viewSearch;
}

@end
