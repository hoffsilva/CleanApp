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
    var url: URL?
    var data: Data?
    func post(to url: URL, with data: Data?) {
        self.url = url
        self.data = data
    }
    
}
