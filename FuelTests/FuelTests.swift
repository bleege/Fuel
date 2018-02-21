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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockOverViewContractView = MockOverviewContractView()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockOverViewContractView = nil
        
        super.tearDown()
    }
    
    func testOverviewPresenter() {
        let presenter = OverviewPresenter()
        presenter.onAttach(view: mockOverViewContractView!)
        presenter.onDetach()
        XCTAssertTrue(mockOverViewContractView?.displayStopsCalled == true)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
