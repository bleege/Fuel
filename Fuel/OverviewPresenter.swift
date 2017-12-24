//
//  OverviewPresenter.swift
//  Fuel
//
//  Created by Brad Leege on 12/20/17.
//  Copyright © 2017 Brad Leege. All rights reserved.
//

import Foundation
import UIKit

class OverviewPresenter: OverviewContractPresenter {
    
    private var view: OverviewContractView?
    
    let dataManager = (UIApplication.shared.delegate as! AppDelegate).dataManager
    
    init() {
        // No Op
    }
    
    func onAttach(view: OverviewContractView) {
        self.view = view
        loadFuelStops()
    }
    
    func onDetach() {
        self.view = nil
    }
    
    // MARK: OverviewContractPresenter
    
    func loadFuelStops() {
        let fuelStops = dataManager.getAllFuelStops()
        print("number of fuelStops found = \(fuelStops.count)")
        view?.displayStops(fuelStops: fuelStops)
    }
}
