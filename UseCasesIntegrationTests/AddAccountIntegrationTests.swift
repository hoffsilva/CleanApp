//
//  AddAccountIntegrationTests.swift
//  AddAccountIntegrationTests
//
//  Created by Hoff Henry Pereira da Silva on 14/08/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import XCTest
import Data
import Infra
import Domain

class AddAccountIntegrationTests: XCTestCase {

    func testAddAccount() {
        let expec = expectation(description: "wait")
        let alamofireAdapter = AlamofireAdapter()
        let url = URL(string: "https://clean-node-api.herokuapp.com/api/signup")
        let sut = AddAccountUseCaseImplementation(
            url: url!,
            httpClient: alamofireAdapter
        )
        let addAccountModel = AddAccountModel(
            name: "Hoff",
            email: "hoff@hoff.com",
            password: "123456",
            passwordConfirmation: "123456")
        sut.add(addAccountModel: addAccountModel) { (result) in
            switch result {
            case .failure: XCTFail("Expected result success, received failure instead.")
            case .success(let account):
                XCTAssertNotNil(account.id)
                XCTAssert(account.name == addAccountModel.name)
                XCTAssert(account.email == addAccountModel.email)
            }
            expec.fulfill()
        }
        wait(for: [expec], timeout: 5)
    }

}
