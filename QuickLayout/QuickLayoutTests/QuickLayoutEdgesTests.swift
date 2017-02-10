//
//  Copyright (c) 2017-present, Yichi Zhang.
//
//  This source code is licensed under the MIT-style license found
//  in the LICENSE file in the root directory of this source tree.
//

import Nimble
import Quick
@testable import QuickLayout

class QuickLayoutEdgesTests: QuickSpec {
  override func spec() {
    describe("ql_edges") {
      var view: UIView!
      var subView: UIView!
      var e: EdgeConstraints!
      
      beforeEach {
        view = UIView(frame: CGRect(x: 0, y: 0, width: 1500, height: 900))
        subView = UIView()
        
        view.addSubview(subView)
        
        e = subView.ql_edges(.all, inset: UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40))
      }
      
      it("adds all constraints") {
        expect([e.top, e.left, e.bottom, e.right]).to(equal(view.constraints))
      }
      
      it("has correct constraints") {
        expect(e.top?.firstView).to(equal(subView))
        expect(e.top?.secondView).to(equal(view))
        expect(e.top?.constant).to(equal(10))
        
        expect(e.left?.firstView).to(equal(subView))
        expect(e.left?.secondView).to(equal(view))
        expect(e.left?.constant).to(equal(20))
        
        expect(e.bottom?.firstView).to(equal(subView))
        expect(e.bottom?.secondView).to(equal(view))
        expect(e.bottom?.constant).to(equal(-30))
        
        expect(e.right?.firstView).to(equal(subView))
        expect(e.right?.secondView).to(equal(view))
        expect(e.right?.constant).to(equal(-40))
      }
    }
  }
}
