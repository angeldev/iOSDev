//
//  ServiceError.swift
//  AdministrationExam
//
//  Created by Angel David Macho Esperilla on 31/03/2020.
//  Copyright © 2020 TuLotero. All rights reserved.
//

public enum ServiceError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case decodeError
}
