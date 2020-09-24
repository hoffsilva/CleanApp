//
//  ControllerFactory.swift
//  CleanApp
//
//  Created by Hoff Henry Pereira da Silva on 19/09/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import UI
import Presentation
import Validation
import Data
import Infra
import Domain

class ControllerFactory {
    static func createSignUp(addAccount: AddAccountUseCase) -> SignUpViewController {
        let signUpViewController = SignUpViewController(signUpView: SignUpView())
        let emailValidator = EmailValidatorAdapter()
        let presenter = SignUpPresenter(
            alertView: Proxy(instance: signUpViewController),
            emailValidator: emailValidator,
            addAccount: addAccount,
            loadingView: Proxy(instance: signUpViewController))
        signUpViewController.signUp = presenter.signUp
        return signUpViewController
    }
}

class Proxy<Element: AnyObject> {
    private weak var instance: Element?
    
    init(instance: Element) {
        self.instance = instance
    }
}

extension Proxy: AlertView where Element: AlertView {
    func showMessage(viewModel: AlertViewModel) {
        instance?.showMessage(viewModel: viewModel)
    }
}

extension Proxy: LoadingView where Element: LoadingView {
    func show() {
        instance?.show()
    }

    func hide() {
        instance?.hide()
    }
}
