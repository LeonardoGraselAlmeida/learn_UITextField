//
//  HomeViewController.swift
//  LearnUITextField
//
//  Created by Leonardo Almeida on 16/06/22.
//

import UIKit
import FirebaseFirestore

class HomeViewController: ViewControllerDefault {
    var db: Firestore!
    
    lazy var homeView: HomeView = {
        let view = HomeView()
        return view
    }()
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configFirestore()
        configTarget()
    }
}

extension HomeViewController {
    // MARK: - Function
    @objc func handleRegister()   {
        guard let name = homeView.nameTextField.text else {
            return
        }
        guard let password = homeView.passwordTextField.text else {
            return
        }
        guard let address = homeView.addressTextField.text else {
            return
        }
        
        let user: User = User(name: name, password: password, address: address)
        setUser(with: user)
    }
    
    private func setUser(with user: User) {
        db.collection("users").addDocument(data: [
            "name": user.name,
            "password": user.password,
            "address": user.address
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                self.showSucessAlert()
            }
        }
    }
    
    private func showSucessAlert() {
        let alert = UIAlertController(title: "Cadastro", message: "Cadastro realizado com sucesso.", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
            self.homeView.clearTextFields()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}



extension HomeViewController {
    // MARK: - Configs
    private func configFirestore() {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }
    
    private func configTarget() {
        homeView.buttonRegister.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
    }
}

