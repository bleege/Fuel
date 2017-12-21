//
//  OverviewPresenter.swift
//  Fuel
//
//  Created by Brad Leege on 12/20/17.
//  Copyright © 2017 Brad Leege. All rights reserved.
//

import Foundation
import UIKit

class OverviewPresenter {
    
    private var view: UIViewController?
    
    let dataManager = (UIApplication.shared.delegate as! AppDelegate).dataManager
    
    init() {
        // No Op
    }
    
    func onAttach(viewController: UIViewController) {
        self.view = viewController
        
        let fuelStops = dataManager.getAllFuelStops()
        print("number of fuelStops found = \(fuelStops.count)")
    }
    
    func onDetach() {
        self.view = nil
    }
    
}
