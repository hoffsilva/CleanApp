//
//  SignInSpy.swift
//  PresentationTests
//
//  Created by Hoff Henry Pereira da Silva on 24/09/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Domain

class SignInSpy: SignInUseCase {
    
    var signInModel: SignInModel?
    var completion: ((SignInUseCase.Result) -> Void)?
    
    func signIn(signInModel: SignInModel, completion: @escaping (SignInUseCase.Result) -> Void) {
        self.signInModel = signInModel
        self.completion = completion
    }
    
    func completeWithError(_ error: DomainError) {
        completion?(.failure(error))
    }
    
    func completionWithAccount(account: AccountModel) {
        completion?(.success(account))
    }
}
