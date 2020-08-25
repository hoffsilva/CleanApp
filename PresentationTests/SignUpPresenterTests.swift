//
//  SignUpPresenterTests.swift
//  SignUpPresenterTests
//
//  Created by Hoff Henry Pereira da Silva on 25/08/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import XCTest

class SignUpPresenter {
    
    private let alertView: AlertView
    
    init(alertView: AlertView) {
        self.alertView = alertView
    }
    
    func signUp(viewModel: SignUpViewModel) {
        if let message = validateField(viewModel: viewModel) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Campo Inválido", message: message))
        }
    }
    
    private func validateField(viewModel: SignUpViewModel) -> String? {
        if viewModel.name == nil || viewModel.name!.isEmpty {
            return "O nome é obrigatório!"
        } else if viewModel.email == nil || viewModel.email!.isEmpty {
            return "O email é obrigatório!"
        }  else if viewModel.password == nil || viewModel.password!.isEmpty {
            return "A senha é obrigatória!"
        }  else if viewModel.passwordConfirmation == nil || viewModel.passwordConfirmation!.isEmpty {
            return "A confirmação da senha é obrigatória!"
        }
        return nil
    }
    
}

protocol AlertView {
    func showMessage(viewModel: AlertViewModel)
}

struct AlertViewModel: Equatable {
    var title: String?
    var message: String?
    
}

struct SignUpViewModel {
    var name: String?
    var email: String?
    var password: String?
    var passwordConfirmation: String?
}

class SignUpPresenterTests: XCTestCase {
    
    func test_signUp_should_show_error_message_if_name_is_not_provided() {
        let (sut, alertViewSpy) = createSUT()
        let signUpViewModel = SignUpViewModel(email: "email", password: "123", passwordConfirmation: "123")
        sut.signUp(viewModel: signUpViewModel)
        let expected = AlertViewModel(title: "Campo Inválido", message: "O nome é obrigatório!")
        XCTAssertEqual(alertViewSpy.viewModel, expected)
    }
    
    func test_signUp_should_show_error_message_if_email_is_not_provided() {
        let (sut, alertViewSpy) = createSUT()
        let signUpViewModel = SignUpViewModel(name: "name", password: "123", passwordConfirmation: "123")
        sut.signUp(viewModel: signUpViewModel)
        let expected = AlertViewModel(title: "Campo Inválido", message: "O email é obrigatório!")
        XCTAssertEqual(alertViewSpy.viewModel, expected)
    }
    
    func test_signUp_should_show_error_message_if_password_is_not_provided() {
        let (sut, alertViewSpy) = createSUT()
        let signUpViewModel = SignUpViewModel(name: "name", email: "email", passwordConfirmation: "123")
        sut.signUp(viewModel: signUpViewModel)
        let expected = AlertViewModel(title: "Campo Inválido", message: "A senha é obrigatória!")
        XCTAssertEqual(alertViewSpy.viewModel, expected)
    }
    
    func test_signUp_should_show_error_message_if_passwordConfirmation_is_not_provided() {
        let (sut, alertViewSpy) = createSUT()
        let signUpViewModel = SignUpViewModel(name: "name", email: "email", password: "123")
        sut.signUp(viewModel: signUpViewModel)
        let expected = AlertViewModel(title: "Campo Inválido", message: "A confirmação da senha é obrigatória!")
        XCTAssertEqual(alertViewSpy.viewModel, expected)
    }
    
}

extension SignUpPresenterTests {
    
    func createSUT() -> (SignUpPresenter, AlertViewSpy) {
        let alertViewSpy = AlertViewSpy()
        let sut = SignUpPresenter(alertView: alertViewSpy)
        return (sut, alertViewSpy)
    }
    
    class AlertViewSpy: AlertView {
        
        var viewModel: AlertViewModel?
        
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
    }
    
}
