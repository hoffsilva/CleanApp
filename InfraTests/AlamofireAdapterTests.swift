//
//  AlamofireAdapterTests.swift
//  AlamofireAdapterTests
//
//  Created by Hoff Henry Pereira da Silva on 06/08/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import XCTest
import Alamofire

class AlamofireAdapter {
    
    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func post(to url: URL) {
        session.request(url).resume()
    }
}

class AlamofireAdapterTests: XCTestCase {

    func test_() {
        let expect = expectation(description: "waiting")
        let url = TestTools.createUrl()
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.protocolClasses = [URLProtocolStub.self]
        let session = Session(configuration: sessionConfiguration)
        let sut = AlamofireAdapter(session: session)
        sut.post(to: url)
        URLProtocolStub.requestObserver { request in
            XCTAssertEqual(url, request.url)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 0.1 )
    }

}

class URLProtocolStub: URLProtocol {
    
    static var completion: ((URLRequest) -> Void)?
    
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
