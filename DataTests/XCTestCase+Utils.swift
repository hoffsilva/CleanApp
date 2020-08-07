//
//  XCTestCase+Utils.swift
//  DataTests
//
//  Created by Hoff Henry Pereira da Silva on 06/08/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
    
    func checkMemomryLeak(for instance: AnyObject, file: StaticString = #file, line: UInt = #line)  {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line: line)
        }
    }
    
}
