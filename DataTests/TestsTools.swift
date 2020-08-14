//
//  TestsTools.swift
//  DataTests
//
//  Created by Hoff Henry Pereira da Silva on 06/08/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Domain

struct TestTools {
    
    static func createUrl() -> URL {
        URL(string: "https://docs.github.com")!
    }
    
    static func createAccountModel() -> AccountModel {
        AccountModel(identifier: "identifier", name: "name", email: "email", password: "password")
    }
    
    static func createInvalidData() -> Data {
        Data()
    }
    
    static func createAddUserAccountData() -> Data {
        Data("{\"name\":\"Hoff\"}".utf8)
    }
    
    static func createError() -> Error {
        NSError(domain: "", code: 0)
    }
    
    static func createHTTPResponse(_ statusCode: Int = 200) -> HTTPURLResponse? {
        HTTPURLResponse(url: createUrl(), statusCode: statusCode, httpVersion: nil, headerFields: nil)
    }
 }
