//
//  iTunes_SearchTests.swift
//  iTunes SearchTests
//
//  Created by Kenneth Jones on 8/4/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import XCTest

@testable import iTunes_Search

class iTunes_SearchTests: XCTestCase {
    
    func testFailedSearch() {
        
        let searchExpectation = expectation(description: "Waiting for results")
        let searchResultsController = SearchResultController()
        
        let corruptData = """
            {
                "resultCount": "2",
                "result" : [
                    {
                        "trackName" : "GarageBand",
                        "artistName" : "Apple"
                    },
                    {
                        "trackName" : "Garage Virtual Drumset Band",
                        "artistName" : "Nexogen Private Limited"
                    }
                ]
            }
        """.data(using: .utf8)!
        
        let mockAPI = MockAPI(data: corruptData)
        
        searchResultsController.performSearch(for: "Tweetbot", resultType: .software, session: mockAPI) { (result) in
            switch result {
            case .success:
                XCTFail("This search result is succeeding, which is weird cuz the JSON is corrupted")
            case .failure:
                break
            }
            
            searchExpectation.fulfill()
        }
        
        //        searchResultsController.performSearch(for: "Tweetbot", resultType: .software) {
        //            XCTFail()
        //
        //            searchExpectation.fulfill()
        //        }
        
        // wait for results
        // Blocking the main thread from executing
        wait(for: [searchExpectation], timeout: 5)
    }
    
    func testSucceededSearch() {
        
        let searchExpectation = expectation(description: "Waiting for results")
        let searchResultsController = SearchResultController()
        
        let correctData = """
                {
                    "resultCount": "2",
                    "results" : [
                        {
                            "trackName" : "GarageBand",
                            "artistName" : "Apple"
                        },
                        {
                            "trackName" : "Garage Virtual Drumset Band",
                            "artistName" : "Nexogen Private Limited"
                        }
                    ]
                }
            """.data(using: .utf8)!
        
        let mockAPI = MockAPI(data: correctData)
        
        searchResultsController.performSearch(for: "Tweetbot", resultType: .software, session: mockAPI) { (result) in
            switch result {
            case .success:
                break
            case .failure:
                XCTFail("This search result is failing, which is weird cuz the JSON is awesome")
            }
            
            searchExpectation.fulfill()
        }
        
        wait(for: [searchExpectation], timeout: 5)
    }
    
}
