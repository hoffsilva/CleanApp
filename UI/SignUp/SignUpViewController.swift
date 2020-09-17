//
//  SignUpViewController.swift
//  UI
//
//  Created by Hoff Henry Pereira da Silva on 12/09/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import UIKit
import Presentation

class SignUpViewController: UIViewController {
    
    let signUpView: SignUpView
    
    init(signUpView: SignUpView) {
        self.signUpView = signUpView
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        configureAsRootView(signUpView)
    }
    
    func configureAsRootView(_ view: UIView) {
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
    }
    
}

extension SignUpViewController: LoadingView {
    func show() {
        self.signUpView.activityIndicator.isHidden = false
        self.signUpView.activityIndicator.startAnimating()
    }
    
    func hide() {
        self.signUpView.activityIndicator.isHidden = true
        self.signUpView.activityIndicator.stopAnimating()
    }
    
    
    
    
}
