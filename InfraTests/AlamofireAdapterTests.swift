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

class AlamofireAdapter {
    
    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func post(to url: URL, with data: Data?) {
        if let json = data?.toJSON() {
            session.request(url, method: .post, parameters: json, encoding: JSONEncoding.default).resume()
        } else {
            session.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default).resume()
        }
    }
}

class AlamofireAdapterTests: XCTestCase {

    func test_post_should_make_request_with_valid_url_and_methd() {
        let expect = expectation(description: "waiting")
        let url = TestTools.createUrl()
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.protocolClasses = [URLProtocolStub.self]
        let session = Session(configuration: sessionConfiguration)
        let sut = AlamofireAdapter(session: session)
        let body = TestTools.createAddUserAccountData()
        sut.post(to: url, with: body)
        URLProtocolStub.requestObserver { request in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("POST", request.httpMethod)
            XCTAssertNotNil(request.httpBodyStream)
//            XCTAssertEqual(body, request.httpBody)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 0.1 )
    }
    
     func test_post_should_make_request_with_no_data() {
            let expect = expectation(description: "waiting")
            let url = TestTools.createUrl()
            let sessionConfiguration = URLSessionConfiguration.default
            sessionConfiguration.protocolClasses = [URLProtocolStub.self]
            let session = Session(configuration: sessionConfiguration)
            let sut = AlamofireAdapter(session: session)
            sut.post(to: url, with: nil)
            URLProtocolStub.requestObserver { request in
                XCTAssertNil(request.httpBodyStream)
                expect.fulfill()
            }
            wait(for: [expect], timeout: 1 )
        }

}

class URLProtocolStub: URLProtocol {
    
    static var completion: ((URLRequest) -> Void)?
    
    @Published var req: URLRequest?
    
    static func requestObserver(completionHandler: @escaping (URLRequest) -> Void) {
        URLProtocolStub.completion = completionHandler
    }
    
    override open class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        URLProtocolStub.completion?(request)
    }
    
    override func stopLoading() { }
    
    
}
