//
//  ValidationCompositeTests.swift
//  ValidationTests
//
//  Created by Hoff Henry Pereira da Silva on 02/10/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import XCTest
import Presentation

class ValidationCompositeTests: XCTestCase {

    func test_validate_should_return_error_when_any_validator_fails() {
        let sut = ValidationComposite(validators: [Validation])
    }

}
