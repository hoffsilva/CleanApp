//
//  CompareFieldValidation.swift
//  Validation
//
//  Created by Hoff Henry Pereira da Silva on 01/10/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Presentation

public class CompareFieldValidation: Validation {
    
    private let fieldName: FieldName
    private let fieldNameToCompare: FieldName
    private let fieldNameLabel: String
    
    public init(fieldName: FieldName, fieldNameToCompare: FieldName) {
        self.fieldName = fieldName
        self.fieldNameToCompare = fieldNameToCompare
        self.fieldNameLabel = fieldNameToCompare.rawValue
    }
    
    public func validate(data: [String : Any]?) -> String? {
        guard let password = data?["\(fieldName)"] as? String,
              let passwordConfirmation = data?["\(fieldNameToCompare)"] as? String,
              password == passwordConfirmation,
              !password.isEmpty,
              !passwordConfirmation.isEmpty else {
            return "Os campos \(fieldName.rawValue) e \(fieldNameToCompare.rawValue) devem ser iguais."
        }
        return nil
    }
}
