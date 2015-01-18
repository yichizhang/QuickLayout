/*
 Copyright (c) 2015 Yichi Zhang
 https://github.com/yichizhang
 zhang-yi-chi@hotmail.com
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "UIView+YZQuickLayout.h"

@implementation UIView (YZQuickLayout)

- (void)yz_quickLayoutInSuperviewWithPadding:(UIEdgeInsets)insets
{

	UIView *superView = self.superview;
	UIView *thisView = self;
	
	thisView.translatesAutoresizingMaskIntoConstraints = NO;
	
    NSLayoutConstraint* topConstraint;
    NSLayoutConstraint* leadingConstraint;
    NSLayoutConstraint* bottomConstraint;
    NSLayoutConstraint* trailingConstraint;
	
    topConstraint = [NSLayoutConstraint
        constraintWithItem:thisView
                 attribute:NSLayoutAttributeTop
                 relatedBy:NSLayoutRelationEqual
                    toItem:superView
                 attribute:NSLayoutAttributeTop
                multiplier:1.0f
                  constant:insets.top];
    leadingConstraint = [NSLayoutConstraint
        constraintWithItem:thisView
                 attribute:NSLayoutAttributeLeading
                 relatedBy:NSLayoutRelationEqual
                    toItem:superView
                 attribute:NSLayoutAttributeLeading
                multiplier:1.0f
                  constant:insets.left];
    bottomConstraint = [NSLayoutConstraint
        constraintWithItem:superView
                 attribute:NSLayoutAttributeBottom
                 relatedBy:NSLayoutRelationEqual
                    toItem:thisView
                 attribute:NSLayoutAttributeBottom
                multiplier:1.0f
                  constant:insets.bottom];
    trailingConstraint = [NSLayoutConstraint
        constraintWithItem:superView
                 attribute:NSLayoutAttributeTrailing
                 relatedBy:NSLayoutRelationEqual
                    toItem:thisView
                 attribute:NSLayoutAttributeTrailing
                multiplier:1.0f
                  constant:insets.right];
	
    [superView addConstraint:topConstraint];
    [superView addConstraint:leadingConstraint];
    [superView addConstraint:bottomConstraint];
    [superView addConstraint:trailingConstraint];
	
}

@end
