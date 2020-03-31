//
//  AdministrationService.swift
//  AdministrationExam
//
//  Created by Angel David Macho Esperilla on 30/03/2020.
//  Copyright © 2020 TuLotero. All rights reserved.
//

import UIKit

/// The AdministrationService class is a Service in charge of all operations related with Administrations
class AdministrationService: NSObject {
    
    /// Instance of service to use like a singleton
    public static let shared = AdministrationService()

    private let http: HTTP? = HTTP(url: Endpoints.administration)
    
    private override init() {}
    
    /**
     Fetch all loteries administration.
     
     - Returns: A list of Administrations
     */
    func getAllAdministrations<T: Decodable>(completion: @escaping (Result<T, URLResponse, ServiceError>) -> Void) {
        guard let http = self.http else {
            completion(.failure(.invalidEndpoint))
            return
        }
        http.get(completion: completion)
    }
    
}
