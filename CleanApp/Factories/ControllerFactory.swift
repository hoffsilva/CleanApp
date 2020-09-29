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
            alertView: WaekReferenceCycleProxy(instance: signUpViewController),
            emailValidator: emailValidator,
            addAccount: addAccount,
            loadingView: WaekReferenceCycleProxy(instance: signUpViewController), validation: <#Validation#>)
        signUpViewController.signUp = presenter.signUp
        return signUpViewController
    }
}
