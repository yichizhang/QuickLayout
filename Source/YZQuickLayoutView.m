/*
 Copyright (c) 2014 Yichi Zhang
 https://github.com/yichizhang
 zhang-yi-chi@hotmail.com
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "YZQuickLayoutView.h"

@interface YZQuickLayoutView ()

@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, strong) NSArray *subviewsToQuickLayout;
@property (nonatomic, strong) NSArray *quickLayoutSettings;

@property (nonatomic, strong) NSArray *quickLayoutProcessedPortionValues;

@property (nonatomic, assign) CGFloat quickLayoutMode;
@property (nonatomic, strong) UIView* paddingView;

@end

@implementation YZQuickLayoutView

#pragma mark - Initialization

- (void)setUp{
	
	self.paddingView = [[UIView alloc] initWithFrame:CGRectZero];
	
	[self addSubview:self.paddingView];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if (self) {
		[self setUp];
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self setUp];
	}
	return self;
}

#pragma mark - Set Up

- (void)processPortionValues{
	
	__block CGFloat totalValues = 0.0f;
	__block CGFloat defaultValue = 1.0f;
	
	[self.quickLayoutSettings
	 enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		 
		 CGFloat thisValue;
		 
		 if ([obj isKindOfClass:[NSNumber class]]) {
			 thisValue = [obj floatValue];
		 }else {
			 thisValue = defaultValue;
		 }
		 
		 totalValues += thisValue;
	 }];
	
	NSMutableArray *tempMutableArray = [NSMutableArray array];
	
	[self.quickLayoutSettings
	 enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		 
		 [tempMutableArray addObject:[NSNumber numberWithFloat:[obj floatValue]/totalValues]];
		 
	 }];
	
	self.quickLayoutProcessedPortionValues = [NSArray arrayWithArray:tempMutableArray];
	
}

- (void)setQuickLayoutMode:(YZQuickLayoutMode)mode forViews:(NSArray *)views withPadding:(CGFloat)padding andSettings:(NSArray *)quickLayoutSettings{
	
	_quickLayoutMode = mode;
	_padding = padding;
	
	_subviewsToQuickLayout = views;
	_quickLayoutSettings = quickLayoutSettings;
	
	[self processPortionValues];
	
	[self reloadViews];
}

#pragma mark - Layout

- (void)layoutSubviews{
 
	[super layoutSubviews];
	
	self.paddingView.frame = CGRectInset(self.bounds, self.padding, self.padding);
	
	
	__block CGFloat currentX = 0.0f;
	__block CGFloat currentY = 0.0f;
	
	[self.subviewsToQuickLayout
	 enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		 
		 UIView *view = obj;
		 
		 CGSize thisItemSize = [self sizeForItemAtIndex:idx];
		 
		 view.frame = CGRectMake(currentX, currentY, thisItemSize.width, thisItemSize.height);
		 
		 if (self.quickLayoutMode == YZQuickLayoutModeVertical) {
			 currentY += thisItemSize.height;
		 }else if (self.quickLayoutMode == YZQuickLayoutModeHorizontal) {
			 currentX += thisItemSize.width;
		 }
	 }];
	
}

- (CGSize)sizeForItemAtIndex:(NSUInteger)idx{
	
	CGFloat thisWidth = 0.0f;
	CGFloat thisHeight = 0.0f;
	
	NSNumber *value = self.quickLayoutProcessedPortionValues[idx];
	CGFloat portion = [value floatValue];
	
	CGFloat parentWidth = self.paddingView.bounds.size.width;
	CGFloat parentHeight = self.paddingView.bounds.size.height;
	
	if (self.quickLayoutMode == YZQuickLayoutModeVertical) {
		thisWidth = parentWidth;
		thisHeight = parentHeight * portion;
	}else if (self.quickLayoutMode == YZQuickLayoutModeHorizontal) {
		thisWidth = parentWidth * portion;
		thisHeight = parentHeight;
	}
	
	return CGSizeMake(thisWidth, thisHeight);
	
}

- (void)reloadViews{

	[self.subviewsToQuickLayout enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		UIView *view = obj;
		
		[view removeFromSuperview];
		
		[self.paddingView addSubview:view];
	}];
	
	[self setNeedsLayout];
	
}

@end
