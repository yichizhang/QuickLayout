//
//  CalendarItemView.m
//  YZQuickLayoutDemo
//
//  Created by Yichi on 8/12/2014.
//  Copyright (c) 2014 Yichi Zhang. All rights reserved.
//

#import "CalendarItemView.h"

@implementation CalendarItemView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setUp{
	
	[super setUp];
	
	self.monthLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	self.dayLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	
	[self setQuickLayoutMode:YZQuickLayoutModeVertical
					forViews:@[self.monthLabel, self.dayLabel]
				 withPadding:10.0
				 andSettings:@[@(30), @(70)]
	 ];
	
}

@end
