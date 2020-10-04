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
        let validationComposite = ValidationComposite(validators: self.createValidations())
        let presenter = SignUpPresenter(
            alertView: WeakReferenceCycleProxy(instance: signUpViewController),
            addAccount: addAccount,
            loadingView: WeakReferenceCycleProxy(instance: signUpViewController),
            validation: validationComposite)
        signUpViewController.signUp = presenter.signUp
        return signUpViewController
    }
    
    private static func createValidations() -> [Validation] {
        [
            RequiredFieldValidation(fieldName: .name),
            RequiredFieldValidation(fieldName: .email),
            EmailValidation(fieldName: .email, emailValidator: EmailValidatorAdapter()),
            RequiredFieldValidation(fieldName: .password),
            RequiredFieldValidation(fieldName: .passwordConfirmation),
            CompareFieldValidation(fieldName: .password, fieldNameToCompare: .passwordConfirmation)
        ]
    }
    
}
