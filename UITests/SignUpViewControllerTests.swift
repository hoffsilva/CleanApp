//
//  SignUpViewControllerTests.swift
//  SignUpViewControllerTests
//
//  Created by Hoff Henry Pereira da Silva on 12/09/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import XCTest
import Presentation
@testable import UI

class SignUpViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start() {
        let sut = createSUT()
        
    }

}

extension SignUpViewControllerTests {
    
    func createSUT() -> SignUpViewController {
        SignUpViewController()
    }
    
}
