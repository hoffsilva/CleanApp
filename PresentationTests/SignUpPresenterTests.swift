//
//  SignUpPresenterTests.swift
//  SignUpPresenterTests
//
//  Created by Hoff Henry Pereira da Silva on 25/08/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import XCTest
import Presentation
import Domain
import Combine

class SignUpPresenterTests: XCTestCase {
    
    var expec: XCTestExpectation!
    var cancellable: AnyCancellable?
    
    func test_signUp_should_show_error_message_if_name_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = createSUT(alertView: alertViewSpy)
        let expected = createInvalidFieldAlertViewModel(fieldName: "NOME")
        setUpExpectation()
        alertViewSpy.observeViewModel { (alertViewModel) in
            XCTAssertEqual(alertViewModel, expected)
            self.expec.fulfill()
        }
        let signUpViewModel = createSignUpViewModel(name: nil)
        sut.signUp(viewModel: signUpViewModel)
        wait(for: [expec], timeout: 1)
    }
    
    func test_signUp_should_show_error_message_if_email_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = createSUT(alertView: alertViewSpy)
        let expected = createInvalidFieldAlertViewModel(fieldName: "E-MAIL")
        setUpExpectation()
        alertViewSpy.observeViewModel { (alertViewModel) in
            XCTAssertEqual(alertViewModel, expected)
            self.expec.fulfill()
        }
        let signUpViewModel = createSignUpViewModel(email: nil)
        sut.signUp(viewModel: signUpViewModel)
        wait(for: [expec], timeout: 1)
    }
    
    func test_signUp_should_show_error_message_if_password_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = createSUT(alertView: alertViewSpy)
        let expected = createInvalidFieldAlertViewModel(fieldName: "SENHA")
        setUpExpectation()
        alertViewSpy.observeViewModel { (alertViewModel) in
            XCTAssertEqual(alertViewModel, expected)
            self.expec.fulfill()
        }
        let signUpViewModel = createSignUpViewModel(password: nil)
        sut.signUp(viewModel: signUpViewModel)
        wait(for: [expec], timeout: 1)
    }
    
    func test_signUp_should_show_error_message_if_passwordConfirmation_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = createSUT(alertView: alertViewSpy)
        let expected = createInvalidFieldAlertViewModel(fieldName: "CONFIRMAR SENHA")
        setUpExpectation()
        alertViewSpy.observeViewModel { (alertViewModel) in
            XCTAssertEqual(alertViewModel, expected)
            self.expec.fulfill()
        }
        let signUpViewModel = createSignUpViewModel(passwordConfirmation: nil)
        sut.signUp(viewModel: signUpViewModel)
        wait(for: [expec], timeout: 1)
    }
    
    func test_signUp_should_show_error_message_if_passwordConfirmation_is_not_equal_to_password() {
        let alertViewSpy = AlertViewSpy()
        let sut = createSUT(alertView: alertViewSpy)
        let expected = AlertViewModel(title: "Campo Inválido", message: "A senha a confirmação devem ser iguais!")
        let signUpViewModel = createSignUpViewModel()
        sut.signUp(viewModel: signUpViewModel)
        alertViewSpy.observeViewModel { (alertViewModel) in
            XCTAssertNotEqual(alertViewModel, expected)
        }
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
        emailValidatorSpy.setEmailAsInvalid()
        let sut = createSUT(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
        let expected = AlertViewModel(title: "Campo Inválido", message: "Este email não é válido!")
        setUpExpectation()
        alertViewSpy.observeViewModel { (alertViewModel) in
            XCTAssertEqual(alertViewModel, expected)
            self.expec.fulfill()
        }
        let signUpViewModel = createSignUpViewModel()
        sut.signUp(viewModel: signUpViewModel)
        wait(for: [expec], timeout: 1)
    }
    
    func test_signUp_should_call_addAccount_with_correct_alues() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = createSUT(emailValidator: emailValidatorSpy)
        let signUpViewModel = createSignUpViewModel()
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(emailValidatorSpy.email, signUpViewModel.email)
    }
    
    func test_signUp_should_call_addAccount_with_correct_values() {
        let addAccountSpy = AddAccountSpy()
        let sut = createSUT(addAccount: addAccountSpy)
        let signUpViewModel = createSignUpViewModel()
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(addAccountSpy.addAccountModel, TestTools.createAddAccount())
    }
    
    func test_signUp_should_show_error_message_if_addAccount_fails() {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = createSUT(alertView: alertViewSpy, addAccount: addAccountSpy)
        let expected = createInvalidResponseAlertViewModel(message: "deu merda aqui!")
        alertViewSpy.observeViewModel { (alertViewModel) in
            XCTAssertEqual(alertViewModel, expected)
        }
        let signUpViewModel = createSignUpViewModel()
        sut.signUp(viewModel: signUpViewModel)
        addAccountSpy.completeWithError(.unexpected)
    }
    
    func test_signUp_should_show_loadingView_while_addAccount_is_processing() {
        let loadingView = LoadingViewSpy()
        let sut = createSUT(loadingView: loadingView)
        sut.signUp(viewModel: createSignUpViewModel())
        setUpExpectation()
        loadingView.observeLoadingState { [weak self] (state) in
            XCTAssertTrue(state)
            self?.expec.fulfill()
        }
        wait(for: [expec], timeout: 1)
    }
    
    func test_signUp_should_hide_loadingView_when_addAccount_was_processed() {
        let loadingView = LoadingViewSpy()
        let addAccount = AddAccountSpy()
        let sut = createSUT(addAccount: addAccount, loadingView: loadingView)
        sut.signUp(viewModel: createSignUpViewModel())
        setUpExpectation()
        loadingView.observeLoadingState { [weak self] (state) in
            XCTAssertFalse(state)
            self?.expec.fulfill()
        }
        addAccount.completeWithError(.unexpected)
        wait(for: [expec], timeout: 1)
    }
    
    func test_signUp_should_show_success_message_when_addAccount_was_succeeded() {
        let alertView = AlertViewSpy()
        let addAccount = AddAccountSpy()
        let sut = createSUT(alertView: alertView, addAccount: addAccount)
        setUpExpectation()
        alertView.observeViewModel { [weak self] (alertViewModel) in
            XCTAssertEqual(alertViewModel, self?.createValidResponseAlertViewModel(message: "Conta criada com sucesso!"))
            self?.expec.fulfill()
        }
        sut.signUp(viewModel: createSignUpViewModel())
        addAccount.completionWithAccount(account: TestTools.createAccountModel())
        wait(for: [expec], timeout: 1)
    }
}

