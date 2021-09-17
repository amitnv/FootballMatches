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
    
    func testInitialViewController_whenValidDateIsPassed_ShouldReturnTrue() {
        //Arrange
        let sut = InitialViewController()
        //Pass today's date
        let date = Date()
        //Act
        //
        let isTodaysDate = sut.formatDate(date: date)
        let todaysDateFunctionValue = sut.getTodaysDate()
        
        //Assert
        XCTAssertEqual(isTodaysDate, todaysDateFunctionValue)
        XCTAssertNotNil(isTodaysDate)
        XCTAssertNotEqual(isTodaysDate, "2021-11-11")
        XCTAssertNotEqual(isTodaysDate, "1-11-2020")
    }
    
    func testmostwin() {
        //Arrange
        let sut = MostWinsViewController()
        
        //Act
        let dat = sut.dataForTeamWithHighestWins
        //Assert
        XCTAssertNotNil(dat)
    }
    
    func testInitialViewController_whenDateIsNotRewinded_ShouldReturnTodaysDate() {
        //Arrange
        let sut = InitialViewController()
        
        //Act
        let dateNotReallyRewinded = sut.dateRewindBy(rewindInt: 0)
        let date = Date()
        let isTodaysDate = sut.formatDate(date: date)
        
        //Assert
        XCTAssertEqual(dateNotReallyRewinded, isTodaysDate)
        
    }
    
    func testWinnerID() {
        
        let sut = InitialViewController()
        let result = sut.winnerIDGenerator(noOfMatches: 0)
        
        XCTAssertEqual(result.count, 0, "Result should be equal to match count")
    }
    
    func testMatchesModel_ServerResponse_ShouldNotReturnNilDataResponse() {
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
    
    func testModelExists_ShouldNotReturnNil() {
        
        let areaValues = Area(id: 3333, name: "French team")
        XCTAssertNotNil(areaValues)
        
        let competitionValues = Competition(id: 2, area: areaValues, name: "Campions League", code: "New", plan: "3 months", lastUpdated: "today")
        XCTAssertNotNil(competitionValues)
        
        let refereeValues = Referee(id: 2, name: "Amit", role: Role.referee, nationality: Nationality.england)
        XCTAssertNotNil(refereeValues)
        
        let extraTimeValues = ExtraTime(homeTeam: 1, awayTeam: 0)
        XCTAssertNotNil(extraTimeValues)
        
        let scoreValues = Score(winner: Winner.awayTeam, duration: Duration.regular, fullTime: extraTimeValues, halfTime: extraTimeValues, extraTime: extraTimeValues, penalties: extraTimeValues)
        XCTAssertNotNil(scoreValues)
        
        let seasonValues = Season(id: 2021, startDate: "2021-03-02", endDate: "2021-04-14", currentMatchday: 4)
        XCTAssertNotNil(seasonValues)
        
        let oddsValue = Odds(msg: Msg.activateOddsPackageInUserPanelToRetrieveOdds)
        XCTAssertNotNil(oddsValue)
        
        let matchValue = Match(id: 1, season: seasonValues, utcDate: "2021-03-02", status: Status.finished, matchday: 4, stage: Stage.preliminarySemiFinal, group: "National", lastUpdated: "today", odds: oddsValue, score: scoreValues, homeTeam: areaValues, awayTeam: areaValues, referees: [refereeValues])
        XCTAssertNotNil(matchValue)
   
    }
    
    func testControlerHasLabel_ShouldReturnNotNill() {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MostWinsViewController") as? MostWinsViewController else {
            return XCTFail("Could not instantiate ViewController from main storyboard")
        }
        vc.loadViewIfNeeded()
        XCTAssertNotNil(vc.lblTeamName, "Controller should have a label")
    }
    
    func testControllerHasURLInitialised_ShouldReturnEqualToInitValue() {
        let sut = Service(baseUrl: "OK")
        XCTAssertEqual(sut.baseUrl, "OK", "baseURL should be set in initializer")
    }
    
    func testViewControllerUnderTestIsComposedOfLabel() {
        var controller: MostWinsViewController!
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MostWinsViewController") as? MostWinsViewController else {
            return XCTFail("Could not instantiate InitialViewController from main storyboard")
        }
        controller = vc
        controller.loadViewIfNeeded()
        XCTAssertNotNil(controller.lblTeamName, "Does not have label")
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
}
