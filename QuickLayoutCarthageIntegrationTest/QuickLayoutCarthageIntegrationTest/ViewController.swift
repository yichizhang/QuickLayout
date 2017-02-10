//
//  Copyright (c) 2017-present, Yichi Zhang.
//
//  This source code is licensed under the MIT-style license found
//  in the LICENSE file in the root directory of this source tree.
//

import UIKit
import QuickLayout

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let v = UIView()
    v.backgroundColor = .blue
    view.addSubview(v)
    
    v.ql_edges(inset: UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40))
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

