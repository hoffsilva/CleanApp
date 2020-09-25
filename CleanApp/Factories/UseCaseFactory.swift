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
    
    private static let httpClient = AlamofireAdapter()
    
    static func createAddAccount() -> AddAccountUseCase {
        let addAccount = AddAccountUseCaseImplementation(url: createEndpoint(resource: Constants.Resource.signup), httpClient: httpClient)
        return addAccount
    }
    
    private static func createEndpoint(resource: String) -> URL {
        URL(string: "\(Constants.URL.base)\(resource)")!
    }
}
