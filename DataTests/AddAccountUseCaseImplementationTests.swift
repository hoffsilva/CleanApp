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
        let accountModel = TestTools.createAddAccount()
        let httpClient = HttpClientSpy()
        let sut = AddAccountUseCaseImplementation(url: url!, httpClient: httpClient)
        sut.add(addAccountModel: accountModel) { _ in }
        XCTAssertEqual(httpClient.urls, [url])
        
    }
    
    func test_add_should_call_httpClient_with_correct_data() {
        
        let accountModel = TestTools.createAddAccount()
        let httpClient = HttpClientSpy()
        let sut = createSUT(with: httpClient)
        sut.add(addAccountModel: accountModel) { _ in }
        let data = accountModel.toData()
        XCTAssertEqual(httpClient.data, data)
        
    }
    
    func test_add_should_complete_with_error_when_client_fails() {
        
        let httpClient = HttpClientSpy()
        expect(createSUT(with: httpClient), completeWith: .failure(.unexpected), when: {
            httpClient.completionWithError(.noConnectivity)
        })
        
    }
    
    func test_add_should_complete_with_account_when_client_returns_valid_data() {
        
        let expectedAccount = TestTools.createAccountModel()
        let httpClient = HttpClientSpy()
        expect(createSUT(with: httpClient), completeWith: .success(expectedAccount), when: {
            httpClient.completionWithData(expectedAccount.toData())
        })
        
    }
    
    func test_add_should_complete_with_error_when_client_returns_invalid_data() {
        
        let httpClient = HttpClientSpy()
        expect(createSUT(with: httpClient), completeWith: .failure(.parseFailed), when: {
            httpClient.completionWithData(Data())
        })
        
    }
    
    func test_add_should_not_complete_when_sut_is_dealocated() {
        
        let httpClient = HttpClientSpy()
        var sut : AddAccountUseCaseImplementation? = createSUT(with: httpClient)
        var result: Result<AccountModel,DomainError>?
        sut?.add(addAccountModel: TestTools.createAddAccount(), completion: { result = $0 })
        sut = nil
        httpClient.completionWithError(.noConnectivity)
        XCTAssertNil(result)
        
    }
    
    
}

extension AddAccountUseCaseImplementationTests {
    
    func createSUT(with httpClient: HttpClientSpy, file: StaticString = #file, line: UInt = #line) -> AddAccountUseCaseImplementation {
        let sut = AddAccountUseCaseImplementation(url: TestTools.createUrl(), httpClient: httpClient)
        checkMemomryLeak(for: sut, file: file, line: line)
        return sut
    }
    
    func expect(_ sut: AddAccountUseCaseImplementation, completeWith expectedResult: Result<AccountModel, DomainError>, when action: @escaping ()-> Void, file: StaticString = #file, line: UInt = #line) {
        let expec = expectation(description: "wait")
        let addAccountModel = TestTools.createAddAccount()
        sut.add(addAccountModel: addAccountModel) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedSuccess), .success(let receivedSuccess)):
                XCTAssertEqual(expectedSuccess, receivedSuccess, file: file, line: line)
            default:
                XCTFail("Expected error and got a success!", file: file, line: line)
            }
            expec.fulfill()
        }
        action()
        wait(for: [expec], timeout: 1)
    }
    
}


