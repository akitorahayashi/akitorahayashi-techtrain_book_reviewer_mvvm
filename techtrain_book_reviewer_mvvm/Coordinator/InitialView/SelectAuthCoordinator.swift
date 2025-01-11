//
//  SelectAuthCoordinator.swift
//  techtrain_book_reviewer_mvvm
//
//  Created by 林 明虎 on 2025/01/11.
//

import UIKit

@MainActor
protocol SelectAuthCoordinatorProtocol: AnyObject {
    func navigateToSignUpView()
    func navigateToLogInView()
}

@MainActor
class SelectAuthCoordinator: SelectAuthCoordinatorProtocol {
    let navigationController: UINavigationController
    // child coordinator
    private var authInputCoordinator: AuthInputCoordinator?
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigateToSignUpView() {
        let authInputCoordinator = AuthInputCoordinator(navigationController: self.navigationController)
        self.authInputCoordinator = authInputCoordinator
        let authInputVC = AuthInputVC(authMode: .signup, authInputCoordinator: authInputCoordinator)
        navigationController.pushViewController(authInputVC, animated: true)
    }
    
    func navigateToLogInView() {
        let authInputCoordinator = AuthInputCoordinator(navigationController: self.navigationController)
        self.authInputCoordinator = authInputCoordinator
        let authInputVC = AuthInputVC(authMode: .login, authInputCoordinator: authInputCoordinator)
        navigationController.pushViewController(authInputVC, animated: true)
    }
    
}
