//
//  SignUpPresenterTests.swift
//  SignUpPresenterTests
//
//  Created by Hoff Henry Pereira da Silva on 25/08/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import XCTest
@testable import Presentation

class SignUpPresenterTests: XCTestCase {
    
    func test_signUp_should_show_error_message_if_name_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = createSUT(alertView: alertViewSpy)
        let signUpViewModel = createSignUpViewModel(name: nil)
        sut.signUp(viewModel: signUpViewModel)
        let expected = AlertViewModel(title: "Campo Inválido", message: "O nome é obrigatório!")
        XCTAssertEqual(alertViewSpy.viewModel, expected)
    }
    
    func test_signUp_should_show_error_message_if_email_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = createSUT(alertView: alertViewSpy)
        let signUpViewModel = createSignUpViewModel(email: nil)
        sut.signUp(viewModel: signUpViewModel)
        let expected = AlertViewModel(title: "Campo Inválido", message: "O email é obrigatório!")
        XCTAssertEqual(alertViewSpy.viewModel, expected)
    }
    
    func test_signUp_should_show_error_message_if_password_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = createSUT(alertView: alertViewSpy)
        let signUpViewModel = createSignUpViewModel(password: nil)
        sut.signUp(viewModel: signUpViewModel)
        let expected = AlertViewModel(title: "Campo Inválido", message: "A senha é obrigatória!")
        XCTAssertEqual(alertViewSpy.viewModel, expected)
    }
    
    func test_signUp_should_show_error_message_if_passwordConfirmation_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = createSUT(alertView: alertViewSpy)
        let signUpViewModel = createSignUpViewModel(passwordConfirmation: nil)
        sut.signUp(viewModel: signUpViewModel)
        let expected = AlertViewModel(title: "Campo Inválido", message: "A confirmação da senha é obrigatória!")
        XCTAssertEqual(alertViewSpy.viewModel, expected)
    }
    
    func test_signUp_should_show_error_message_if_passwordConfirmation_is_not_equal_to_password() {
        let alertViewSpy = AlertViewSpy()
        let sut = createSUT(alertView: alertViewSpy)
        let signUpViewModel = createSignUpViewModel()
        sut.signUp(viewModel: signUpViewModel)
        let expected = AlertViewModel(title: "Campo Inválido", message: "A senha a confirmação devem ser iguais!")
        XCTAssertNotEqual(alertViewSpy.viewModel, expected)
    }
    
    func test_signUp_should_show_call_emailValidator_with_correct_email() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = createSUT(emailValidator: emailValidatorSpy)
        let signUpViewModel = createSignUpViewModel()
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(emailValidatorSpy.email, signUpViewModel.email)
    }
    
    func test_signUp_should_show_error_message_if_email_is_incorrect() {
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        emailValidatorSpy.isValid = false
        let sut = createSUT(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
        let signUpViewModel = createSignUpViewModel()
        sut.signUp(viewModel: signUpViewModel)
        let expected = AlertViewModel(title: "Campo Inválido", message: "Este email não é válido!")
        XCTAssertEqual(alertViewSpy.viewModel, expected)
    }
    
    func test_signUp_should_call_addAccount_with_correct_alues() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = createSUT(emailValidator: emailValidatorSpy)
        let signUpViewModel = createSignUpViewModel()
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(emailValidatorSpy.email, signUpViewModel.email)
    }
    
}

extension SignUpPresenterTests {
    
    func createSUT(
        alertView: AlertView = AlertViewSpy(),
        emailValidator: EmailValidator = EmailValidatorSpy()
    ) -> SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertView, emailValidator: emailValidator)
        return sut
    }
    
    func createSignUpViewModel(name: String? = "name", email: String? = "email.com", password: String? = "123", passwordConfirmation: String? = "123") -> SignUpViewModel {
        SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
    }
    
    class AlertViewSpy: AlertView {
        
        var viewModel: AlertViewModel?
        
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
    }
    
    class EmailValidatorSpy: EmailValidator {
        var isValid = true
        var email: String?
        func validate(email: String) -> Bool {
            self.email = email
            return isValid
        }
    }
    
}

