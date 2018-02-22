//
//  MockAddStopContractView.swift
//  FuelTests
//
//  Created by Brad Leege on 2/21/18.
//  Copyright © 2018 Brad Leege. All rights reserved.
//

import Foundation
import CoreLocation
@testable import Fuel

class MockAddStopContractView: AddStopContractView {
    
    var initialDataPopulationCalled = false
    var dismissCalled = false
    var validateFormCalled = false
    var gallonsDataCalled = false
    var latitudeDataCalled = false
    var longitudeDataCalled = false
    var octaneDataCalled = false
    var odometerDataCalled = false
    var priceDataCalled = false
    var ppgDataCalled = false
    var stopDateDataCalled = false
    var tripOdometerDataCalled = false
    
    func initialDataPopulation(stopDate: Date, location: CLLocation?) {
        self.initialDataPopulationCalled = true
    }
    
    func dismiss() {
        dismissCalled = true
    }
    
    func validateForm() -> Bool {
        validateFormCalled = true
        return true
    }
    
    func gallonsData() -> Double {
        gallonsDataCalled = true
        return 1
    }
    
    func latitudeData() -> Double {
        latitudeDataCalled = true
        return 1
    }
    
    func longitudeData() -> Double {
        longitudeDataCalled = true
        return 1
    }
    
    func octaneData() -> Int {
        octaneDataCalled = true
        return 1
    }
    
    func odometerData() -> Int {
        odometerDataCalled = true
        return 1
    }
    
    func priceData() -> Double {
        priceDataCalled = true
        return 1
    }
    
    func ppgData() -> Double {
        ppgDataCalled = true
        return 1
    }
    
    func stopDateData() -> Date {
        stopDateDataCalled = true
        return Date()
    }
    
    func tripOdometerData() -> Double {
        tripOdometerDataCalled = true
        return 1
    }

}
