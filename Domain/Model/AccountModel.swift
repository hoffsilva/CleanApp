//
//  AccountModel.swift
//  Domain
//
//  Created by Hoff Henry Pereira da Silva on 01/08/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

public struct AccountModel: Codable, Equatable {
    public let accessToken: String
    
    public init(
        accessToken: String
    ) {
        self.accessToken = accessToken
    }
}
