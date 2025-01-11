//
//  SelectAuthCoordinator.swift
//  techtrain_book_reviewer_mvvm
//
//  Created by 林 明虎 on 2025/01/11.
//

import UIKit

protocol SelectAuthCoordinatorProtocol: AnyObject {
    func jumpToSignUpView()
    func jumpToLogInView()
}

class SelectAuthCoordinator: SelectAuthCoordinatorProtocol {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func jumpToSignUpView() {
        
    }
    
    func jumpToLogInView() {
        
    }
    
}
