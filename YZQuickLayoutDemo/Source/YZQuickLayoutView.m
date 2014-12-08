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

#pragma mark - Layout

- (void)layoutSubviews{
 
	[super layoutSubviews];
	
	self.paddingView.frame = CGRectInset(self.bounds, self.padding, self.padding);
	
	CGFloat parentWidth = self.paddingView.bounds.size.width;
	CGFloat parentHeight = self.paddingView.bounds.size.height;
	
	__block CGFloat currentX = 0;
	__block CGFloat currentY = 0;
	__block CGFloat thisWidth = 0;
	__block CGFloat thisHeight = 0;
	
	[self.subviewsToQuickLayout
	 enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		 
		 UIView *view = obj;
		 NSNumber *value = self.quickLayoutSettings[idx];
		 CGFloat portion = [value floatValue];
		 
		 if (self.quickLayoutMode == YZQuickLayoutModeVertical) {
			 thisWidth = parentWidth;
			 thisHeight = parentHeight * portion;
		 }else if (self.quickLayoutMode == YZQuickLayoutModeHorizontal) {
			 thisWidth = parentWidth * portion;
			 thisHeight = parentHeight;
		 }
		 
		 view.frame = CGRectMake(currentX, currentY, thisWidth, thisHeight);
		 
		 if (self.quickLayoutMode == YZQuickLayoutModeVertical) {
			 currentY += thisHeight;
		 }else if (self.quickLayoutMode == YZQuickLayoutModeHorizontal) {
			 currentX += thisWidth;
		 }
	 }];
	
}

- (void)setQuickLayoutMode:(YZQuickLayoutMode)mode forViews:(NSArray *)views withPadding:(CGFloat)padding andSettings:(NSArray *)quickLayoutSettings{
	
	_quickLayoutMode = mode;
	_padding = padding;
	
	_subviewsToQuickLayout = views;
	_quickLayoutSettings = quickLayoutSettings;
	
	[self reloadViews];
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
