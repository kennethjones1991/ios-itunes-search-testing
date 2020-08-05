//
//  MockAPI.swift
//  iTunes Search
//
//  Created by Kenneth Jones on 8/4/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class MockAPI: NetworkController {
    
    let data: Data
    init(data: Data) {
        self.data = data
    }
    
    func perform(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        DispatchQueue.global().async {
            completion(self.data, nil)
        }
    }
}
