//
//  EmailValidator.swift
//  Presentation
//
//  Created by Hoff Henry Pereira da Silva on 26/08/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

public protocol EmailValidator {
    func validate(email: String) -> Bool
}
