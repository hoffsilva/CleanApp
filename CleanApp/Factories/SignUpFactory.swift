//
//  SignUpFactory.swift
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

class SignUpFactory {
    static func createController() -> SignUpViewController {
        let signUpViewController = SignUpViewController(signUpView: SignUpView())
        let emailValidator = EmailValidatorAdapter()
        let alamoFireAdapter = AlamofireAdapter()
        let addAccount = AddAccountUseCaseImplementation(url: URL(string: Constants.baseURL)!, httpClient: alamoFireAdapter)
        let presenter = SignUpPresenter(
            alertView: signUpViewController,
            emailValidator: emailValidator,
            addAccount: addAccount,
            loadingView: signUpViewController)
        signUpViewController.signUp = presenter.signUp
        return signUpViewController
    }
}
