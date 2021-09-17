//
//  InitialViewControllerTests.swift
//  FootballMatchesTests
//
//  Created by Amit Vaidya on 15/09/2021.
//

import XCTest
@testable import FootballMatches

class InitialViewControllerTests: XCTestCase {

    var controller: InitialViewController!

    override func setUp() {
        super.setUp()

        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "InitialViewController") as? InitialViewController else {
            return XCTFail("Could not instantiate InitialViewController from main storyboard")
        }
        controller = vc
        controller.loadViewIfNeeded()
        controller.viewDidLoad()
    }

    func testViewControllerUnderTestIsComposedOfButton() {
        
        XCTAssertNotNil(controller.showMatches, "Does not have a button to show matches")
        XCTAssertNotNil(controller.mostWins, "Does not have a button for most wins")
    }
    
    func testShowMatchesButtonInvokesActionMethodWhenTapped() {
        
        let actionMethod = controller.showMatches.actions(forTarget: controller, forControlEvent: UIControl.Event.touchUpInside)
        let showMatchesTapped = actionMethod?.first
        let expectedMethodName = "showMatchesTapped:"
        
        XCTAssertEqual(showMatchesTapped, expectedMethodName, "Actual: \(String(describing: showMatchesTapped)) not equal to expected: \(String(describing: expectedMethodName))")
    }
    
    func testMostWinsButtonInvokesActionMethodWhenTapped() {
        
        let actionMethod = controller.mostWins.actions(forTarget: controller, forControlEvent: UIControl.Event.touchUpInside)
        let mostWinsTapped = actionMethod?.first
        let expectedMethodName = "mostWinsTapped:"
        
        XCTAssertEqual(mostWinsTapped, expectedMethodName, "Actual: \(String(describing: mostWinsTapped)) not equal to expected: \(String(describing: expectedMethodName))")
    }
    
    func testGetWinsAction() {
        
        self.controller.teamWithHighestWins = "MY TEAM"
        controller.mostWins.sendActions(for: .touchUpInside)
        
        XCTAssertNotNil(self.controller!.getWins, "get wins method not called")
    }
    
    func testDataMoverAction() {
        
        controller.showMatches.sendActions(for: .touchUpInside)
        
        XCTAssertNotNil(self.controller!.dataMover, "data mover method not called")
    }
    
    func testButtonBorderColor() {
        controller.mostWins.borderColor = UIColor.blue
        XCTAssertEqual(UIColor(cgColor:controller.mostWins.layer.borderColor!), UIColor.blue, "borderColor")
    }
}

