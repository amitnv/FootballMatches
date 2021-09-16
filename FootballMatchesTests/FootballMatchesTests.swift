//
//  FootballMatchesTests.swift
//  FootballMatchesTests
//
//  Created by Amit Vaidya on 14/09/2021.
//

import Foundation
import XCTest
@testable import FootballMatches

class FootballMatchesTests: XCTestCase {
    
    let timeout: TimeInterval = 5

    func testServerResponse() {
            let url = URL(string: "https://api.football-data.org/v2/competitions/2001/matches")!
            let expectation = self.expectation(description: "Server responds in reasonable time")
            URLSession.shared.dataTask(with: url) { data, response, error in
                defer { expectation.fulfill() }
                XCTAssertNotNil(data)
                XCTAssertNotNil(response)
                XCTAssertNil(error)
            }.resume()
            wait(for: [expectation], timeout: timeout)
        }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testInitialViewController_whenValidDateIsPassed_ShouldReturnTrue() {
        //Arrange
        let sut = InitialViewController()
        //Pass today's date
        let date = Date()
        //Act
        //
        let isTodaysDate = sut.formatDate(date: date)
        
        //Assert
        //Pass today's date as yyyy-MM-DD value for a true result
//        XCTAssertEqual(isTodaysDate, "2021-09-16")
        XCTAssertNotEqual(isTodaysDate, "2021-11-11")
        XCTAssertNotEqual(isTodaysDate, "1-11-2020")
    }
}
