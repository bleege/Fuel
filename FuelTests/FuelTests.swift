//
//  FuelTests.swift
//  FuelTests
//
//  Created by Brad Leege on 11/21/17.
//  Copyright © 2017 Brad Leege. All rights reserved.
//

import XCTest
@testable import Fuel

class FuelTests: XCTestCase {
    
    private var mockOverViewContractView: MockOverviewContractView?
    private var mockAddStopContractView: MockAddStopContractView?
    private var mockFuelStopsDataManager: MockFuelStopsDataManager?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockOverViewContractView = MockOverviewContractView()
        mockAddStopContractView = MockAddStopContractView()
        mockFuelStopsDataManager = MockFuelStopsDataManager()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockOverViewContractView = nil
        mockAddStopContractView = nil
        mockFuelStopsDataManager = nil
        
        super.tearDown()
    }
    
    func testOverviewPresenterLoadStops() {
        let presenter = OverviewPresenter(dataManager: mockFuelStopsDataManager!)
        let expecation = self.expectation(description: "Display Fuel Stops")
        mockOverViewContractView?.expectation = expecation
        presenter.onAttach(view: mockOverViewContractView!)
        presenter.loadFuelStops()
        self.wait(for: [expecation], timeout: 5.0)
        presenter.onDetach()
        XCTAssertTrue(mockOverViewContractView?.displayStopsCalled == true)
    }
    
    func testOverviewPresenterShowStopSelection() {
        let presenter = OverviewPresenter(dataManager: mockFuelStopsDataManager!)
        presenter.onAttach(view: mockOverViewContractView!)
        presenter.handleStopSelection(index: 1)
        presenter.onDetach()
        XCTAssertTrue(mockOverViewContractView?.displayStopOnMapCalled == true)
        XCTAssertTrue(mockOverViewContractView?.displayStopDataViewCalled == true)
    }
    
    func testOverviewPresenterAddStopFABTap() {
        let presenter = OverviewPresenter(dataManager: mockFuelStopsDataManager!)
        presenter.onAttach(view: mockOverViewContractView!)
        presenter.handleAddStopFABTap()
        presenter.onDetach()
        XCTAssertTrue(mockOverViewContractView?.displayAddStopViewControllerCalled == true)
    }
    
    func testAddStopPresenterDismiss(){
        let presenter = AddStopPresenter()
        presenter.onAttach(view: mockAddStopContractView!)
        presenter.handleCancelTap()
        presenter.onDetach()
        XCTAssertTrue(mockAddStopContractView?.dismissCalled == true)
    }

    func testAddStopPresenterSave(){
        let presenter = AddStopPresenter(dataManager: mockFuelStopsDataManager!)
        presenter.onAttach(view: mockAddStopContractView!)
        presenter.handleSaveTap()
        presenter.onDetach()
        XCTAssertTrue(mockAddStopContractView?.validateFormCalled == true)
        XCTAssertTrue(mockAddStopContractView?.gallonsDataCalled == true)
        XCTAssertTrue(mockAddStopContractView?.octaneDataCalled == true)
        XCTAssertTrue(mockAddStopContractView?.odometerDataCalled == true)
        XCTAssertTrue(mockAddStopContractView?.priceDataCalled == true)
        XCTAssertTrue(mockAddStopContractView?.ppgDataCalled == true)
        XCTAssertTrue(mockAddStopContractView?.tripOdometerDataCalled == true)
        XCTAssertTrue(mockAddStopContractView?.dismissAfterSaveCalled == true)
    }
    
}
