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
    
    var signUp: ((SignUpViewModel) -> Void)?
    
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
        setupBindings()
    }
    
    func configureAsRootView(_ view: UIView) {
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
    }
    
    private func setupBindings() {
        signUpView.createAccountButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
    }
    
    @objc func createButtonTapped() {
        let viewModel = SignUpViewModel(
            name: signUpView.nameTextField.text,
            email: signUpView.emailTextField.text,
            password: signUpView.passwordTextField.text,
            passwordConfirmation: signUpView.passwordConfirmationTextField.text)
        signUp?(viewModel)
    }
    
}

extension SignUpViewController: LoadingView {
    
    func show() {
        self.signUpView.activityIndicator.isHidden = false
        self.signUpView.isUserInteractionEnabled = false
        self.signUpView.activityIndicator.startAnimating()
    }
    
    func hide() {
        self.signUpView.activityIndicator.isHidden = true
        self.signUpView.isUserInteractionEnabled = true
        self.signUpView.activityIndicator.stopAnimating()
    }
    
}

extension SignUpViewController: AlertView {

    func showMessage(viewModel: AlertViewModel) {
        let alerController = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alerController.addAction(okAction)
        present(alerController, animated: true)
    }

}
