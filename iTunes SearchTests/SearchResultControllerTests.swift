//
//  SearchResultControllerTests.swift
//  iTunes SearchTests
//
//  Created by Kenneth Jones on 9/29/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import XCTest
@testable import iTunes_Search

class SearchResultControllerTests: XCTestCase {

    // Dependency Injection - you provide the instance variables that an object or method uses
    
    // Types of Dependency Injection
    // 1. Initializer Dependency Injection - Creating an object with data in the init method
    // 2. Property dependency injection - passing a model object to a detail controller
    // 3. Method dependency injection - provide a completion closure or method
    
    func testForSomeResult() {
        let controller = SearchResultController()
        
        let expection = expectation(description: "Wait for results")
        
        controller.performSearch(for: "DayOne", resultType: .software) {
            expection.fulfill()
        }
        
        wait(for: [expection], timeout: 2)
        
        XCTAssertTrue(controller.searchResults.count > 0, "Expecting at least one result for Day One")
    }
    
    func testSearchResultController() {
        let mock = MockDataLoader()
        mock.data = dayOneJSON
        
        let controller = SearchResultController(dataLoader: mock)
        let resultsExpectation = expectation(description: "Wait for search results")
        
        controller.performSearch(for: "DayOne", resultType: .software) {
            resultsExpectation.fulfill()
        }
        
        wait(for: [resultsExpectation], timeout: 2.0)
        
        XCTAssertTrue(controller.searchResults.count == 2, "Expecting 2 results for DayOne")
        XCTAssertEqual("Bloom Built Inc", controller.searchResults[0].artist)
        XCTAssertEqual("Day One Journal", controller.searchResults[0].title)
    }
    
    func testBadJsonDecodingReturnsError() {
        let mock = MockDataLoader()
        mock.data = badJSON
        
        let controller = SearchResultController(dataLoader: mock)
        let resultsExpectation = expectation(description: "Wait for search results")
        
        controller.performSearch(for: "Day One", resultType: .software) {
            resultsExpectation.fulfill()
        }
        
        wait(for: [resultsExpectation], timeout: 2.0)
        
        XCTAssertTrue(controller.searchResults.count == 0, "Expecting no results for search")
        XCTAssertNotNil(controller.error)
    }
    
    func testNoResults() {
        let mock = MockDataLoader()
        mock.data = noResults
        
        let controller = SearchResultController(dataLoader: mock)
        let resultsExpectation = expectation(description: "Wait for search results")
        
        controller.performSearch(for: "abcdefg123", resultType: .software) {
            resultsExpectation.fulfill()
        }
        
        wait(for: [resultsExpectation], timeout: 2.0)
        
        XCTAssertTrue(controller.searchResults.count == 0, "Expecting no results from empty JSON")
    }
}
