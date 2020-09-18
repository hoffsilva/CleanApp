//
//  SignUpViewControllerTests.swift
//  SignUpViewControllerTests
//
//  Created by Hoff Henry Pereira da Silva on 12/09/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import XCTest
import Presentation
@testable import UI

class SignUpViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start() {
        let sut = createSUT()
        sut.loadViewIfNeeded()
        XCTAssertTrue(sut.signUpView.activityIndicator.isHidden)
    }
    
    func test_signUpViewController_implements_loadingView() {
        let sut = createSUT()
        XCTAssertNotNil(sut as LoadingView)
    }
    
    func test_signUpViewController_implements_alertView() {
        let sut = createSUT()
        XCTAssertNotNil(sut as AlertView)
    }
    
    func test_signUpViewController_createAccountButton_tap_calls_signupMethod() {
        var callCounter = 0
        let signUpSpy: () -> Void = {
            callCounter += 1
        }
        let sut = createSUT(signUpSpy: signUpSpy)
        sut.signUpView.createAccountButton.simulateTap()
        XCTAssertEqual(callCounter, 1)
    }

}

extension SignUpViewControllerTests {
    
    func createSUT(signUpSpy: (() -> Void)? = nil ) -> SignUpViewController {
        let signUpView = SignUpView()
        let sut = SignUpViewController(signUpView: signUpView)
        sut.signUp = signUpSpy
        sut.loadViewIfNeeded()
        return sut
    }
    
}


