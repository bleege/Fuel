//
//  StopDetailPresentationManager.swift
//  Fuel
//
//  Created by Brad Leege on 1/22/18.
//  Copyright © 2018 Brad Leege. All rights reserved.
//

import UIKit

class StopDetailPresentationManager: NSObject, UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        return StopDetailPresentationController(presentedViewController: presented, presenting: presenting)
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return StopDetailPresentationAnimator(isPresenting: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return StopDetailPresentationAnimator(isPresenting: false)
    }
    
}
