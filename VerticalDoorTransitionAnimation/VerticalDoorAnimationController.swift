//
//  VerticalDoorAnimationController.swift
//  SpaceAce
//
//  Created by Gennady.Oleynik on 10/27/16.
//  Copyright © 2016 Appus LLC. All rights reserved.
//

import UIKit

class VerticalDoorAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    var openCoordinate : CGFloat?
    var transitionDuration : CGFloat?
    var reversed = false

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        if let duration = transitionDuration {
            return TimeInterval(duration)
        }
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
                return
        }
        
        let containerView = transitionContext.containerView
        let distanceToTop = openCoordinate!.distanceToTop(view: toVC.view) - 44 - 20
        let distanceToBottom = openCoordinate!.distanceToBottom(view: toVC.view)

        if !reversed {
            guard let fromSnapshotTopPart = fromVC.view.snapshotView(afterScreenUpdates: false) else {
                return
            }
            fromSnapshotTopPart.mask(withRect: openCoordinate!.topPartRect())
            
            guard let fromSnapshotBottomPart = fromVC.view.snapshotView(afterScreenUpdates: false) else {
                return
            }
            fromSnapshotBottomPart.mask(withRect: openCoordinate!.bottomPartRect())
            
            
            
            ////////////////////////////
            
            toVC.view.transform = toVC.view.transform.translatedBy(x: 0, y: distanceToTop)
            
            containerView.addSubview(toVC.view)
            containerView.addSubview(fromSnapshotTopPart)
            containerView.addSubview(fromSnapshotBottomPart)
            
            ////////////////////////////
            
            
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                fromSnapshotTopPart.transform = fromSnapshotTopPart.transform.translatedBy(x: 0, y: -distanceToTop)
                toVC.view.transform = CGAffineTransform.identity
                fromSnapshotBottomPart.transform = fromSnapshotBottomPart.transform.translatedBy(x: 0, y:distanceToBottom)
            }) { _ in
                fromSnapshotBottomPart.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }

        } else {
            guard let toSnapshotTopPart = toVC.view.snapshotView(afterScreenUpdates: true) else {
                return
            }
            toSnapshotTopPart.mask(withRect: openCoordinate!.topPartRect())
            toSnapshotTopPart.transform = toSnapshotTopPart.transform.translatedBy(x: 0, y: -distanceToTop)
            guard let toSnapshotBottomPart = toVC.view.snapshotView(afterScreenUpdates: true) else {
                return
            }
            toSnapshotBottomPart.mask(withRect: openCoordinate!.bottomPartRect())
            toSnapshotBottomPart.transform = toSnapshotBottomPart.transform.translatedBy(x: 0, y: distanceToBottom)
            
             ////////////////////////////
            
            containerView.addSubview(toVC.view)
            containerView.addSubview(fromVC.view)
            containerView.addSubview(toSnapshotTopPart)
            containerView.addSubview(toSnapshotBottomPart)
            
             ////////////////////////////
            
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                toSnapshotTopPart.transform = CGAffineTransform.identity
                toSnapshotBottomPart.transform = CGAffineTransform.identity
            }) { _ in
                fromVC.view.removeFromSuperview()
                toSnapshotTopPart.removeFromSuperview()
                toSnapshotBottomPart.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
            

        }
        
    }
    
    
    
}
