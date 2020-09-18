//
//  SignUpViewControllerTests.swift
//  SignUpViewControllerTests
//
//  Created by Hoff Henry Pereira da Silva on 12/09/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import XCTest
import Presentation
import Domain
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
        var signUpViewModel: SignUpViewModel?
        let signUpSpy: (SignUpViewModel) -> Void = { signUpViewModel = $0 }
        let sut = createSUT(signUpSpy: signUpSpy)
        let  expectedSignUpViewModel = SignUpViewModel(
            name: sut.signUpView.nameTextField.text,
            email: sut.signUpView.emailTextField.text,
            password: sut.signUpView.passwordTextField.text,
            passwordConfirmation: sut.signUpView.passwordConfirmationTextField.text)
        sut.signUpView.createAccountButton.simulateTap()
        XCTAssertEqual(expectedSignUpViewModel, signUpViewModel)
    }

}

extension SignUpViewControllerTests {
    
    func createSUT(signUpSpy: ((SignUpViewModel) -> Void)? = nil ) -> SignUpViewController {
        let signUpView = SignUpView()
        let sut = SignUpViewController(signUpView: signUpView)
        sut.signUp = signUpSpy
        sut.loadViewIfNeeded()
        return sut
    }
    
}


