//
//  ValidationSpy.swift
//  PresentationTests
//
//  Created by Hoff Henry Pereira da Silva on 01/10/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Presentation

class ValidationSpy: Validation {
    var data: [String:Any]?
    var errorMessage: String?
    
    func simulateError() {
        errorMessage = "Erro"
    }
    
    func validate(data: [String:Any]?) -> String? {
        self.data = data
        return errorMessage
    }
    
}
