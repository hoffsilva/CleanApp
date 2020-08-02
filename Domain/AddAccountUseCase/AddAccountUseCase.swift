//
//  AddAccountUseCase.swift
//  Domain
//
//  Created by Hoff Henry Pereira da Silva on 01/08/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

protocol AddAccountUseCase {
    func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, Error>) -> Void)
}
