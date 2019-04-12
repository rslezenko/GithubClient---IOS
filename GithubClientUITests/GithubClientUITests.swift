//
//  GithubClientUITests.swift
//  GithubClientUITests
//
//  Created by Roman Slezenko on 4/12/19.
//  Copyright © 2019 Roman Slezenko. All rights reserved.
//

import XCTest

class GithubClientUITests: XCTestCase {

    var app = XCUIApplication()
    let nickname = "rslezenko"
    let badnickname = "rslezenko321123"
    override func setUp() {
        continueAfterFailure = false

        XCUIApplication().launch()
    }

    override func tearDown() {
       
    }
    
    func testdidntfindNicknameInGithubAPI() {
        app.textFields.element.tap()
        app.textFields.element.typeText(badnickname)
        app.buttons["Find Repositories"].tap()
        
        addUIInterruptionMonitor(withDescription: "System alert") { (alert) -> Bool in
            XCTAssertTrue(self.app.buttons["OK"].exists)
            return true
        }
    }

    
    func testfindNicknameInGithubAPI() {
        app.textFields.element.tap()
        app.textFields.element.typeText(nickname)
        app.buttons["Find Repositories"].tap()
        XCTAssertTrue(!app.alerts["Error"].exists)
    }
    
    func testIfRepositoriesPresent() {
        app.textFields.element.tap()
        app.textFields.element.typeText(nickname)
        app.buttons["Find Repositories"].tap()
        sleep(5)
        XCTAssert(app.tables.staticTexts.count > 0)
    }
    
    func testdetailsrepositories() {
        testIfRepositoriesPresent()
        app.tables["MyTable"].cells.allElementsBoundByIndex.first?.tap()
        sleep(5)
        XCTAssert(app.staticTexts["View code"].exists)
    }
    
    func testNavigationBack() {
        app.textFields.element.tap()
        app.textFields.element.typeText(nickname)
        app.buttons["Find Repositories"].tap()
        sleep(5)
        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.textFields.element.exists)
    }

}
