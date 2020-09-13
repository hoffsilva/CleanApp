//
//  SignUpView.swift
//  UI
//
//  Created by Hoff Henry Pereira da Silva on 12/09/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import UIKit

class SignUpView: UIView {
    
    var activityIndicator: UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.prepareForConstraints()
        return activityIndicator
    }
    
    init() {
        super.init(frame: CGRect.zero)
        self.configureObjects()
        self.prepareForConstraints()
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
        
    }
    
}
