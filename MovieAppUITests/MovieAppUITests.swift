//
//  MovieAppUITests.swift
//  MovieAppUITests
//
//  Created by user143649 on 4/17/19.
//  Copyright © 2019 user143649. All rights reserved.
//

import XCTest

class MovieAppUITests: XCTestCase {

    func testFirstPage(){
        
        let app = XCUIApplication()
        
        let searchText = "avengers"
        
    let popularBtn = app/*@START_MENU_TOKEN@*/.buttons["Most Popular"]/*[[".segmentedControls.buttons[\"Most Popular\"]",".buttons[\"Most Popular\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(popularBtn.exists)
        popularBtn.tap()
        
    let nowplayBtn = app/*@START_MENU_TOKEN@*/.buttons["Now Playing"]/*[[".segmentedControls.buttons[\"Now Playing\"]",".buttons[\"Now Playing\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(nowplayBtn.exists)
        nowplayBtn.tap()
        
        let searchWithMovieNameSearchField = app.searchFields["Search with movie name"]
        XCTAssertTrue(searchWithMovieNameSearchField.exists)
        searchWithMovieNameSearchField.tap()
        searchWithMovieNameSearchField.typeText(searchText)
      

    }
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
