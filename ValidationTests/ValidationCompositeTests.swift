//
//  ValidationCompositeTests.swift
//  ValidationTests
//
//  Created by Hoff Henry Pereira da Silva on 02/10/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import XCTest
import Presentation
import Validation

class ValidationCompositeTests: XCTestCase {

    func test_validate_should_return_error_when_any_validator_fails() {
        let validadtionSpy = ValidationSpy()
        validadtionSpy.simulateError("Erro 1")
        let sut = ValidationComposite(validators: [validadtionSpy])
        let errorMessage = sut.validate(data: ["":""])
        XCTAssertEqual(errorMessage, "Erro 1")
    }
    
    func test_validate_should_return_nil_when_any_validator_succeed() {
        let validadtionSpy = ValidationSpy()
        let sut = ValidationComposite(validators: [validadtionSpy])
        let errorMessage = sut.validate(data: ["":""])
        XCTAssertNil(errorMessage)
    }

}
