//
//  MovieAppTests.swift
//  MovieAppTests
//
//  Created by user143649 on 4/17/19.
//  Copyright © 2019 user143649. All rights reserved.
//

import XCTest
@testable import MovieApp

class MovieAppTests: XCTestCase {
    
    func testLoadMore(){
        let index = 9
        let resultCount = 10
        var pageNo = 1
        let totalPages = 4
       
        let mockUrlWithPageNOA = "https://mockUrl.com/page=\(pageNo)"
        let mockUrlWithPageNOB = "https://mockUrl.com/page=1"
        XCTAssertEqual(mockUrlWithPageNOA, mockUrlWithPageNOB)
        XCTAssertEqual(index, resultCount-1)
        for _ in 0..<4{
        if index == resultCount - 1{
          
            if pageNo < totalPages {
                pageNo+=1
               XCTAssertTrue(true, "More pages to load")
            }
            else{
              XCTAssertFalse(false)
            }
            }}
    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testBasic() {
        
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
