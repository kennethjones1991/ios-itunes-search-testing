//
//  MockDataLoader.swift
//  iTunes SearchTests
//
//  Created by Kenneth Jones on 9/29/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

@testable import iTunes_Search

class MockDataLoader: NetworkDataLoader {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    func loadData(with request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(self.data, self.response, self.error)
        }
    }
}
