//
//  MockOverviewViewController.swift
//  FuelTests
//
//  Created by Brad Leege on 2/20/18.
//  Copyright © 2018 Brad Leege. All rights reserved.
//

import Foundation
@testable import Fuel

class MockOverviewContractView: OverviewContractView {

    var displayStopsCalled = false
    var refreshMapCalled = false
    var displayStopOnMapCalled = false
    var displayStopDataViewCalled = false
    var displayAddStopViewControllerCalled = false
    
    func displayStops(fuelStops: [FuelStopsMO]) {
        displayStopsCalled = true
    }
    
    func refreshMap() {
        refreshMapCalled = true
    }

    func displayStopOnMap(index: Int) {
        displayStopOnMapCalled = true
    }
    
    func displayStopDataView(index: Int) {
        displayStopDataViewCalled = true
    }
    
    func displayAddStopViewController() {
        displayAddStopViewControllerCalled = true
    }
    
}
