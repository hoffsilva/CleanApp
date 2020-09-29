//
//  SignUpViewModel.swift
//  Presentation
//
//  Created by Hoff Henry Pereira da Silva on 25/08/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Domain

public struct SignUpViewModel: Equatable, Codable {
    public var name: String?
    public var email: String?
    public var password: String?
    public var passwordConfirmation: String?
    
    public init(
        name: String? = nil,
        email: String? = nil,
        password: String? = nil,
        passwordConfirmation: String? = nil
    ){
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
}

extension SignUpViewModel {
    public func asAddAccountModel() -> AddAccountModel? {
        guard let name = self.name,
            let email = self.email,
            let password = self.password,
            let passwordConfirmation = self.passwordConfirmation else { return nil }
        return AddAccountModel(
            name: name,
            email: email,
            password: password,
            passwordConfirmation: passwordConfirmation
        )
    }
}
