//
//  Copyright (c) 2017-present, Yichi Zhang.
//
//  This source code is licensed under the MIT-style license found
//  in the LICENSE file in the root directory of this source tree.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
  var firstView: UIView? {
    return firstItem as? UIView
  }
  var secondView: UIView? {
    return secondItem as? UIView
  }
}
