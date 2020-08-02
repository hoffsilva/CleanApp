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
        httpClient.post(url: url)
    }
}

protocol HttpClient {
    func post(url: URL)
}

class AddAccountUseCaseImplementationTests: XCTestCase {

    func test_add_should_call_httpClient_with_correct_url() {
        
        let url = URL(string: "https://docs.github.com/en/github/importing-your-projects-to-github/adding-an-existing-project-to-github-using-the-command-line")
        let httpClient = HttpClientSpy()
        let sut = AddAccountUseCaseImplementationMock(url: url!, httpClient: httpClient)
        sut.add()
        XCTAssertEqual(httpClient.url, url)
        
    }
    
    func test_add_should_call_httpClient_with_correct_data() {
        
        let url = URL(string: "https://docs.github.com/en/github/importing-your-projects-to-github/adding-an-existing-project-to-github-using-the-command-line")
//        let data =
        let httpClient = HttpClientSpy()
        let sut = AddAccountUseCaseImplementationMock(url: url!, httpClient: httpClient)
        sut.add()
        XCTAssertEqual(httpClient.data, data)
        
    }
    
    class HttpClientSpy: HttpClient {
        var url: URL?
        func post(url: URL) {
            self.url = url
        }
        
    }

}


