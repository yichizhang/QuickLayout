//
//  Copyright (c) 2017-present, Yichi Zhang.
//
//  This source code is licensed under the MIT-style license found
//  in the LICENSE file in the root directory of this source tree.
//

import UIKit

public struct EdgeConstraints {
  var top: NSLayoutConstraint?
  var left: NSLayoutConstraint?
  var bottom: NSLayoutConstraint?
  var right: NSLayoutConstraint?
}

public extension UIView {
  @discardableResult
  func ql_edges(
    _ edges: UIRectEdge = UIRectEdge.all,
    insetH: CGFloat,
    insetV: CGFloat) -> EdgeConstraints {
    let inset = UIEdgeInsets(top: insetV, left: insetH, bottom: insetV, right: insetH)
    return ql_edges(edges, inset: inset)
  }

  @discardableResult
  func ql_edges(
    _ edges: UIRectEdge = UIRectEdge.all,
    uniformInset: CGFloat) -> EdgeConstraints {
    return ql_edges(edges, inset: UIEdgeInsets(top: uniformInset, left: uniformInset, bottom: uniformInset, right: uniformInset))
  }

  @discardableResult
  func ql_edges(
    _ edges: UIRectEdge = UIRectEdge.all,
    inset: UIEdgeInsets = UIEdgeInsets.zero) -> EdgeConstraints {
    translatesAutoresizingMaskIntoConstraints = false

    var constraints = EdgeConstraints()

    if edges.contains(.top) {
      constraints.top =
        ql_attribute(.top, constant: inset.top)
    }
    if edges.contains(.left) {
      constraints.left =
        ql_attribute(.leading, constant: inset.left)
    }
    if edges.contains(.bottom) {
      constraints.bottom =
        ql_attribute(.bottom, constant: -inset.bottom)
    }
    if edges.contains(.right) {
      constraints.right =
        ql_attribute(.trailing, constant: -inset.right)
    }

    return constraints
  }

  @discardableResult
  func ql_attribute(
    _ attribute: NSLayoutAttribute,
    relation: NSLayoutRelation = .equal,
    toView: UIView? = nil,
    on toViewAttribute: NSLayoutAttribute? = nil,
    multiplier: CGFloat = 1.0,
    constant: CGFloat = 0.0,
    priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
    translatesAutoresizingMaskIntoConstraints = false

    let constraint = NSLayoutConstraint(
      item: self,
      attribute: attribute,
      relatedBy: relation,
      toItem: toView ?? superview!,
      attribute: toViewAttribute ?? attribute,
      multiplier: multiplier,
      constant: constant)
    constraint.priority = priority
    superview!.addConstraint(constraint)

    return constraint
  }

  @discardableResult
  func ql_set(
    _ attribute: NSLayoutAttribute,
    relation: NSLayoutRelation = .equal,
    multiplier: CGFloat = 1.0,
    constant: CGFloat = 0.0,
    priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
    translatesAutoresizingMaskIntoConstraints = false

    let constraint = NSLayoutConstraint(
      item: self,
      attribute: attribute,
      relatedBy: relation,
      toItem: nil,
      attribute: .notAnAttribute,
      multiplier: multiplier,
      constant: constant)
    constraint.priority = priority
    superview!.addConstraint(constraint)
    
    return constraint
  }
}
