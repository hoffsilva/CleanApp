//
//  EmailValidationTests.swift
//  ValidationTests
//
//  Created by Hoff Henry Pereira da Silva on 02/10/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import XCTest
import Validation

class EmailValidationTests: XCTestCase {
    
    func test_validate_should_return_error_message_when_email_is_invalid() {
        let emailValidatorSpy = EmailValidatorSpy()
        emailValidatorSpy.setEmailAsInvalid()
        let sut = EmailValidation(fieldName: .email, emailValidator: emailValidatorSpy)
        let errorMessage = sut.validate(data: [FieldName.email.rawValue:"email@invalid"])
        XCTAssertEqual(errorMessage, "O campo E-mail é inválido")
    }
    
    func test_validate_should_return_nil_when_email_is_valid() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = EmailValidation(fieldName: .email, emailValidator: emailValidatorSpy)
        let errorMessage = sut.validate(data: [FieldName.email.rawValue:"email@valid.com"])
        XCTAssertNil(errorMessage)
    }
    
}
