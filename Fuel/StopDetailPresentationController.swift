//
//  StopDetailPresentationController.swift
//  Fuel
//
//  Created by Brad Leege on 1/22/18.
//  Copyright © 2018 Brad Leege. All rights reserved.
//

import UIKit

class StopDetailPresentationController: UIPresentationController {
    
    // Give size of presented view controller to presenting view controller
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width, height: parentSize.height * (2.0 / 3.0))
    }
    
    // Set frame of presented view controller
    override var frameOfPresentedViewInContainerView: CGRect {
        var frame: CGRect = .zero
        frame.size = size(forChildContentContainer: presentedViewController,
                          withParentContainerSize: containerView!.bounds.size)
        frame.origin.y = containerView!.frame.height * (1.0 / 3.0)
        return frame
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        
        let ovc = self.presentingViewController as! OverviewViewController
        ovc.refreshMap()
    }
}
