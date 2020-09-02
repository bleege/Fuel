//
//  OverviewPresenter.swift
//  Fuel
//
//  Created by Brad Leege on 12/20/17.
//  Copyright © 2017 Brad Leege. All rights reserved.
//

import Foundation
import UIKit
import Combine
import os.log

class OverviewPresenter: OverviewContractPresenter {
    
    private weak var view: OverviewContractView?
    
    private var dataManager: FuelStopsDataManagerContract
        
    init() {
        self.dataManager = (UIApplication.shared.delegate as! AppDelegate).dataManager
    }
    
    init(dataManager: FuelStopsDataManagerContract) {
        self.dataManager = dataManager
    }
    
    // MARK: - OverviewContractPresenter
    
    func onAttach(view: OverviewContractView) {
        self.view = view
    }
    
    func onDetach() {
        self.view = nil
    }
    
    func loadFuelStops() {
        
        dataManager.getAllFuelStops()
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .failure(let error):
                        os_log(.error, log: Log.general, "Error loading Fuel Stops: %@", error.localizedDescription)
                        self.view?.displayError(message: "Error getting fuel stops.")
                    case .finished:
                        os_log(.info, log: Log.general, "Finished getAllFuelStops")
                }
            }, receiveValue: { elements in
                var stops = [FuelStop]()
                for ckr in elements {
                    stops.append(FuelStop(record: ckr))
                }
                self.view?.displayStops(fuelStops: stops)
            })
    }
    
    func handleStopSelection(index: Int) {
        view?.displayStopOnMap(index: index)
        view?.displayStopDataView(index: index)
    }
 
    func handleAddStopFABTap() {
        view?.zoomToUserLocation()
        view?.displayAddStopViewController()
    }
}
