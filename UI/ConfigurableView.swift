//
//  ConfigurableView.swift
//  UI
//
//  Created by Hoff Henry Pereira da Silva on 12/09/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

protocol ConfigurableView {
    func configureObjects()
    func configureObjectsHierarchy()
    func configureConstraints()
}

extension ConfigurableView {
    func configureObjects() {
        configureObjectsHierarchy()
        configureConstraints()
    }
}
