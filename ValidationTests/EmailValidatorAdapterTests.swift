//
//  EmailValidatorAdapterTests.swift
//  EmailValidatorAdapterTests
//
//  Created by Hoff Henry Pereira da Silva on 18/09/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import XCTest

class EmailValidatorAdapterTests: XCTestCase {

    func test_email_when_isInvalid() {
        let sut = createSUT()
        XCTAssertFalse(sut.validate(email: ""))
        XCTAssertFalse(sut.validate(email: "as"))
        XCTAssertFalse(sut.validate(email: "as@"))
        XCTAssertFalse(sut.validate(email: "sa@as"))
        XCTAssertFalse(sut.validate(email: "as@as."))
        XCTAssertFalse(sut.validate(email: "@as.as"))
    }
    
    func test_email_when_isValid() {
        let sut = createSUT()
        XCTAssertTrue(sut.validate(email: "hoff.silva@outlook.com"))
        XCTAssertTrue(sut.validate(email: "hoff.silva@gmail.com"))
        XCTAssertTrue(sut.validate(email: "hoff.silva@1234.com"))
    }

}

extension EmailValidatorAdapterTests {
    
    func createSUT() -> EmailValidatorAdapter {
        EmailValidatorAdapter()
    }
    
}
