//
//  URLSession+NetworkController.swift
//  iTunes Search
//
//  Created by Kenneth Jones on 8/4/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

extension URLSession: NetworkController {
    func perform(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        let dataTask = self.dataTask(with: request) { (data, _, error) in
            completion(data, error)
        }
        dataTask.resume()
    }
}
