//
//  ViewController.m
//  YZQuickLayoutDemo
//
//  Created by Yichi on 8/12/2014.
//  Copyright (c) 2014 Yichi Zhang. All rights reserved.
//

#import "ViewController.h"
#import "CalendarItemView.h"
#import "YZQuickLayoutDemo-Swift.h"
#import "UIView+YZQuickLayout.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet DemoSegmentedView *demoSegmentedView;
@property (weak, nonatomic) IBOutlet CalendarItemView *calendarItemView;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	UIView *redView = [[UIView alloc] initWithFrame:CGRectZero];
	redView.backgroundColor = [UIColor redColor];
	[self.view addSubview:redView];
	[self.view sendSubviewToBack:redView];
	[redView yz_quickLayoutInSuperviewWithPadding:UIEdgeInsetsMake(5, 10, 15, 20)];
	
	self.calendarItemView.monthLabel.backgroundColor = [UIColor blueColor];
	self.calendarItemView.dayLabel.backgroundColor = [UIColor yellowColor];
	
	self.demoSegmentedView.segmentItems = @[[DemoStyleKit imageOfPDF], @"Duck", @"Penguin", [DemoStyleKit imageOfImage], @"Cat"];
	
	self.demoSegmentedView.setUpViewForNormalState = ^(UIView* view){
		if ([view isKindOfClass:[UILabel class]]) {
			UILabel *label = (UILabel*)view;
			
			label.font = [UIFont boldSystemFontOfSize:12.0f];
			label.textAlignment = NSTextAlignmentCenter;
			label.textColor = [UIColor lightGrayColor];
		} else if ([view isKindOfClass:[UIImageView class]]) {
			UIImageView *imageView = (UIImageView*)view;
			
			imageView.contentMode = UIViewContentModeCenter;
			imageView.backgroundColor = [UIColor clearColor];
			
		}
	};
	
	self.demoSegmentedView.setUpViewForSelectedState = ^(UIView* view){
		if ([view isKindOfClass:[UILabel class]]) {
			UILabel *label = (UILabel*)view;
			
			label.textColor = [UIColor purpleColor];
		} else if ([view isKindOfClass:[UIImageView class]]) {
			UIImageView *imageView = (UIImageView*)view;
			
			imageView.backgroundColor = [UIColor purpleColor];
		}
	};
	
	[self.demoSegmentedView updateDemoSegmentViews];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
