//
//  Extensions.swift
//  VerticalDoorTransitionAnimation
//
//  Created by Gennady on 11/3/16.
//  Copyright © 2016 Gennady. All rights reserved.
//

import UIKit

extension UIView {
    func mask(withRect rect: CGRect, inverse: Bool = false) {
        let path = UIBezierPath(rect: rect)
        let maskLayer = CAShapeLayer()
        
        if inverse {
            path.append(UIBezierPath(rect: self.bounds))
            maskLayer.fillRule = kCAFillRuleEvenOdd
        }
        
        maskLayer.path = path.cgPath
        
        self.layer.mask = maskLayer
    }
    
    func mask(withPath path: UIBezierPath, inverse: Bool = false) {
        let path = path
        let maskLayer = CAShapeLayer()
        
        if inverse {
            path.append(UIBezierPath(rect: self.bounds))
            maskLayer.fillRule = kCAFillRuleEvenOdd
        }
        
        maskLayer.path = path.cgPath
        
        self.layer.mask = maskLayer
    }
}

extension CGFloat {
    func topPartRect() -> CGRect {
        return CGRect(x: 0,y: 0,width:UIScreen.main.bounds.size.width, height:self)
    }
    
    func distanceToTop(view:UIView)->CGFloat {
        return self - view.frame.origin.y
    }
    
    func bottomPartRect() -> CGRect {
        return CGRect(x:0,y: self, width:UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.size.height - self)
    }
    
    func distanceToBottom(view:UIView)->CGFloat {
        return view.frame.size.height - self.distanceToTop(view: view)
    }

}
