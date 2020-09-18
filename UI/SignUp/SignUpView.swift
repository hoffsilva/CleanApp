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
    
    lazy var contentTableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.separatorInset = .zero
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    lazy var contentCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.prepareForConstraints()
        return cell
    }()
    
    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.prepareForConstraints()
        stackView.spacing = 15
        return stackView
    }()
    
    lazy var headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.prepareForConstraints()
        return stackView
    }()
    
    lazy var logoLabel: UILabel = {
        let label = UILabel()
        label.text = "📱"
        label.font = UIFont(name: "Arial", size: 50)
        label.prepareForConstraints()
        label.textAlignment = .center
        return label
    }()
    
    lazy var logoTextLabel: UILabel = {
        let label = UILabel()
        label.text = "TestApp"
        label.font = UIFont(name: "Arial", size: 20)
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.prepareForConstraints()
        label.textAlignment = .center
        return label
    }()
    
    lazy var bodyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.prepareForConstraints()
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.prepareForConstraints()
        textField.keyboardType = .default
        return textField
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.prepareForConstraints()
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.prepareForConstraints()
        textField.keyboardType = .default
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var passwordConfirmationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password Confirmation"
        textField.prepareForConstraints()
        textField.keyboardType = .default
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var footerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.prepareForConstraints()
        return stackView
    }()
    
    lazy var createAccountButton: UIButton = {
        let button = UIButton()
        button.prepareForConstraints()
        button.setTitle("Create Account", for: .normal)
        button.titleLabel?.textAlignment = .left
        return button
    }()
    
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
        self.addSubview(contentTableView)
        self.contentCell.addSubview(contentStackView)
        self.contentStackView.addArrangedSubview(headerStackView)
        self.contentStackView.addArrangedSubview(bodyStackView)
        self.contentStackView.addArrangedSubview(footerStackView)
    }
    
    func configureConstraints() {
        
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
}

extension SignUpView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        contentCell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
}
