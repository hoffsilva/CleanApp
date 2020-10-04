//
//  SignUpPresenter.swift
//  Presentation
//
//  Created by Hoff Henry Pereira da Silva on 25/08/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Domain

public final class SignUpPresenter {
    
    private let alertView: AlertView
    private let addAccount: AddAccountUseCase
    private let loadingView: LoadingView
    private let validation: Validation
    
    public init(alertView: AlertView,
                addAccount: AddAccountUseCase,
                loadingView: LoadingView,
                validation: Validation) {
        self.alertView = alertView
        self.addAccount = addAccount
        self.loadingView = loadingView
        self.validation = validation
    }
    
    public func signUp(viewModel: SignUpViewModel) {
        if let message = validation.validate(data: viewModel.toData()?.toJSON()) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        } else {
            guard let addAccountModel = viewModel.asAddAccountModel() else { return }
            self.loadingView.show()
            addAccount.add(addAccountModel: addAccountModel, completion: { [weak self] response in
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
            })
        }
    }
}
