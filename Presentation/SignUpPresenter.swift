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
    private let emailValidator: EmailValidator
    private let addAccount: AddAccountUseCase
    private let loadingView: LoadingView
    
    public init(alertView: AlertView,
                emailValidator: EmailValidator,
                addAccount: AddAccountUseCase,
                loadingView: LoadingView) {
        self.alertView = alertView
        self.emailValidator = emailValidator
        self.addAccount = addAccount
        self.loadingView = loadingView
    }
    
    public func signUp(viewModel: SignUpViewModel) {
        if let message = validateField(viewModel: viewModel) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Campo Inválido", message: message))
        } else {
            guard let name = viewModel.name,
                let email = viewModel.email,
                let password = viewModel.password,
                let passwordConfirmation = viewModel.passwordConfirmation else { return }
            let addAccountModel = AddAccountModel(
                name: name,
                email: email,
                password: password,
                passwordConfirmation: passwordConfirmation
            )
            self.loadingView.show()
            addAccount.add(addAccountModel: addAccountModel, completion: { [weak self] response in
                switch response {
                case .failure:
                    self?.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "deu merda aqui!"))
                case .success:
                    self?.alertView.showMessage(viewModel: AlertViewModel(title: "Sucesso", message: "Conta criada com sucesso!"))
                }
                self?.loadingView.hide()
            })
        }
    }
    
    private func validateField(viewModel: SignUpViewModel) -> String? {
        if viewModel.name == nil || viewModel.name!.isEmpty {
            return "O campo NOME é obrigatório!"
        } else if viewModel.email == nil || viewModel.email!.isEmpty {
            return "O campo E-MAIL é obrigatório!"
        }  else if viewModel.password == nil || viewModel.password!.isEmpty {
            return "O campo SENHA é obrigatório!"
        }  else if viewModel.passwordConfirmation == nil || viewModel.passwordConfirmation!.isEmpty {
            return "O campo CONFIRMAR SENHA é obrigatório!"
        }  else if viewModel.passwordConfirmation != viewModel.password {
            return "A senha a confirmação devem ser iguais!"
        } else if !emailValidator.validate(email: viewModel.email!) {
            return "Este email não é válido!"
        }
        return nil
    }
    
}
