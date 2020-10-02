//
//  EmailValidatorSpy.swift
//  ValidationTests
//
//  Created by Hoff Henry Pereira da Silva on 01/10/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Validation

class EmailValidatorSpy: EmailValidator {
    var isValid = true
    var email: String?
    func validate(email: String) -> Bool {
        self.email = email
        return isValid
    }
    
    func setEmailAsInvalid() {
        self.isValid = false
    }
    
}
