//
//  NetworkDataLoader.swift
//  iTunes Search
//
//  Created by Kenneth Jones on 9/29/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

protocol NetworkDataLoader {
    // Question: What do we need for data in/data out? (Search)
    // Input: URL Request
    // Output: Data or an error
    
    func loadData(with request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}
