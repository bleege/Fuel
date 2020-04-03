//
//  AddStopPresenter.swift
//  Fuel
//
//  Created by Brad Leege on 2/9/18.
//  Copyright © 2018 Brad Leege. All rights reserved.
//

import CoreLocation
import UIKit
import RxSwift
import RxCocoa
import os.log

class AddStopPresenter: AddStopContractPresenter {

    private weak var view:AddStopContractView?
    private var dataManager: FuelStopsDataManagerContract
    private let disposeBag = DisposeBag()
    
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
                .observeOn(MainScheduler.instance)
                .subscribe { event in
                    switch event {
                        case .success(let record):
                            self.view?.dismissAfterSave(record: FuelStop(record: record))
                        case .error(let error):
                            os_log(.error, log: Log.general, "Error Adding Fuel Stop: %@", error.localizedDescription)
                            self.view?.displayError(message: error.localizedDescription)
                        case .completed:
                            break
                        }
                    }.disposed(by: disposeBag)
        } else {
            os_log(.info, log: Log.general, "Form is not valid.")
        }
    }
}
