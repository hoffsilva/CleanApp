//
//  Validation.swift
//  Presentation
//
//  Created by Hoff Henry Pereira da Silva on 29/09/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

public protocol Validation {
    func validate(data: [String:Any]?) -> String?
}
