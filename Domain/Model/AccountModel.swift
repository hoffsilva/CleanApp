//
//  AccountModel.swift
//  Domain
//
//  Created by Hoff Henry Pereira da Silva on 01/08/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

public struct AccountModel: Codable, Equatable {
    public let identifier: String
    public let name: String
    public let email: String
    public let password: String
    
    public init(
        identifier: String,
        name: String,
        email: String,
        password: String
    ) {
        self.identifier = identifier
        self.name = name
        self.email = email
        self.password = password
    }
}
