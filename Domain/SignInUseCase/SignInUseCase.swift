//
//  SignInUseCase.swift
//  Domain
//
//  Created by Hoff Henry Pereira da Silva on 05/10/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

public protocol SignInUseCase {
    typealias Result = Swift.Result<AccountModel, DomainError>
    func signIn(signInModel: SignInModel, completion: @escaping (Result) -> Void)
}
