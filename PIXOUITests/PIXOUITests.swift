//
//  PIXOUITests.swift
//  PIXOUITests
//
//  Created by Kanghos on 2022/05/09.
//

import XCTest
@testable import PIXO

class PIXOUITests: XCTestCase {

    var sut: PHService!

    override func setUpWithError() throws {
        sut = PHService()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
