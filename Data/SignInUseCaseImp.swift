//
//  SignInUseCaseImp.swift
//  Data
//
//  Created by Hoff Henry Pereira da Silva on 05/10/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Domain

public final class SignInUseCaseImp: SignInUseCase {
    
    private let url: URL
    private let httpClient: HttpPostClient
    
    public init(url: URL,
                httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func signIn(signInModel: SignInModel, completion: @escaping (Result<AccountModel,DomainError>) -> Void) {
        httpClient.post(to: url, with: signInModel.toData()) { [weak self] (result) in
            guard self != nil else { return }
            switch result {
            case .failure(let error):
                switch error {
                case .fourHundred:
                    completion(.failure(.emailInUse))
                default:
                    completion(.failure(.unexpected))
                }
            case .success(let data):
                guard let accountModel: AccountModel = data?.toModel() else {
                    completion(.failure(.parseFailed))
                    return
                }
                completion(.success(accountModel))
            }
        }
    }
    
}
