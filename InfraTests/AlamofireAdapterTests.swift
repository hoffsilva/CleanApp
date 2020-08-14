//
//  AlamofireAdapterTests.swift
//  AlamofireAdapterTests
//
//  Created by Hoff Henry Pereira da Silva on 06/08/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import XCTest
import Alamofire
import Data
import Infra

class AlamofireAdapterTests: XCTestCase {
    
    func test_post_should_make_request_with_valid_url_and_methd() {
        let url = TestTools.createUrl()
        performTestFor(url: url, data: TestTools.createAddUserAccountData()) { (request) in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("POST", request.httpMethod)
            XCTAssertNotNil(request.httpBodyStream)
        }
    }
    
    func test_post_should_make_request_with_no_data() {
        performTestFor(data: TestTools.createAddUserAccountData()) { (request) in
            XCTAssertNotNil(request.httpBodyStream)
        }
    }
    
    func test_post_should_complete_with_when_request_completes_with_error() {
        URLProtocolStub.configureResponseProperties(data: nil, response: nil, error: TestTools.createError())
        performTestFor(expectedResult: .failure(.noConnectivity), data: Data())
    }
    
    func test_post_should_complete_with_success_when_request_answer_with_data_response_and_no_error() {
        let data = TestTools.createAddUserAccountData()
        URLProtocolStub
            .configureResponseProperties(
                data: data,
                response: TestTools.createHTTPResponse(),
                error: nil
        )
        performTestFor(expectedResult: .success(data), data: data)
    }
    
    func test_post_should_complete_with_error_when_request_answer_with_data_response_and_error() {
        URLProtocolStub
            .configureResponseProperties(
                data: Data(),
                response: TestTools.createHTTPResponse(),
                error: TestTools.createError()
        )
        performTestFor(expectedResult: .failure(.noConnectivity), data: Data())
    }
    
    func test_post_should_complete_with_error_when_request_answer_with_data_no_response_and_no_error() {
        URLProtocolStub
            .configureResponseProperties(
                data: Data(),
                response: nil,
                error: nil
        )
        performTestFor(expectedResult: .failure(.noConnectivity), data: nil)
    }
    
    func test_post_should_complete_with_error_when_request_answer_with_data_no_response_and_error() {
        URLProtocolStub
            .configureResponseProperties(
                data: Data(),
                response: nil,
                error: TestTools.createError()
        )
        performTestFor(expectedResult: .failure(.noConnectivity), data: Data())
    }
    
    func test_post_should_complete_with_error_when_request_answer_with_no_data_response_and_error() {
        URLProtocolStub
            .configureResponseProperties(
                data: nil,
                response: TestTools.createHTTPResponse(),
                error: TestTools.createError()
        )
        performTestFor(expectedResult: .failure(.noConnectivity), data: nil)
    }
    
    func test_post_should_complete_with_error_when_request_answer_with_no_data_response_and_no_error() {
        URLProtocolStub
            .configureResponseProperties(
                data: nil,
                response: TestTools.createHTTPResponse(),
                error: nil
        )
        performTestFor(expectedResult: .failure(.noConnectivity), data: nil)
    }
    
    func test_post_should_complete_with_httpStatusCode_2XX_OK() {
        let data = TestTools.createAddUserAccountData()
        URLProtocolStub.configureResponseProperties(
            data: data,
            response: TestTools.createHTTPResponse(),
            error: nil
        )
        performTestFor(expectedResult: .success(data), data: data)
    }
    
    func test_post_should_complete_with_httpStatusCode_4XX_OK() {
        let data = TestTools.createAddUserAccountData()
        URLProtocolStub.configureResponseProperties(
            data: data,
            response: TestTools.createHTTPResponse(400),
            error: nil
        )
        performTestFor(expectedResult: .failure(.fourHundred), data: data)
    }
    
    func test_post_should_complete_with_httpStatusCode_5XX_OK() {
        let data = TestTools.createAddUserAccountData()
        URLProtocolStub.configureResponseProperties(
            data: data,
            response: TestTools.createHTTPResponse(500),
            error: nil
        )
        performTestFor(expectedResult: .failure(.fiveHundred), data: data)
    }
    
    
}

extension AlamofireAdapterTests {
    
    func createSUT(file: StaticString = #file, line: UInt = #line) -> AlamofireAdapter {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.protocolClasses = [URLProtocolStub.self]
        let session = Session(configuration: sessionConfiguration)
        let sut = AlamofireAdapter(session: session)
        return sut
    }
    
    func performTestFor(url: URL = TestTools.createUrl(), data: Data?, action: @escaping (URLRequest) -> Void) {
        let sut = createSUT()
        let expec = expectation(description: "wait")
        sut.post(to: url, with: data) { _ in expec.fulfill() }
        var request: URLRequest?
        URLProtocolStub.requestObserver { request = $0 }
        wait(for: [expec], timeout: 0.1)
        guard let req = request else { return }
        action(req)
    }
    
    func performTestFor(expectedResult: Result<Data?,HttpClientError>, data: Data?, file: StaticString = #file, line: UInt = #line) {
        let sut = createSUT()
        let expec = expectation(description: "waiting")
        sut.post(to: TestTools.createUrl(), with: data) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedData), .success(let receivedData)):
                XCTAssertEqual(expectedData, receivedData, file: file, line: line)
            default:
                XCTFail("Expected result doesn't equal to received result.", file: file, line: line)
            }
            expec.fulfill()
        }
        wait(for: [expec], timeout: 0.1)
        
    }
    
}
