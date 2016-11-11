//
//  DragInteractionController.swift
//  VerticalDoorTransitionAnimation
//
//  Created by Gennady on 11/3/16.
//  Copyright © 2016 Gennady. All rights reserved.
//

import UIKit

class DragInteractionController: UIPercentDrivenInteractiveTransition {
    var interactionInProgress = false
    private var shouldCompleteTransition = false
    private weak var viewController: UIViewController!
    
    func wireToViewController(viewController: UIViewController!) {
        self.viewController = viewController
        prepareGestureRecognizerInView(view: viewController.view)
    }
    
    private func prepareGestureRecognizerInView(view: UIView) {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture))
        view.addGestureRecognizer(gesture)
    }
    
    func handleGesture(gestureRecognizer: UIPanGestureRecognizer) {
        
        // 1
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
        var progress = (translation.x / 200)
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        
        switch gestureRecognizer.state {
            
        case .began:
            // 2
            interactionInProgress = true
            viewController.dismiss(animated: true, completion: nil)
            
        case .changed:
            // 3
            shouldCompleteTransition = progress > 0.5
            update(progress)
            
        case .cancelled:
            // 4
            interactionInProgress = false
            cancel()
            
        case .ended:
            // 5
            interactionInProgress = false
            
            if !shouldCompleteTransition {
                cancel()
            } else {
                finish()
            }
            
        default:
            print("Unsupported")
        }
    }
}
