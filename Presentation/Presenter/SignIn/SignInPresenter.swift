//
//  SignInPresenter.swift
//  Presentation
//
//  Created by Hoff Henry Pereira da Silva on 06/10/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Domain

public final class SignInPresenter {
    
    private let alertView: AlertView
    private let useCase: SignInUseCase
    private let loadingView: LoadingView
    private let validation: Validation
    
    public init(alertView: AlertView,
                useCase: SignInUseCase,
                loadingView: LoadingView,
                validation: Validation) {
        self.alertView = alertView
        self.useCase = useCase
        self.loadingView = loadingView
        self.validation = validation
    }
    
    public func signIn(viewModel: SignInModel) {
        if let message = validation.validate(data: viewModel.toData()?.toJSON()) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        } else {
            self.loadingView.show()
            useCase.signIn(signInModel: viewModel) { [weak self] response in
                switch response {
                case .failure(let error):
                    var errorMessage = ""
                    switch error {
                    case .emailInUse:
                        errorMessage = "Esse email já foi cadastrado!"
                    default:
                        errorMessage = "Algo inesperado aconteceu!"
                    }
                    self?.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: errorMessage))
                case .success:
                    self?.alertView.showMessage(viewModel: AlertViewModel(title: "Sucesso", message: "Conta criada com sucesso!"))
                }
                self?.loadingView.hide()
                
            }
        }
    }
}
