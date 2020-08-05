//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Spencer Curtis on 8/5/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

protocol NetworkController {
    func perform(request: URLRequest, completion: @escaping (Data?, Error?) -> Void)
}

class SearchResultController {

    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    
    enum PerformSearchError: Error {
        case invalidURLComponents(URLComponents?)
        case noDataReturned
        case invalidJSON(Data)
    }
    
    func performSearch(for searchTerm: String, resultType: ResultType, session: NetworkController = URLSession.shared, completion: @escaping (Result<[SearchResult], PerformSearchError>) -> Void) {
        
        // Creating the URL components
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let parameters = ["term": searchTerm,
                          "entity": resultType.rawValue]
        
        let queryItems = parameters.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        urlComponents?.queryItems = queryItems
        
        // Make sure you are getting a URL
        guard let requestURL = urlComponents?.url else {
            completion(.failure(.invalidURLComponents(urlComponents)))
            return
        }

        // Build request
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // Make call to the end point
        session.perform(request: request) { (data, error) in
            if let error = error { NSLog("Error fetching data: \(error)") }
            guard let data = data else {
                completion(.failure(.noDataReturned))
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
//                self.searchResults = searchResults.results
                completion(.success(searchResults.results))
            } catch {
                print("Unable to decode data into object of type [SearchResult]: \(error)")
                completion(.failure(.invalidJSON(data)))
            }
        }
        
//        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
//
//            if let error = error { NSLog("Error fetching data: \(error)") }
//            guard let data = data else { completion(); return }
//
//            do {
//                let jsonDecoder = JSONDecoder()
//                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
//                self.searchResults = searchResults.results
//            } catch {
//                print("Unable to decode data into object of type [SearchResult]: \(error)")
//            }
//
//            completion()
//        }
//        dataTask.resume()
    }
}
