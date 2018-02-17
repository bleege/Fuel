//
//  AddStopPresenter.swift
//  Fuel
//
//  Created by Brad Leege on 2/9/18.
//  Copyright © 2018 Brad Leege. All rights reserved.
//

import CoreLocation
import UIKit

class AddStopPresenter: AddStopContractPresenter {

    private var view:AddStopContractView?
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func onAttach(view: AddStopContractView) {
        self.view = view
        self.view?.initialDataPopulation(stopDate: Date(), location: appDelegate.currentLocation)
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
            
            appDelegate.dataManager.addFuelStop(gallons: (view?.gallonsData())!,
                                                latitude: (view?.latitudeData())!,
                                                longitude: (view?.longitudeData())!,
                                                octane: (view?.octaneData())!,
                                                odometer: (view?.odometerData())!,
                                                price: (view?.priceData())!,
                                                ppg: (view?.ppgData())!,
                                                stopDate: (view?.stopDateData())!,
                                                tripOdometer: (view?.tripOdometerData())!)
            view?.dismiss()
        } else {
            print("Form is not valid.")
        }
    }
}
