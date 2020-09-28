//
//  SignUpIntegrationTests.swift
//  CleanAppTests
//
//  Created by Hoff Henry Pereira da Silva on 24/09/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import XCTest
import UI
@testable import CleanApp

class SignUpIntegrationTests: XCTestCase {

    func test_background_request_should_complete_on_main_thread() {
        let addAccountSpy = AddAccountSpy()
        let sut = createSUT(addAccountSpy: addAccountSpy)
        sut.loadViewIfNeeded()
        DispatchQueue.global().async {
            addAccountSpy.completeWithError(.unexpected)
        }
    }

}

extension SignUpIntegrationTests {
    func createSUT(addAccountSpy: AddAccountSpy, file: StaticString = #filePath, line: UInt = #line) -> SignUpViewController {
        let sut = SignUpComposer.composeControllerWith(addAccountSpy)
        checkMemomryLeak(for: sut, file: file, line: line)
        checkMemomryLeak(for: addAccountSpy, file: file, line: line)
        return sut
    }
}
