//
//  AddAccountUseCaseImplementationTests.swift
//  AddAccountUseCaseImplementationTests
//
//  Created by Hoff Henry Pereira da Silva on 01/08/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import XCTest
import Domain
import Data


class AddAccountUseCaseImplementationTests: XCTestCase {

    func test_add_should_call_httpClient_with_correct_url() {
        
        let url = URL(string: "https://docs.github.com/en/github")
        let accountModel = createAddAccount()
        let httpClient = HttpClientSpy()
        let sut = AddAccountUseCaseImplementation(url: url!, httpClient: httpClient)
        sut.add(addAccountModel: accountModel) { _ in }
        XCTAssertEqual(httpClient.urls, [url])
        
    }
    
    func test_add_should_call_httpClient_with_correct_data() {
        
        let accountModel = createAddAccount()
        let httpClient = HttpClientSpy()
        let sut = createSUT(with: httpClient)
        sut.add(addAccountModel: accountModel) { _ in }
        let data = accountModel.toData()
        XCTAssertEqual(httpClient.data, data)
        
    }

    func test_add_should_complete_with_error_when_client_fails() {
        
        let accountModel = createAddAccount()
        let httpClient = HttpClientSpy()
        let sut = createSUT(with: httpClient)
        let expec = expectation(description: "wait")
        sut.add(addAccountModel: accountModel) { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, DomainError.unexpected)
            case .success: XCTFail("Expected error and got a success!")
            }
            expec.fulfill()
        }
        httpClient.completionWithError(.noConnectivity)
        wait(for: [expec], timeout: 1)
        
    }
}

extension AddAccountUseCaseImplementationTests {
    
    func createAddAccount() -> AddAccountModel {
        AddAccountModel(name: "name", email: "email", password: "password", passwordConfirmation: "password")
    }
    
    func createSUT(with httpClient: HttpClientSpy) -> AddAccountUseCaseImplementation {
        let sut = AddAccountUseCaseImplementation(url: createUrl(), httpClient: httpClient)
        return sut
    }
    
    func createUrl() -> URL {
        URL(string: "https://docs.github.com/en/github/importing-your-projects-to-github/adding-an-existing-project-to-github-using-the-command-line")!
    }
    
}