extension SignUpPresenterTests {
    
    func setUpExpectation() {
        self.expec = expectation(description: "")
    }
    
    func createSUT(
        alertView: AlertView = AlertViewSpy(),
        emailValidator: EmailValidator = EmailValidatorSpy(),
        addAccount: AddAccountSpy = AddAccountSpy(),
        loadingView: LoadingView = LoadingViewSpy(),
        file: StaticString = #file,
        line: UInt = #line
    ) -> SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertView, emailValidator: emailValidator, addAccount: addAccount, loadingView: loadingView)
        checkMemomryLeak(for: sut, file: file, line: line)
        return sut
    }
    
    func createSignUpViewModel(name: String? = "name", email: String? = "email.com", password: String? = "123", passwordConfirmation: String? = "123") -> SignUpViewModel {
        SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
    }
    
    func createInvalidFieldAlertViewModel(fieldName: String) -> AlertViewModel {
        AlertViewModel(title: "Campo Inválido", message: "O campo \(fieldName) é obrigatório!")
    }
    
    func createInvalidResponseAlertViewModel(message: String) -> AlertViewModel {
        AlertViewModel(title: "Erro", message: message)
    }
    
    func createValidResponseAlertViewModel(message: String) -> AlertViewModel {
        AlertViewModel(title: "Sucesso", message: message)
    }
    
    class AlertViewSpy: AlertView {
        
        var observableViewModel: ((AlertViewModel) -> Void)?
        
        func observeViewModel(viewModel: @escaping (AlertViewModel) -> Void) {
            self.observableViewModel = viewModel
        }
        
        func showMessage(viewModel: AlertViewModel) {
            self.observableViewModel?(viewModel)
        }
    }
    
    class EmailValidatorSpy: EmailValidator {
        var isValid = true
        var email: String?
        func validate(email: String) -> Bool {
            self.email = email
            return isValid
        }
        
        func setEmailAsInvalid() {
            self.isValid = false
        }
        
    }
    
    class AddAccountSpy: AddAccountUseCase {
        
        var addAccountModel: AddAccountModel?
        var completion: ((Result<AccountModel, DomainError>) -> Void)?
        
        func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
            self.addAccountModel = addAccountModel
            self.completion = completion
        }
        
        func completeWithError(_ error: DomainError) {
            completion?(.failure(error))
        }
        
        func completionWithAccount(account: AccountModel) {
            completion?(.success(account))
        }
    }
    
    class LoadingViewSpy: LoadingView {
        
        var observableLoadingState: ((Bool) -> Void)?
        
        func observeLoadingState(loadingState: @escaping (Bool) -> Void) {
            self.observableLoadingState = loadingState
        }
        
        func show() {
            self.observableLoadingState?(true)
        }
        
        func hide() {
            self.observableLoadingState?(false)
        }
    }
    
}

