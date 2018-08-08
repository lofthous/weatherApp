//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Andrew Lofthouse on 06/08/2018.
//  Copyright © 2018 Andrew Lofthouse. All rights reserved.
//

import XCTest
@testable import WeatherApp

class WeatherAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testKelvinToCelcius() {
        let kelvin: Float = 300
        let helper = unitHelpers.init()
        XCTAssertFalse(helper.kelvinToCelcius(temp: kelvin) == 26.85)
    }
    
    func testKelvinToFahrenheit() {
        let kelvin: Float = 300
        let helper = unitHelpers.init()
        XCTAssertFalse(helper.kelvinToCelcius(temp: kelvin) == 80.33)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
