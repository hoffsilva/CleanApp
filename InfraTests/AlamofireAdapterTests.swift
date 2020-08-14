//
//  AlamofireAdapterTests.swift
//  AlamofireAdapterTests
//
//  Created by Hoff Henry Pereira da Silva on 06/08/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import XCTest
import Alamofire
import Combine
import Data

class AlamofireAdapter {
    
    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, HttpClientError>) -> Void ) {
        if let json = data?.toJSON() {
            session
                .request(url, method: .post, parameters: json, encoding: JSONEncoding.default)
                .responseData { responseData in
                    switch responseData.result {
                    case .failure:
                        completion(.failure(.noConnectivity))
                    case .success: break
                    }
            }
        } else {
            session.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default).resume()
        }
    }
}

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
        performTestFor(expectedResult: .failure(.noConnectivity))
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
    
    func performTestFor(expectedResult: Result<Data,HttpClientError>, file: StaticString = #file, line: UInt = #line) {
        let sut = createSUT()
        let expec = expectation(description: "wait")
        sut.post(to: TestTools.createUrl(), with: TestTools.createAddUserAccountData()) { receivedResult in
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
