//
//  AddStopPresenter.swift
//  Fuel
//
//  Created by Brad Leege on 2/9/18.
//  Copyright © 2018 Brad Leege. All rights reserved.
//

import Combine
import CoreLocation
import UIKit
import os.log

class AddStopPresenter: AddStopContractPresenter {

    private weak var view:AddStopContractView?
    private var dataManager: FuelStopsDataManagerContract
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.dataManager = (UIApplication.shared.delegate as! AppDelegate).dataManager
    }
    
    init(dataManager: FuelStopsDataManagerContract) {
        self.dataManager = dataManager
    }    
    
    func onAttach(view: AddStopContractView) {
        self.view = view
    }

    func onDetach() {
        self.view = nil
    }
 
    func handleCancelTap() {
        view?.dismiss()
    }
    
    func handleSaveTap() {
        if (view?.validateForm())! {
            os_log(.info, log: Log.general, "Form is valid, so can save.")
            
            guard let location = view?.locationData(),
                let gallons = view?.gallonsData(),
                let octane = view?.octaneData(),
                let odometer = view?.odometerData(),
                let price = view?.priceData(),
                let ppg = view?.ppgData(),
                let stopDate = view?.stopDateData(),
                let tripOdometer = view?.tripOdometerData() else {
                os_log(.info, log: Log.general, "Missing Trip Data to save.")
                return
            }
            
            dataManager
                .addFuelStop(gallons: gallons,
                             latitude: (location.coordinate.latitude),
                             longitude: (location.coordinate.longitude),
                             octane: octane,
                             odometer: odometer,
                             price: price,
                             ppg: ppg,
                             stopDate: stopDate,
                             tripOdometer: tripOdometer)
                .subscribe(on: DispatchQueue.global())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        os_log(.error, log: Log.general, "Error Adding Fuel Stop: %@", error.localizedDescription)
                    case .finished:
                        break
                    }
                }, receiveValue: { value in
                    self.view?.dismissAfterSave(record: FuelStop(record: value))
                }).store(in: &cancellables)
        } else {
            os_log(.info, log: Log.general, "Form is not valid.")
        }
    }
}
