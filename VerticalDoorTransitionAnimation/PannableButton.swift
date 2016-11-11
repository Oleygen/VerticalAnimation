//
//  PannableButton.swift
//  VerticalDoorTransitionAnimation
//
//  Created by Gennady on 11/4/16.
//  Copyright © 2016 Gennady. All rights reserved.
//

import UIKit

protocol PannableButtonProtocol {
    func tapDidEnded(sender:PannableButton)
    func handlePan(recognizer:UIPanGestureRecognizer, sender:PannableButton)
}

class PannableButton: UIView {
    var delegate:PannableButtonProtocol?
    var tapRecognizer: UITapGestureRecognizer?
    var panRecognizer: UIPanGestureRecognizer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))

        self.addGestureRecognizer(tapRecognizer!)
        self.addGestureRecognizer(panRecognizer!)
    }
    
    func handleTap(recognizer:UITapGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.ended {
            delegate?.tapDidEnded(sender: self)
        }
    }
    
    func handlePan(recognizer:UIPanGestureRecognizer) {
        delegate?.handlePan(recognizer:recognizer, sender:self)
    }
}
