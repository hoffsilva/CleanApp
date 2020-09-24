//
//  UseCaseFactory.swift
//  CleanApp
//
//  Created by Hoff Henry Pereira da Silva on 24/09/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Domain
import Infra
import Data

final class UseCaseFctory {
    static func createAddAccount() -> AddAccountUseCase {
        let alamoFireAdapter = AlamofireAdapter()
        let addAccount = AddAccountUseCaseImplementation(url: URL(string: Constants.baseURL)!, httpClient: alamoFireAdapter)
        return addAccount
    }
}
