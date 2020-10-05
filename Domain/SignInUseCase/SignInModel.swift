//
//  SignInModel.swift
//  Domain
//
//  Created by Hoff Henry Pereira da Silva on 05/10/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

public struct SignInModel: Codable, Equatable {
    
    let email: String
    let password: String
    
    public init(
        email: String,
        password: String
    ) {
        self.email = email
        self.password = password
    }
    
    
}
