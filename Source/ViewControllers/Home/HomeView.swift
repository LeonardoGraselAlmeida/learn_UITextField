//
//  HomeView.swift
//  LearnUITextField
//
//  Created by Leonardo Almeida on 23/06/22.
//

import UIKit

class HomeView: UIView, UITextFieldDelegate {
    //MARK: Components
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalCentering
        stack.axis = .vertical
        
        return stack
    }()
    
    lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "logo")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var nameTextField: TextInputDefault = {
        let textField = TextInputDefault()
        textField.delegate = self
        textField.textContentType = .name
        textField.attributedPlaceholder = .init(string: "Digite seu nome", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        return textField
    }()
    
    lazy var passwordTextField: TextInputDefault = {
        let textField = TextInputDefault()
        textField.delegate = self
        textField.isSecureTextEntry = true
        textField.textContentType = .oneTimeCode
        textField.attributedPlaceholder = .init(string: "Digite sua senha", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        textField.autocapitalizationType = .none
        
        return textField
    }()
    
    lazy var addressTextField: TextInputDefault = {
        let textField = TextInputDefault()
        textField.delegate = self
        textField.returnKeyType = .done
        textField.textContentType = .addressCity
        textField.attributedPlaceholder = .init(string: "Digite seu endereço", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        return textField
    }()
    
    lazy var buttonRegister: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .purple
        button.tintColor = .white
        button.setTitle("Cadastrar", for: .normal)
        button.isEnabled = false
        button.alpha = 0.5
        
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setElementsVisual()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setElementsVisual() {
        setView()
        setStackView()
    }
    
    private func setView() {
        self.backgroundColor = .black
    }
    
    private func setStackView() {
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(addressTextField)
        stackView.addArrangedSubview(buttonRegister)
        stackView.addArrangedSubview(UIView())
        
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
            logoImageView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            
            nameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            
            passwordTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            addressTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            addressTextField.heightAnchor.constraint(equalToConstant: 40),
            
            buttonRegister.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 20),
            buttonRegister.heightAnchor.constraint(equalToConstant: 50),
            buttonRegister.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
}

extension HomeView {
    // MARK: - Function
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch(textField) {
        case nameTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            addressTextField.becomeFirstResponder()
        case addressTextField:
            addressTextField.resignFirstResponder()
        default:
            endEditing(true)
        }
        
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderColor = UIColor.blue.cgColor
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(textField.text?.isEmpty == true ) {
            textField.layer.borderColor = UIColor.red.cgColor
        } else {
            textField.layer.borderColor = UIColor.lightGray.cgColor
        }
        
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if(nameTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false && addressTextField.text?.isEmpty == false) {
            buttonRegister.isEnabled = true
            buttonRegister.alpha = 1
        } else {
            buttonRegister.isEnabled = false
            buttonRegister.alpha = 0.5
        }
    }
    
    internal func clearTextFields() {
        self.endEditing(true)
        self.nameTextField.text = nil
        self.passwordTextField.text = nil
        self.addressTextField.text = nil
    }
}


