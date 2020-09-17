//
//  SignUpView.swift
//  UI
//
//  Created by Hoff Henry Pereira da Silva on 12/09/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
#if !os(macOS)
import UIKit
#endif

class SignUpView: UIView {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.prepareForConstraints()
        activityIndicator.style = .large
        return activityIndicator
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        self.configureObjects()
        self.backgroundColor = .brown
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SignUpView: ConfigurableView {
    
    func configureObjectsHierarchy() {
        self.addSubview(activityIndicator)
    }
    
    func configureConstraints() {
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
}
