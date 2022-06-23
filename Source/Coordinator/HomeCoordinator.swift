//
//  HomeCoordinator.swift
//  LearnUITextField
//
//  Created by Leonardo Almeida on 23/06/22.
//

import UIKit

class HomeCoordinator: Coordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = HomeViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}
