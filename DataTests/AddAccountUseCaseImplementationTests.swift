//
//  AddAccountUseCaseImplementationTests.swift
//  AddAccountUseCaseImplementationTests
//
//  Created by Hoff Henry Pereira da Silva on 01/08/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import XCTest
@testable import Domain

class AddAccountUseCaseImplementationMock {
    
    private let url: URL
    private let httpClient: HttpClient
    
    init(url: URL,
         httpClient: HttpClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    func add(addAccountModel: AddAccountModel) {
        let data = try? JSONEncoder().encode(addAccountModel)
        httpClient.post(to: url, with: data)
    }
}

protocol HttpClient {
    func post(to url: URL, with data: Data?)
}

class AddAccountUseCaseImplementationTests: XCTestCase {

    func test_add_should_call_httpClient_with_correct_url() {
        
        let url = URL(string: "https://docs.github.com/en/github/importing-your-projects-to-github/adding-an-existing-project-to-github-using-the-command-line")
        let accountModel = AddAccountModel(name: "name", email: "email", password: "password", passwordConfirmation: "password")
        let httpClient = HttpClientSpy()
        let sut = AddAccountUseCaseImplementationMock(url: url!, httpClient: httpClient)
        sut.add(addAccountModel: accountModel)
        XCTAssertEqual(httpClient.url, url)
        
    }
    
    func test_add_should_call_httpClient_with_correct_data() {
        
        let url = URL(string: "https://docs.github.com/en/github/importing-your-projects-to-github/adding-an-existing-project-to-github-using-the-command-line")
        let accountModel = AddAccountModel(name: "name", email: "email", password: "password", passwordConfirmation: "password")
        let httpClient = HttpClientSpy()
        let sut = AddAccountUseCaseImplementationMock(url: url!, httpClient: httpClient)
        sut.add(addAccountModel: accountModel)
        let data = try? JSONEncoder().encode(accountModel)
        XCTAssertEqual(httpClient.data, data)
        
    }
    
    class HttpClientSpy: HttpClient {
        var url: URL?
        var data: Data?
        func post(to url: URL, with data: Data?) {
            self.url = url
            self.data = data
        }
        
    }

}


