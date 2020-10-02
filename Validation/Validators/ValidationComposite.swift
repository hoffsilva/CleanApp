//
//  ValidationComposite.swift
//  Validation
//
//  Created by Hoff Henry Pereira da Silva on 02/10/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Presentation

public class ValidationComposite: Validation {
    
    private let validators: [Validation]
    
    public init(validators: [Validation]) {
        self.validators = validators
    }
    
    public func validate(data: [String : Any]?) -> String? {
        
    }
    
}

