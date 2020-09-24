//
//  SignUpIntegrationTests.swift
//  CleanAppTests
//
//  Created by Hoff Henry Pereira da Silva on 24/09/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import XCTest
@testable import CleanApp

class SignUpIntegrationTests: XCTestCase {

    func testExample() {
        let sut = SignUpComposer.composeControllerWith(AddAccountSpy())
        checkMemomryLeak(for: sut)
    }

}
