//
//  AuthInputCoordinator.swift
//  techtrain_book_reviewer_mvvm
//
//  Created by 林 明虎 on 2025/01/11.
//

import UIKit

@MainActor
protocol AuthInputCoordinatorProtocol: AnyObject {
    func navigateToMainTabBarView()
}

@MainActor
class AuthInputCoordinator: AuthInputCoordinatorProtocol {
    let navigationController: UINavigationController
    // child coordinator
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigateToMainTabBarView() {
        
    }
}
