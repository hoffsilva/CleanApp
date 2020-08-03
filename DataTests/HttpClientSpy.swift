//
//  HttpClientSpy.swift
//  DataTests
//
//  Created by Hoff Henry Pereira da Silva on 02/08/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Data

class HttpClientSpy: HttpPostClient {
    var urls = [URL]()
    var data: Data?
    var completion: ((Result<Data,HttpClientError>) -> Void)?
    
    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data,HttpClientError>)->Void) {
        self.urls.append(url)
        self.data = data
        self.completion = completion
    }
    
    func completionWithError(_ error: HttpClientError) {
        completion?(.failure(error))
    }
    
}
