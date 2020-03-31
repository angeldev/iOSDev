//
//  Administration.swift
//  AdministrationExam
//
//  Created by Angel David Macho Esperilla on 29/03/2020.
//  Copyright © 2020 TuLotero. All rights reserved.
//

import UIKit

/// The Administration class is a representation of a lottery administration
class Administration: NSObject {
    
    //MARK: Properties
    
    /// The name of the administration.
    var name: String
    
    /// The photo of the administration.
    var photo: UIImage?
    
    /// The address of the administration.
    var address: String
    
    //MARK: Initialization
    
    /**
     Initializes a new administration with the provided parts and specifications.
     
     - Parameters:
     - name: The name of the administration
     - photo: The photo of the administration
     - address: The address of the administration
     
     - Returns: An instance of Administration
     */
    init?(name: String, photo: UIImage?, address: String) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // The address must not be empty
        guard !address.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.address = address
        
    }
    
}
