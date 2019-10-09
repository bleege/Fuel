//
//  FuelTests.swift
//  FuelTests
//
//  Created by Brad Leege on 11/21/17.
//  Copyright © 2017 Brad Leege. All rights reserved.
//

import XCTest
import Swinject
import SwinjectAutoregistration
@testable import Fuel

/// NOTE: Workaround required due to bug in Swift NIO
/// https://github.com/ReactiveX/RxSwift/issues/2057

class FuelTests: XCTestCase {
    
    private var mockOverViewContractView: MockOverviewContractView?
    private var container: Container = {
        let container = Container() { container in
            container.register(FuelStopsDataManagerContract.self) { _ in MockFuelStopsDataManager() }
            container.autoregister(OverviewContractPresenter.self, initializer: OverviewPresenter.init(dataManager:))
        }
        return container
    }()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockOverViewContractView = MockOverviewContractView()
        
        // From: https://www.natashatherobot.com/ios-testing-view-controllers-swift/
        XCTAssertNotNil(mockOverViewContractView?.view)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockOverViewContractView = nil
        
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
}
