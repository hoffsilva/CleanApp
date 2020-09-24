//
//  SignUpComposer.swift
//  CleanApp
//
//  Created by Hoff Henry Pereira da Silva on 24/09/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Domain
import UI

public final class SignUpComposer {
    
    static func composeControllerWith(_ addAccount: AddAccountUseCase) -> SignUpViewController {
        ControllerFactory.createSignUp(addAccount: addAccount)
    }
    
}

