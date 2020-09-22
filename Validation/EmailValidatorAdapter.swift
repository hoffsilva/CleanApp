//
//  EmailValidatorAdapter.swift
//  Validation
//
//  Created by Hoff Henry Pereira da Silva on 18/09/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Presentation

public final class EmailValidatorAdapter: EmailValidator {
    
    private let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    public init() {}
    
    public func validate(email: String) -> Bool {
        let range = NSRange(location: 0, length: email.utf16.count)
        let regex = try! NSRegularExpression(pattern: pattern)
        return regex.firstMatch(in: email, options: [], range: range) != nil
    }
}
