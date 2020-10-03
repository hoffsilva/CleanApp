//
//  ValidationSpy.swift
//  ValidationTests
//
//  Created by Hoff Henry Pereira da Silva on 03/10/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Presentation

class ValidationSpy: Validation {
    
    var errorMessage: String?
    
    func validate(data: [String : Any]?) -> String? {
        errorMessage
    }
    
    func simulateError(_ errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
}
