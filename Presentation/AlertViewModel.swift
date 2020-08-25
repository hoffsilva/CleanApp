//
//  AlertViewModel.swift
//  Presentation
//
//  Created by Hoff Henry Pereira da Silva on 25/08/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

public struct AlertViewModel: Equatable {
    public var title: String?
    public var message: String?
    public init(
        title: String?,
        message: String?
    ) {
        self.title = title
        self.message = message
    }
}
