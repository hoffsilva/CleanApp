//
//  SignInPresenterTests.swift
//  PresentationTests
//
//  Created by Hoff Henry Pereira da Silva on 05/10/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import XCTest
import Presentation
import Domain

class SignInPresenterTests: XCTestCase {

    var expec: XCTestExpectation!
    
    func test_signIn_should_call_signIn_with_correct_values() {
        let signInSpy = SignInSpy()
        let sut = createSUT(signIn: signInSpy)
        let signInViewModel = createSignInViewModel()
        sut.signIn(viewModel: signInViewModel)
        XCTAssertEqual(signInSpy.signInModel, TestTools.createSignInModel())
    }
    
    func test_signIn_should_show_error_message_if_signIn_fails() {
        let alertViewSpy = AlertViewSpy()
        let signInSpy = SignInSpy()
        let sut = createSUT(alertView: alertViewSpy, signIn: signInSpy)
        let expected = createInvalidResponseAlertViewModel(message: "Algo inesperado aconteceu!")
        alertViewSpy.observeViewModel { (alertViewModel) in
            XCTAssertEqual(alertViewModel, expected)
        }
        let signInViewModel = createSignInViewModel()
        sut.signIn(viewModel: signInViewModel)
        signInSpy.completeWithError(.unexpected)
    }
    
    func test_signIn_should_show_error_emailInUse_message_if_addAccount_fails() {
        let alertViewSpy = AlertViewSpy()
        let signInSpy = SignInSpy()
        let sut = createSUT(alertView: alertViewSpy, signIn: signInSpy)
        let expected = createInvalidResponseAlertViewModel(message: "Algo inesperado aconteceu!")
        alertViewSpy.observeViewModel { (alertViewModel) in
            XCTAssertEqual(alertViewModel, expected)
        }
        let signInViewModel = createSignInViewModel()
        sut.signIn(viewModel: signInViewModel)
        signInSpy.completeWithError(.unexpected)
    }
    
    func test_signIn_should_show_loadingView_while_addAccount_is_processing() {
        let loadingView = LoadingViewSpy()
        let sut = createSUT(loadingView: loadingView)
        sut.signIn(viewModel: createSignInViewModel())
        loadingView.observeLoadingState { (state) in
            XCTAssertTrue(state)
        }
    }
    
    func test_signIn_should_hide_loadingView_when_addAccount_was_processed() {
        let loadingView = LoadingViewSpy()
        let signInSpy = SignInSpy()
        let sut = createSUT(signIn: signInSpy, loadingView: loadingView)
        sut.signIn(viewModel: createSignInViewModel())
        setUpExpectation()
        loadingView.observeLoadingState { [weak self] (state) in
            XCTAssertFalse(state)
            self?.expec.fulfill()
        }
        signInSpy.completeWithError(.unexpected)
        wait(for: [expec], timeout: 1)
    }
    
    func test_signIn_should_show_success_message_when_signIn_was_succeeded() {
        let alertView = AlertViewSpy()
        let signInSpy = SignInSpy()
        let sut = createSUT(alertView: alertView, signIn: signInSpy)
        setUpExpectation()
        alertView.observeViewModel { [weak self] (alertViewModel) in
            XCTAssertEqual(alertViewModel, self?.createValidResponseAlertViewModel(message: "Conta criada com sucesso!"))
            self?.expec.fulfill()
        }
        sut.signIn(viewModel: createSignInViewModel())
        signInSpy.completionWithAccount(account: TestTools.createAccountModel())
        wait(for: [expec], timeout: 1)
    }
    
    func test_signIn_should_call_validation_with_correct_values() {
        let validationSpy = ValidationSpy()
        let sut = createSUT(validation: validationSpy)
        let signInViewModel = createSignInViewModel()
        sut.signIn(viewModel: signInViewModel)
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: (signInViewModel.toData()?.toJSON()!)!))
    }
    
    func test_signIn_should_show_error_message_when_validation_fails() {
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
        sut.signIn(viewModel: createSignInViewModel())
        wait(for: [expec], timeout: 1)
    }
    
    
    
}



extension SignInPresenterTests {
    
    func setUpExpectation() {
        self.expec = expectation(description: "")
    }
    
    func createSUT(
        alertView: AlertView = AlertViewSpy(),
        signIn: SignInSpy = SignInSpy(),
        loadingView: LoadingView = LoadingViewSpy(),
        validation: Validation = ValidationSpy(),
        file: StaticString = #file,
        line: UInt = #line
    ) -> SignInPresenter {
        let sut = SignInPresenter(
            alertView: alertView,
            useCase: signIn,
            loadingView: loadingView,
            validation: validation)
        checkMemomryLeak(for: sut, file: file, line: line)
        return sut
    }
    
    func createSignInViewModel(email: String = "email.com", password: String = "123") -> SignInModel {
        SignInModel(email: email, password: password)
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
