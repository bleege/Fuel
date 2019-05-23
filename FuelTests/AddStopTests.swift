//
//  AddStopTests.swift
//  FuelTests
//
//  Created by Brad Leege on 5/20/19.
//  Copyright © 2019 Brad Leege. All rights reserved.
//

import XCTest
import CoreLocation
import Swinject
import SwinjectAutoregistration
@testable import Fuel

class AddStopTests: XCTestCase {

    private var mockAddStopContractView: MockAddStopContractView?
    private var container: Container = {
        let container = Container() { container in
            container.register(FuelStopsDataManagerContract.self) { _ in MockFuelStopsDataManager() }
            container.autoregister(AddStopContractPresenter.self, initializer: AddStopPresenter.init(dataManager:))
        }
        return container
    }()
    private let saveLocation: CLLocation = CLLocation(latitude: 43.3022, longitude: -89.93264)
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockAddStopContractView = MockAddStopContractView()
        XCTAssertNotNil(mockAddStopContractView?.view)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockAddStopContractView = nil
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
        presenter?.handleSaveTap(saveLocation)
        self.wait(for: [expectation], timeout: 5.0)
        presenter?.onDetach()
        // TODO: - Failing because location isn't found by presenter
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
