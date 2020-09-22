//
//  SignUpView.swift
//  UI
//
//  Created by Hoff Henry Pereira da Silva on 12/09/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import UIKit

public class SignUpView: UIView {
    
    lazy var contentTableView: UITableView = {
        let tableView = UITableView()
        tableView.prepareForConstraints()
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
//        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    lazy var contentCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.backgroundColor = .clear
        cell.contentView.prepareForConstraints()
        return cell
    }()
    
    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.prepareForConstraints()
        stackView.spacing = 15
        stackView.distribution = .fill
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
        label.textColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        label.prepareForConstraints()
        label.textAlignment = .center
        return label
    }()
    
    lazy var bodyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.prepareForConstraints()
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()

    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.prepareForConstraints()
        textField.keyboardType = .default
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.prepareForConstraints()
        textField.keyboardType = .emailAddress
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.prepareForConstraints()
        textField.keyboardType = .default
        textField.isSecureTextEntry = true
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    lazy var passwordConfirmationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password Confirmation"
        textField.prepareForConstraints()
        textField.keyboardType = .default
        textField.isSecureTextEntry = true
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
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
        button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        return button
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.prepareForConstraints()
        activityIndicator.style = .large
        activityIndicator.color = .orange
        return activityIndicator
    }()
    
    
    public init() {
        super.init(frame: CGRect.zero)
        self.configureObjects()
        self.backgroundColor = .black
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(gesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }
    
}

extension SignUpView: ConfigurableView {
    
    func configureObjectsHierarchy() {
//        self.addSubview(contentTableView)
        self.addSubview(contentStackView)
        self.contentStackView.addArrangedSubview(headerStackView)
        self.headerStackView.addArrangedSubview(logoLabel)
        self.headerStackView.addArrangedSubview(logoTextLabel)
        self.contentStackView.addArrangedSubview(bodyStackView)
        self.bodyStackView.addArrangedSubview(nameTextField)
        self.bodyStackView.addArrangedSubview(emailTextField)
        self.bodyStackView.addArrangedSubview(passwordTextField)
        self.bodyStackView.addArrangedSubview(passwordConfirmationTextField)
        self.contentStackView.addArrangedSubview(footerStackView)
        self.footerStackView.addArrangedSubview(createAccountButton)
        self.contentCell.contentView.addSubview(activityIndicator)
    }
    
    func configureConstraints() {
        
        contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24).isActive = true
        contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24).isActive = true
        contentStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        headerStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        logoTextLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        bodyStackView.setContentHuggingPriority(UILayoutPriority.init(249), for: .vertical)
        bodyStackView.setContentHuggingPriority(UILayoutPriority.init(249), for: .horizontal)
        
        bodyStackView.setContentCompressionResistancePriority(UILayoutPriority.init(749), for: .vertical)
        bodyStackView.setContentCompressionResistancePriority(UILayoutPriority.init(749), for: .horizontal)
        
        nameTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        passwordConfirmationTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        footerStackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
}

extension SignUpView: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        contentCell
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
}

extension SignUpView: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}
