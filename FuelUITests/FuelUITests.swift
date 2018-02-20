//
//  FuelUITests.swift
//  FuelUITests
//
//  Created by Brad Leege on 11/21/17.
//  Copyright © 2017 Brad Leege. All rights reserved.
//

import XCTest

class FuelUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testDisplayStopDetailAndDismiss() {
        let app = XCUIApplication()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["12.3050"]/*[[".cells.staticTexts[\"12.3050\"]",".staticTexts[\"12.3050\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.tap()
    }
    
}
