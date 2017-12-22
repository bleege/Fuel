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
    
    private var view: OverviewViewController?
    
    let dataManager = (UIApplication.shared.delegate as! AppDelegate).dataManager
    
    init() {
        // No Op
    }
    
    func onAttach(viewController: OverviewViewController) {
        self.view = viewController
        loadFuelStops()
    }
    
    func onDetach() {
        self.view = nil
    }
    
    func loadFuelStops() {
        let fuelStops = dataManager.getAllFuelStops()
        print("number of fuelStops found = \(fuelStops.count)")
        view?.fuelStops.removeAll()
        view?.fuelStops.append(contentsOf: fuelStops)
    }
}
