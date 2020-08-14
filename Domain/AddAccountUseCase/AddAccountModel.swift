//
//  AddAccountModel.swift
//  Domain
//
//  Created by Hoff Henry Pereira da Silva on 01/08/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

public struct AddAccountModel: Codable {
    public let name: String
    public let email: String
    public let password: String
    public let passwordConfirmation: String
    
    public init(
        name: String,
        email: String,
        password: String,
        passwordConfirmation: String
    ) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
}
