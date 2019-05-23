//
//  AddStopContract.swift
//  Fuel
//
//  Created by Brad Leege on 2/9/18.
//  Copyright © 2018 Brad Leege. All rights reserved.
//

import CloudKit
import CoreLocation
import Foundation

protocol AddStopContractView: class {
    func dismiss()
    func dismissAfterSave(record: FuelStop)
    func displayError(message: String)
    func validateForm() -> Bool
    func gallonsData() -> Double
    func octaneData() -> Int
    func odometerData() -> Int
    func priceData() -> Double
    func ppgData() -> Double
    func stopDateData() -> Date
    func tripOdometerData() -> Double
}

protocol AddStopContractPresenter: class {
    func onAttach(view: AddStopContractView)
    func onDetach()
    func handleCancelTap()
    func handleSaveTap(_ location: CLLocation)
}
