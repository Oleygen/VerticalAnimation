//
//  FirstViewController.swift
//  VerticalDoorTransitionAnimation
//
//  Created by Gennady on 11/3/16.
//  Copyright © 2016 Gennady. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UINavigationControllerDelegate, PannableButtonProtocol {
    
    @IBOutlet var pannableButtons: [PannableButton]!
    
    let verticalDoorAnimationController = VerticalDoorAnimationController()
    private let dragInteractionController = DragInteractionController()

    override func viewDidLoad() {
        super.viewDidLoad()
        pannableButtons.forEach {[unowned self] (button)  in
                
            button.delegate = self
        }
        self.navigationController?.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        dragInteractionController.wireToViewController(viewController: segue.destination)

    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        verticalDoorAnimationController.reversed = operation == UINavigationControllerOperation.pop
        return verticalDoorAnimationController
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return dragInteractionController.interactionInProgress ? dragInteractionController : nil
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: PannableButtonDelegate
    
    func handlePan(recognizer: UIPanGestureRecognizer, sender: PannableButton) {
        
    }
    
    func tapDidEnded(sender: PannableButton) {
        verticalDoorAnimationController.openCoordinate = sender.frame.origin.y + sender.frame.size.height
        verticalDoorAnimationController.transitionDuration = 0.4
        self.performSegue(withIdentifier:"segue", sender: nil)
    }

}
