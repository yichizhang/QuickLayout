//
// Created by Yichi on 21/02/2016.
// Copyright (c) 2016 Yichi. All rights reserved.
//

import UIKit

enum YZQLAttribute
{
	case T
	case Top
	case L
	case Left
	case B
	case Bottom
	case R
	case Right

	case W
	case Width
	case H
	case Height
	case cX
	case centerX
	case cY
	case centerY
}

class YZQLHelper
{
	class func _1stAttr(edge: YZQLAttribute) -> NSLayoutAttribute
	{
		switch edge {
		case .T, .Top:
			return NSLayoutAttribute.Top
		case .L, .Left:
			return NSLayoutAttribute.Leading
		case .B, .Bottom:
			return NSLayoutAttribute.Bottom
		case .R, .Right:
			return NSLayoutAttribute.Trailing
		case .W, .Width:
			return NSLayoutAttribute.Width
		case .H, .Height:
			return NSLayoutAttribute.Height
		case .cX, .centerX:
			return NSLayoutAttribute.CenterX
		case .cY, .centerY:
			return NSLayoutAttribute.CenterY
		}
	}
	class func _2ndAttr(edge: YZQLAttribute) -> NSLayoutAttribute
	{
		if (YZQLHelper.is2ndViewApplicable(edge)) {
			return YZQLHelper._1stAttr(edge)
		}
		else {
			return NSLayoutAttribute.NotAnAttribute
		}
	}
	class func is2ndViewApplicable(edge: YZQLAttribute) -> Bool
	{
		switch edge {
		case .W, .Width, .H, .Height:
			return false
		default:
			return true
		}
	}
}

extension UIView
{
	func yzql_attachEdges(side: CGFloat? = nil, topBottom: CGFloat? = nil,
	                      top: CGFloat = 0.0, left: CGFloat = 0.0,
	                      bottom: CGFloat = 0.0, right: CGFloat = 0.0) -> [NSLayoutConstraint]
	{
		var insets = UIEdgeInsetsZero
		if let side = side {
			insets.left = side
			insets.right = side
		}
		else {
			insets.left = left
			insets.right = right
		}
		if let topBottom = topBottom {
			insets.top = topBottom
			insets.bottom = topBottom
		}
		else {
			insets.top = top
			insets.bottom = bottom
		}
		return [yzql_attach(.T), yzql_attach(.L), yzql_attach(.B), yzql_attach(.R)];
	}

	func yzql_attach(edge: YZQLAttribute, to toView: UIView? = nil, on onEdge: YZQLAttribute? = nil,
	                 amt: CGFloat = 0.0, mul: CGFloat = 1.0) -> NSLayoutConstraint
	{
		self.translatesAutoresizingMaskIntoConstraints = false
		let constraint = NSLayoutConstraint(item: self,
		                                    attribute: YZQLHelper._1stAttr(edge),
		                                    relatedBy: .Equal,
		                                    toItem: toView != nil ? toView! : superview!,
		                                    attribute: onEdge != nil ?
		                                               YZQLHelper._1stAttr(onEdge!) :
		                                               YZQLHelper._1stAttr(edge),
		                                    multiplier: mul,
		                                    constant: amt)
		superview!.addConstraint(constraint)
		return constraint
	}

	func yzql_set(attr: YZQLAttribute, to toView: UIView? = nil, on onAttr: YZQLAttribute? = nil,
	              amt: CGFloat = 0.0, mul: CGFloat = 1.0) -> NSLayoutConstraint
	{
		self.translatesAutoresizingMaskIntoConstraints = false
		let attr2 = onAttr ?? attr
		let constraint = NSLayoutConstraint(item: self,
		                                    attribute: YZQLHelper._1stAttr(attr),
		                                    relatedBy: .Equal,
		                                    toItem: YZQLHelper.is2ndViewApplicable(attr2) ?
		                                            (toView != nil ? toView! : superview!) : nil,
		                                    attribute: YZQLHelper._2ndAttr(attr2),
		                                    multiplier: mul,
		                                    constant: amt)
		superview!.addConstraint(constraint)
		return constraint
	}

	// TODO: yzql_allTo(.L, .R, .B, on: )
	// TODO: yzql_all(
}
