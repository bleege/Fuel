//
//  MockAddStopContractView.swift
//  FuelTests
//
//  Created by Brad Leege on 2/21/18.
//  Copyright © 2018 Brad Leege. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import XCTest
@testable import Fuel

class MockAddStopContractView: UIViewController, AddStopContractView {
    
    var dismissCalled = false
    var validateFormCalled = false
    var locationDataCalled = false
    var gallonsDataCalled = false
    var octaneDataCalled = false
    var odometerDataCalled = false
    var priceDataCalled = false
    var ppgDataCalled = false
    var stopDateDataCalled = false
    var tripOdometerDataCalled = false
    var dismissAfterSaveCalled = false
    var displayErrorCalled = false
    
    var expectation: XCTestExpectation? = nil
    
    func dismiss() {
        dismissCalled = true
    }
    
    func validateForm() -> Bool {
        validateFormCalled = true
        return true
    }
    
    func locationData() -> CLLocation? {
        locationDataCalled = true
        return CLLocation(latitude: 43.3022, longitude: -89.93264)
    }
    
    func gallonsData() -> Double {
        gallonsDataCalled = true
        return 1.0
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
        return 1.0
    }
    
    func ppgData() -> Double {
        ppgDataCalled = true
        return 1.0
    }
    
    func stopDateData() -> Date {
        stopDateDataCalled = true
        return Date()
    }
    
    func tripOdometerData() -> Double {
        tripOdometerDataCalled = true
        return 1.0
    }

    func dismissAfterSave(record: FuelStop) {
        dismissAfterSaveCalled = true
        expectation?.fulfill()
    }
    
    func displayError(message: String) {
        displayErrorCalled = true
        expectation?.fulfill()
    }

}
