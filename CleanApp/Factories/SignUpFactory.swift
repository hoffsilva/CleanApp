//
//  SignUpFactory.swift
//  CleanApp
//
//  Created by Hoff Henry Pereira da Silva on 19/09/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import UI

class SignUpFactory {
    static func createController() -> SignUpViewController {
        
        let signUpViewController = SignUpViewController(signUpView: SignUpView())
//        signUpViewController.signUp = 
        return signUpViewController
    }
}
