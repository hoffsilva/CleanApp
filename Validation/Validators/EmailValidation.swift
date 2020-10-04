//
//  EmailValidation.swift
//  Validation
//
//  Created by Hoff Henry Pereira da Silva on 02/10/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Presentation

public class EmailValidation: Validation {

    private let fieldName: FieldName
    private let fieldNameLabel: String
    private let emailValidator: EmailValidator
    
    public init(fieldName: FieldName,
                emailValidator: EmailValidator) {
        self.fieldName = fieldName
        self.fieldNameLabel = fieldName.rawValue
        self.emailValidator = emailValidator
    }
    
    public func validate(data: [String : Any]?) -> String? {
        guard let email = data?["\(fieldName)"] as? String,
              !emailValidator.validate(email: email) else {
            return nil
        }
        return "O campo \(fieldNameLabel) é inválido"
    }
    
}
