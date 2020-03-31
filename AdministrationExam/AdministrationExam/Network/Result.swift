//
//  Result.swift
//  AdministrationExam
//
//  Created by Angel David Macho Esperilla on 30/03/2020.
//  Copyright © 2020 TuLotero. All rights reserved.
//

import UIKit

/// This type is a helper for http responses
enum Result<T, Y, E> {
    case success(response: Y, data: T)
    case failure(E)
}
