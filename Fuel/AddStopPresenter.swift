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

class AddStopPresenter: AddStopContractPresenter {

    private weak var view:AddStopContractView?
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
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
            print("Form is valid, so can save.")
            
            guard let loc = appDelegate.currentLocation else {
                print("Current Location not found.")
                return
            }
            
            guard let gallons = view?.gallonsData(),
                let octane = view?.octaneData(),
                let odometer = view?.odometerData(),
                let price = view?.priceData(),
                let ppg = view?.ppgData(),
                let stopDate = view?.stopDateData(),
                let tripOdometer = view?.tripOdometerData() else {
                print("Missing Trip Data to save.")
                return
            }
            
            dataManager
                .addFuelStop(gallons: gallons,
                             latitude: (loc.coordinate.latitude),
                             longitude: (loc.coordinate.longitude),
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
                            self.view?.displayError(message: error.localizedDescription)
                            print("Error: ", error)
                        case .completed:
                            break
                        }
                    }.disposed(by: disposeBag)
        } else {
            print("Form is not valid.")
        }
    }
}
