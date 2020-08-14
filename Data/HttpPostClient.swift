//
//  HttpPostClient.swift
//  Data
//
//  Created by Hoff Henry Pereira da Silva on 02/08/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

public protocol HttpPostClient {
    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data?, HttpClientError>)->Void)
}
