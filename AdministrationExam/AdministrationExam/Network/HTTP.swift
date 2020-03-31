//
//  HTTP.swift
//  AdministrationExam
//
//  Created by Angel David Macho Esperilla on 30/03/2020.
//  Copyright © 2020 TuLotero. All rights reserved.
//

import UIKit

/// The HTTP class is in charge of managing HTTP reqests.
class HTTP: NSObject {
    
    let session: URLSession = URLSession.shared
    
    /// Endpoint of the request
    let url: URL
    
    private let jsonDecoder: JSONDecoder = JSONDecoder()
    
    /**
     Initializes a new HTTP with the provided parts and specifications.
     
     - Parameters:
     - url: The url of the HTTP request
     
     - Returns: An instance of HTTP
     */
    init?(url: String) {
        
        // The url must not be empty
        guard !url.isEmpty else {
            return nil
        }
        
        guard let urlObject = URL(string: url) else {
            return nil
        }
        
        // Initialize stored properties.
        self.url = urlObject
    }
    
    /**
     Create and send a GET request.
     
     - Returns: Data fetched in the request
     */
    func get<T: Decodable>(completion: @escaping (Result<T, URLResponse, ServiceError>) -> Void) {
        session.dataTask(with: url) { (result) in
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    completion(.failure(.invalidResponse))
                    return
                }
                do {
                    let values = try self.jsonDecoder.decode(T.self, from: data)
                    completion(.success(response: response, data: values))
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure(let error):
                completion(.failure(.apiError))
            }
        }.resume()
    }

}

extension URLSession {
    func dataTask(with url: URL, result: @escaping (Result<Data, URLResponse, Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success(response: response, data: data))
        }
    }
}
