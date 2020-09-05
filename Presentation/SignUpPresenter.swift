//
//  SignUpPresenter.swift
//  Presentation
//
//  Created by Hoff Henry Pereira da Silva on 25/08/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

public final class SignUpPresenter {
    
    private let alertView: AlertView
    private let emailValidator: EmailValidator
    
    public init(alertView: AlertView,
                emailValidator: EmailValidator) {
        self.alertView = alertView
        self.emailValidator = emailValidator
    }
    
    public func signUp(viewModel: SignUpViewModel) {
        if let message = validateField(viewModel: viewModel) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Campo Inválido", message: message))
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
