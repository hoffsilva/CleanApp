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
        let signUpViewModel = SignUpViewModel(email: "email", password: "123", passwordConfirmation: "123")
        sut.signUp(viewModel: signUpViewModel)
        let expected = AlertViewModel(title: "Campo Inválido", message: "O nome é obrigatório!")
        XCTAssertEqual(alertViewSpy.viewModel, expected)
    }
    
    func test_signUp_should_show_error_message_if_email_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = createSUT(alertView: alertViewSpy)
        let signUpViewModel = SignUpViewModel(name: "name", password: "123", passwordConfirmation: "123")
        sut.signUp(viewModel: signUpViewModel)
        let expected = AlertViewModel(title: "Campo Inválido", message: "O email é obrigatório!")
        XCTAssertEqual(alertViewSpy.viewModel, expected)
    }
    
    func test_signUp_should_show_error_message_if_password_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = createSUT(alertView: alertViewSpy)
        let signUpViewModel = SignUpViewModel(name: "name", email: "email", passwordConfirmation: "123")
        sut.signUp(viewModel: signUpViewModel)
        let expected = AlertViewModel(title: "Campo Inválido", message: "A senha é obrigatória!")
        XCTAssertEqual(alertViewSpy.viewModel, expected)
    }
    
    func test_signUp_should_show_error_message_if_passwordConfirmation_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = createSUT(alertView: alertViewSpy)
        let signUpViewModel = SignUpViewModel(name: "name", email: "email", password: "123")
        sut.signUp(viewModel: signUpViewModel)
        let expected = AlertViewModel(title: "Campo Inválido", message: "A confirmação da senha é obrigatória!")
        XCTAssertEqual(alertViewSpy.viewModel, expected)
    }
    
    func test_signUp_should_show_error_message_if_passwordConfirmation_is_not_equal_to_password() {
        let alertViewSpy = AlertViewSpy()
        let sut = createSUT(alertView: alertViewSpy)
        let signUpViewModel = SignUpViewModel(name: "name", email: "email", password: "123", passwordConfirmation: "123")
        sut.signUp(viewModel: signUpViewModel)
        let expected = AlertViewModel(title: "Campo Inválido", message: "A senha a confirmação devem ser iguais!")
        XCTAssertNotEqual(alertViewSpy.viewModel, expected)
    }
    
    func test_signUp_should_show_call_emailValidator_with_correct_email() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = createSUT(emailValidator: emailValidatorSpy)
        let signUpViewModel = SignUpViewModel(name: "name", email: "email@email.com", password: "123", passwordConfirmation: "123")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(emailValidatorSpy.email, signUpViewModel.email)
    }
    
    func test_signUp_should_show_error_message_if_email_is_incorrect() {
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        emailValidatorSpy.isValid = false
        let sut = createSUT(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
        let signUpViewModel = SignUpViewModel(name: "name", email: "email.com", password: "123", passwordConfirmation: "123")
        sut.signUp(viewModel: signUpViewModel)
        let expected = AlertViewModel(title: "Campo Inválido", message: "Este email não é válido!")
        XCTAssertEqual(alertViewSpy.viewModel, expected)
    }
    
    func test_signUp_should_call_addAccount_with_correct_alues() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = createSUT(emailValidator: emailValidatorSpy)
        let signUpViewModel = SignUpViewModel(name: "name", email: "email@email.com", password: "123", passwordConfirmation: "123")
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

