//
//  AppCoordinator.swift
//  techtrain_book_reviewer_mvvm
//
//  Created by 林 明虎 on 2025/01/11.
//

import UIKit

@MainActor
protocol AppCoordinatorProtocol: AnyObject {
    func start()
}

@MainActor
class AppCoordinator: AppCoordinatorProtocol {
    var window: UIWindow?
    let navigationController = UINavigationController()
    // child coordinator
    private var seletAuthCoordinator: SelectAuthCoordinator?
    
    init(windowScene: UIWindowScene) {
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = self.navigationController
        self.window?.backgroundColor = .systemBackground
        self.window?.makeKeyAndVisible()
    }
    
    func start() {
        let selectAuthCoordinator = SelectAuthCoordinator(navigationController: self.navigationController)
        self.seletAuthCoordinator = selectAuthCoordinator
        let selectAuthVC = SelectAuthVC(selectAuthCoordinator: selectAuthCoordinator)
        self.navigationController.setViewControllers([selectAuthVC], animated: false)
    }
}
