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
    
    public init(alertView: AlertView) {
        self.alertView = alertView
    }
    
    public func signUp(viewModel: SignUpViewModel) {
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
