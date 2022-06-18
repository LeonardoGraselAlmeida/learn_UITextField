//
//  ViewController.swift
//  LearnUITextField
//
//  Created by Leonardo Almeida on 16/06/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
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
    
    lazy var nameTextField: TextInput = {
        let textField = TextInput()
        textField.delegate = self
        textField.textContentType = .name
        textField.attributedPlaceholder = .init(string: "Digite seu nome", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        return textField
    }()
    
    lazy var passwordTextField: TextInput = {
        let textField = TextInput()
        textField.delegate = self
        textField.isSecureTextEntry = true
        textField.textContentType = .password
        textField.attributedPlaceholder = .init(string: "Digite sua senha", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        textField.autocapitalizationType = .none
        
        return textField
    }()
    
    lazy var addressTextField: TextInput = {
        let textField = TextInput()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        configConstraints()
        configTarget()
    }
}

extension ViewController {
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
            view.endEditing(true)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= keyboardSize.height - 200
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    
    @objc func handleRegister()   {
        guard let name = nameTextField.text else {
            return
        }
        guard let password = passwordTextField.text else {
            return
        }
        guard let address = addressTextField.text else {
            return
        }
        
        let user: User = User(name: name, password: password, address: address)
        print(user)
        
    }
    
}

extension ViewController {
    // MARK: - Configs
    private func configViews() {
        view.backgroundColor = .black
        
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(addressTextField)
        stackView.addArrangedSubview(buttonRegister)
        stackView.addArrangedSubview(UIView())
        
        view.addSubview(stackView)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
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
    
    private func configTarget() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        buttonRegister.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
    }
}

