//
//  ViewControllerTests.swift
//  FootballMatchesTests
//
//  Created by Amit Vaidya on 15/09/2021.
//

import XCTest
@testable import FootballMatches

class ViewControllerTests: XCTestCase {
    
    var controller: ViewController!
    var tableView: UITableView!
    var dataSource: UITableViewDataSource!
    var matchDetails = [Match]()
    var cell: UITableViewCell!
    var homeTeamName: String!
    
    override func setUp() {
        super.setUp()
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController") as? ViewController else {
            return XCTFail("Could not instantiate ViewController from main storyboard")
        }
        
        controller = vc
        controller.loadViewIfNeeded()
        
        tableView = controller.tableViewForMatches
        
        dataSource = tableView.dataSource
        
        cell = controller.tableViewForMatches.dequeueReusableCell(withIdentifier: "matchesCell")
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "matchesCell")
        }
        
        let areaValues = Area(id: 3333, name: "French team")
        
        let refereeValues = Referee(id: 2, name: "Amit", role: Role.referee, nationality: Nationality.england)
        
        let extraTimeValues = ExtraTime(homeTeam: 1, awayTeam: 0)
        
        let scoreValues = Score(winner: Winner.awayTeam, duration: Duration.regular, fullTime: extraTimeValues, halfTime: extraTimeValues, extraTime: extraTimeValues, penalties: extraTimeValues)
        
        let seasonValues = Season(id: 2021, startDate: "2021-03-02", endDate: "2021-04-14", currentMatchday: 4)
        
        let oddsValue = Odds(msg: Msg.activateOddsPackageInUserPanelToRetrieveOdds)
        
        let matchDetailsValue = Match.init(id: 1, season: seasonValues, utcDate: "2021-03-02", status: Status.finished, matchday: 4, stage: Stage.preliminarySemiFinal, group: "National", lastUpdated: "today", odds: oddsValue, score: scoreValues, homeTeam: areaValues, awayTeam: areaValues, referees: [refereeValues])
        
        matchDetails.append(matchDetailsValue)
        homeTeamName = matchDetailsValue.homeTeam.name
    }
    
    func testHasTableView() {
        XCTAssertNotNil(controller.tableViewForMatches,
                        "Controller should have a tableview")
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(controller.tableViewForMatches.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(controller.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(controller.responds(to: #selector(controller.tableView(_:numberOfRowsInSection:))), "rows in section not called")
        XCTAssertTrue(controller.responds(to: #selector(controller.tableView(_:cellForRowAt:))), "cell for row at not called")
        XCTAssertTrue(controller.responds(to: #selector(controller.tableView(_:willDisplay:forRowAt:))), "will display for row at not called")
    }
    
    func testTableViewHasCells() {
        
        XCTAssertNotNil(cell, "TableView should be able to dequeue cell with identifier: 'matchCell'")
    }

    func testTableViewHasRows() {
        //Arrange
        let matchCount = matchDetails.count
        var numberOfRows = dataSource.tableView(tableView, numberOfRowsInSection: 0)
        
        //Act
        if(matchCount > 0) {
            numberOfRows = matchCount
        }
        
        //Assert
        XCTAssertEqual(numberOfRows, 1, "TableView should have same number of rows as match count in case matchCount is greater than 0")
    }
    
    func testCellForRowAtIsNotNil() {
        let indexPath = NSIndexPath(row: 0, section: 0)
        let cell = tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath as IndexPath)
        XCTAssertNotNil(cell)
        
        cell?.textLabel!.text = homeTeamName
        
        XCTAssertNotNil(cell?.textLabel!.text)
        XCTAssertEqual(cell?.textLabel!.text, "French team", "NOT EQUAL")
    }
    
    func testVariableInitialisation() {
        let matchDetailInitialised = matchDetails
        XCTAssertNotNil(matchDetailInitialised, "Match details are not initialised")
    }
    
}

