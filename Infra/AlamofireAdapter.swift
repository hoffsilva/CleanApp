//
//  AlamofireAdapter.swift
//  Infra
//
//  Created by Hoff Henry Pereira da Silva on 14/08/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Alamofire
import Data

public final class AlamofireAdapter {
    
    private let session: Session
    
    public init(session: Session = .default) {
        self.session = session
    }
    
    public func post(to url: URL, with data: Data?, completion: @escaping (Result<Data?, HttpClientError>) -> Void ) {
            session
                .request(url, method: .post, parameters: data?.toJSON(), encoding: JSONEncoding.default)
                .responseData { responseData in
                    guard let response = responseData.response else {
                        return completion(.failure(.noConnectivity))
                    }
                    switch response.statusCode {
                    case 200...299:
                        switch responseData.result {
                        case .failure:
                            completion(.failure(.noConnectivity))
                        case .success:
                            completion(.success(responseData.data))
                        }
                    case 400...499:
                        completion(.failure(.fourHundred))
                    case 500...599:
                        completion(.failure(.fiveHundred))
                    default: break
                    }
            }
    }
}
