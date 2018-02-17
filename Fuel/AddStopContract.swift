//
//  AddStopContract.swift
//  Fuel
//
//  Created by Brad Leege on 2/9/18.
//  Copyright © 2018 Brad Leege. All rights reserved.
//

import CoreLocation
import Foundation

protocol AddStopContractView {
    func initialDataPopulation(stopDate: Date, location: CLLocation?)
    func dismiss()
    func validateForm() -> Bool
    func gallonsData() -> Double
    func latitudeData() -> Double
    func longitudeData() -> Double
    func octaneData() -> Int
    func odometerData() -> Int
    func priceData() -> Double
    func ppgData() -> Double
    func stopDateData() -> Date
    func tripOdometerData() -> Double
}

protocol AddStopContractPresenter {
    func onAttach(view: AddStopContractView)
    func onDetach()
    func handleCancelTap()
    func handleSaveTap()
}
