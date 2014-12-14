//
//  DemoSegmentedView.swift
//  YZQuickLayoutDemo
//
//  Created by Yichi on 14/12/2014.
//  Copyright (c) 2014 Yichi Zhang. All rights reserved.
//

import UIKit

@objc class DemoSegmentedView: YZQuickLayoutView {

	var segmentItems: Array<AnyObject>!
	var optionViews: Array<UIView>!
	var optionViewsSettings: Array<Float>!
	
	var setUpViewForNormalState: ((UIView)->())!
	var setUpViewForSelectedState: ((UIView)->())!
	var tapGestureRecognizer: UITapGestureRecognizer!

	private var privateViewAtIndexIsTapped: ((UIView, Int)->())!
	var viewAtIndexIsTapped: ((UIView, Int)->())!
	
	override func setUp() {
		
		super.setUp()
		
		tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "thisViewIsTapped:")
		self.addGestureRecognizer(tapGestureRecognizer)
		
	}
	
	override func removeFromSuperview() {
		
		self.removeGestureRecognizer(tapGestureRecognizer)
		super.removeFromSuperview()
		
	}
	
	func updateDemoSegmentViews() {
		
		//segmentItems = [DemoStyleKit.imageOfPDF, "Duck", "Penguin"]
		
		optionViews = []
		optionViewsSettings = []
		
		for obj in segmentItems {
			
			if( obj.isKindOfClass(NSString) ){
				
				var label = UILabel()
				label.text = obj as? String
				optionViews.append(label)
				optionViewsSettings.append(2)
				
			}else if( obj.isKindOfClass(UIImage) ){
				
				var imageView = UIImageView(image: obj as? UIImage)
				
				optionViews.append(imageView)
				optionViewsSettings.append(1)

			}else{
				
				var label = UILabel()
				label.text = "?"
				optionViews.append(label)
				optionViewsSettings.append(2)
				
			}
			
		}
		
		/*
		setUpViewForNormalState = {
			(view: UIView)->() in
			
			if (view.isKindOfClass(UILabel)){
				
				let label = view as UILabel
				label.backgroundColor = UIColor.blueColor()
				label.textColor = UIColor.whiteColor()
				label.textAlignment = NSTextAlignment.Center
				
			}else if (view.isKindOfClass(UIImageView)){
				
				let imageView = view as UIImageView
				imageView.backgroundColor = UIColor.blueColor()
				imageView.contentMode = UIViewContentMode.Center
				
			}
		}
		setUpViewForSelectedState = {
			(view: UIView)->() in
			
			if (view.isKindOfClass(UILabel)){
				
				let label = view as UILabel
				label.backgroundColor = UIColor.redColor()
				label.textColor = UIColor.whiteColor()
				
			}else if (view.isKindOfClass(UIImageView)){
				
				let imageView = view as UIImageView
				imageView.backgroundColor = UIColor.redColor()
				imageView.contentMode = UIViewContentMode.Center
				
			}
			
		}
		*/
		privateViewAtIndexIsTapped = {
			(view:UIView, idx:Int)->() in
			
			for view1: UIView in self.optionViews {
				self.setUpViewForNormalState?(view1);
			}
			
			self.setUpViewForSelectedState?(view);
		}
		
		
		self.setQuickLayoutMode(
			YZQuickLayoutModeHorizontal,
			forViews: optionViews,
			withPadding: 5,
			andSettings: optionViewsSettings
		);
		
		for view: UIView in optionViews {
			setUpViewForNormalState?(view);
		}
		
	}
	
	func thisViewIsTapped(recognizer: UITapGestureRecognizer)->(){
		
		let touchInView:CGPoint = recognizer.locationInView(self)
		let touchRect:CGRect = CGRectMake(touchInView.x, touchInView.y, 1, 1)
		var idx:Int = 0
		
		for view: UIView in optionViews {
			
			if CGRectIntersectsRect(view.frame, touchRect){
				privateViewAtIndexIsTapped?(view, idx);
			}
			idx++;
		}
		
	}

}
