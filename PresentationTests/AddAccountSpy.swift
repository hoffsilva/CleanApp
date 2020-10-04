//
//  AddAccountSpy.swift
//  PresentationTests
//
//  Created by Hoff Henry Pereira da Silva on 24/09/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Domain

class AddAccountSpy: AddAccountUseCase {
    
    var addAccountModel: AddAccountModel?
    var completion: ((AddAccountUseCase.Result) -> Void)?
    
    func add(addAccountModel: AddAccountModel, completion: @escaping (AddAccountUseCase.Result) -> Void) {
        self.addAccountModel = addAccountModel
        self.completion = completion
    }
    
    func completeWithError(_ error: DomainError) {
        completion?(.failure(error))
    }
    
    func completionWithAccount(account: AccountModel) {
        completion?(.success(account))
    }
}
