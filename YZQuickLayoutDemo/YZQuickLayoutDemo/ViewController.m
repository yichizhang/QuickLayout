//
//  ViewController.m
//  YZQuickLayoutDemo
//
//  Created by Yichi on 8/12/2014.
//  Copyright (c) 2014 Yichi Zhang. All rights reserved.
//

#import "ViewController.h"
#import "CalendarItemView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet CalendarItemView *calendarItemView;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.calendarItemView.monthLabel.backgroundColor = [UIColor blueColor];
	self.calendarItemView.dayLabel.backgroundColor = [UIColor yellowColor];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
