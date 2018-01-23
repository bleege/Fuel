//
//  StopDetailPresentationAnimator.swift
//  Fuel
//
//  Created by Brad Leege on 1/22/18.
//  Copyright © 2018 Brad Leege. All rights reserved.
//

import UIKit

class StopDetailPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    var isPresenting: Bool
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        let key = isPresenting ? UITransitionContextViewControllerKey.to : UITransitionContextViewControllerKey.from
        let controller = transitionContext.viewController(forKey: key)!
        
        if isPresenting {
            transitionContext.containerView.addSubview(controller.view)
        }
        
        let presentedFrame = transitionContext.finalFrame(for: controller)
        var dismissedFrame = presentedFrame
        dismissedFrame.origin.y = transitionContext.containerView.frame.size.height
        
        let initialFrame = isPresenting ? dismissedFrame : presentedFrame
        let finalFrame = isPresenting ? presentedFrame : dismissedFrame
        
        let animationDuration = transitionDuration(using: transitionContext)
        controller.view.frame = initialFrame
        UIView.animate(withDuration: animationDuration, animations: {
            controller.view.frame = finalFrame
        }) { finished in
            transitionContext.completeTransition(finished)
        }

    }
}
