//
//  FuelTests.swift
//  FuelTests
//
//  Created by Brad Leege on 11/21/17.
//  Copyright © 2017 Brad Leege. All rights reserved.
//

import XCTest
//import Swinject
//import SwinjectAutoregistration
@testable import Fuel

class FuelTests: XCTestCase {
/*
    private var mockOverViewContractView: MockOverviewContractView?
    private var mockAddStopContractView: MockAddStopContractView?
    private var container: Container = {
        let container = Container() { container in
            container.register(FuelStopsDataManagerContract.self) { _ in MockFuelStopsDataManager() }
            container.autoregister(OverviewContractPresenter.self, initializer: OverviewPresenter.init(dataManager:))
            container.autoregister(AddStopContractPresenter.self, initializer: AddStopPresenter.init(dataManager:))
        }
        return container
    }()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockOverViewContractView = MockOverviewContractView()
//        mockAddStopContractView = MockAddStopContractView()
        
        // From: https://www.natashatherobot.com/ios-testing-view-controllers-swift/
        XCTAssertNotNil(mockOverViewContractView?.view)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockOverViewContractView = nil
//        mockAddStopContractView = nil
        
        super.tearDown()
    }
    
    func testOverviewPresenterLoadStops() {
        let presenter = container.resolve(OverviewContractPresenter.self)
        let expectation = self.expectation(description: "Display Fuel Stops")
        mockOverViewContractView?.expectation = expectation
        presenter?.onAttach(view: mockOverViewContractView!)
        presenter?.loadFuelStops()
        self.wait(for: [expectation], timeout: 5.0)
        presenter?.onDetach()
        XCTAssertTrue(mockOverViewContractView?.displayStopsCalled == true)
    }
    
    func testOverviewPresenterShowStopSelection() {
        let presenter = container.resolve(OverviewContractPresenter.self)
        presenter?.onAttach(view: mockOverViewContractView!)
        presenter?.handleStopSelection(index: 1)
        presenter?.onDetach()
        XCTAssertTrue(mockOverViewContractView?.displayStopOnMapCalled == true)
        XCTAssertTrue(mockOverViewContractView?.displayStopDataViewCalled == true)
    }
    
    func testOverviewPresenterAddStopFABTap() {
        let presenter = container.resolve(OverviewContractPresenter.self)
        presenter?.onAttach(view: mockOverViewContractView!)
        presenter?.handleAddStopFABTap()
        presenter?.onDetach()
        XCTAssertTrue(mockOverViewContractView?.displayAddStopViewControllerCalled == true)
    }
    func testAddStopPresenterDismiss(){
        let presenter = container.resolve(AddStopContractPresenter.self)
        presenter?.onAttach(view: mockAddStopContractView!)
        presenter?.handleCancelTap()
        presenter?.onDetach()
        XCTAssertTrue(mockAddStopContractView?.dismissCalled == true)
    }

    func testAddStopPresenterSave(){
        let presenter = container.resolve(AddStopContractPresenter.self)
        let expectation = self.expectation(description: "Save Stop Data")
        mockAddStopContractView?.expectation = expectation
        presenter?.onAttach(view: mockAddStopContractView!)
        presenter?.handleSaveTap()
        self.wait(for: [expectation], timeout: 5.0)
        presenter?.onDetach()
        XCTAssertTrue(mockAddStopContractView?.validateFormCalled == true)
        XCTAssertTrue(mockAddStopContractView?.gallonsDataCalled == true)
        XCTAssertTrue(mockAddStopContractView?.octaneDataCalled == true)
        XCTAssertTrue(mockAddStopContractView?.odometerDataCalled == true)
        XCTAssertTrue(mockAddStopContractView?.priceDataCalled == true)
        XCTAssertTrue(mockAddStopContractView?.ppgDataCalled == true)
        XCTAssertTrue(mockAddStopContractView?.tripOdometerDataCalled == true)
        XCTAssertTrue(mockAddStopContractView?.dismissAfterSaveCalled == true)
    }
*/
}
