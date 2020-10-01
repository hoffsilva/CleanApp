//
//  RequiredFieldValidationTests.swift
//  ValidationTests
//
//  Created by Hoff Henry Pereira da Silva on 01/10/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
// \(FieldName.name.rawValue)

import XCTest
import Validation

class RequiredFieldValidationTests: XCTestCase {

    func test_validate_should_return_error_when_field_was_not_provided() {
        let sut = RequiredFieldValidation(fieldName: .name)
        let errorMessage = sut.validate(data: ["" : ""])
        XCTAssertEqual(errorMessage, "O campo Nome é obrigatório")
    }

}
