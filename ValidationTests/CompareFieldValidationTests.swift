//
//  CompareFieldValidationTests.swift
//  ValidationTests
//
//  Created by Hoff Henry Pereira da Silva on 01/10/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
// \(FieldName.name.rawValue)

import XCTest
import Validation

class CompareFieldValidationTests: XCTestCase {

    func test_validate_should_return_error_when_fields_do_not_match() {
        let sut = CompareFieldValidation(fieldName: .password, fieldNameToCompare: .passwordConfirmation)
        let errorMessage = sut.validate(data: ["\(FieldName.password)" : "123", "\(FieldName.passwordConfirmation)" : "1233"])
        XCTAssertEqual(errorMessage, "Os campos Senha e Confirmação de senha devem ser iguais.")
    }
    
    func test_validate_should_return_nil_when_fields_match() {
        let sut = CompareFieldValidation(fieldName: .password, fieldNameToCompare: .passwordConfirmation)
        let errorMessage = sut.validate(data: ["\(FieldName.password)" : "123", "\(FieldName.passwordConfirmation)" : "123"])
        XCTAssertNil(errorMessage)
    }

}
