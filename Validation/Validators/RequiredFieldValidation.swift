//
//  RequiredFieldValidation.swift
//  Validation
//
//  Created by Hoff Henry Pereira da Silva on 01/10/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Presentation

public class RequiredFieldValidation: Validation {
    
    private let fieldName: FieldName
    private let fieldNameLabel: String
    
    public init(fieldName: FieldName) {
        self.fieldName = fieldName
        self.fieldNameLabel = fieldName.rawValue
    }
    
    public func validate(data: [String : Any]?) -> String? {
        "O campo \(fieldNameLabel) é obrigatório"
    }
}
