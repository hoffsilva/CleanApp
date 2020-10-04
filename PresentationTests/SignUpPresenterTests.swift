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

class SignUpPresenterTests: XCTestCase {
    
    var expec: XCTestExpectation!
    
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
        let expected = createInvalidResponseAlertViewModel(message: "Algo inesperado aconteceu!")
        alertViewSpy.observeViewModel { (alertViewModel) in
            XCTAssertEqual(alertViewModel, expected)
        }
        let signUpViewModel = createSignUpViewModel()
        sut.signUp(viewModel: signUpViewModel)
        addAccountSpy.completeWithError(.unexpected)
    }
    
    func test_signUp_should_show_error_emailInUse_message_if_addAccount_fails() {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = createSUT(alertView: alertViewSpy, addAccount: addAccountSpy)
        let expected = createInvalidResponseAlertViewModel(message: "Esse email já foi cadastrado!")
        alertViewSpy.observeViewModel { (alertViewModel) in
            XCTAssertEqual(alertViewModel, expected)
        }
        let signUpViewModel = createSignUpViewModel()
        sut.signUp(viewModel: signUpViewModel)
        addAccountSpy.completeWithError(.emailInUse)
    }
    
    func test_signUp_should_show_loadingView_while_addAccount_is_processing() {
        let loadingView = LoadingViewSpy()
        let sut = createSUT(loadingView: loadingView)
        sut.signUp(viewModel: createSignUpViewModel())
        loadingView.observeLoadingState { (state) in
            XCTAssertTrue(state)
        }
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
    
    func test_signUp_should_call_validation_with_correct_values() {
        let validationSpy = ValidationSpy()
        let sut = createSUT(validation: validationSpy)
        let signUpViewModel = createSignUpViewModel()
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: (signUpViewModel.toData()?.toJSON()!)!))
    }
    
    func test_signUp_should_show_error_message_when_validation_fails() {
        let alertViewSpy = AlertViewSpy()
        let validationSpy = ValidationSpy()
        let sut = createSUT(alertView: alertViewSpy, validation: validationSpy)
        let expected = AlertViewModel(title: "Falha na validação", message: "Erro")
        setUpExpectation()
        alertViewSpy.observeViewModel { (alertViewModel) in
            XCTAssertEqual(alertViewModel, expected)
            self.expec.fulfill()
        }
        validationSpy.simulateError()
        sut.signUp(viewModel: createSignUpViewModel())
        wait(for: [expec], timeout: 1)
    }
    
    
    
}



extension SignUpPresenterTests {
    
    func setUpExpectation() {
        self.expec = expectation(description: "")
    }
    
    func createSUT(
        alertView: AlertView = AlertViewSpy(),
        addAccount: AddAccountSpy = AddAccountSpy(),
        loadingView: LoadingView = LoadingViewSpy(),
        validation: Validation = ValidationSpy(),
        file: StaticString = #file,
        line: UInt = #line
    ) -> SignUpPresenter {
        let sut = SignUpPresenter(
            alertView: alertView,
            addAccount: addAccount,
            loadingView: loadingView,
            validation: validation)
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
