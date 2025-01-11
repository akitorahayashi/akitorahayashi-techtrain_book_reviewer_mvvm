//
//  SelectAuthVC.swift
//  techtrain_book_reviewer_mvvm
//
//  Created by 林 明虎 on 2025/01/11.
//

import UIKit

class SelectAuthVC: UIViewController {
    private weak var coordinator: SelectAuthCoordinatorProtocol?
    // component
    private let appNameLabel = UILabel()
    private let showSignUpPageButton = TBRCardButton()
    private let showLogInPageButton = TBRCardButton()
    
    init(coordinator: SelectAuthCoordinatorProtocol?) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    override func loadView() {
        super.loadView()
        self.setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupButtonAction()
    }
    
    // MARK: - setup UI
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        appNameLabel.text = "Book Reviewer"
        appNameLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        appNameLabel.textColor = .accent
        appNameLabel.textAlignment = .center
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(appNameLabel)
        
        showSignUpPageButton.setTitle("Sign up", for: .normal)
        showLogInPageButton.setTitle("Log in", for: .normal)
        
        let buttonStack = UIStackView(arrangedSubviews: [showSignUpPageButton, showLogInPageButton])
        buttonStack.axis = .vertical
        buttonStack.spacing = 16
        buttonStack.distribution = .fillEqually
        buttonStack.alignment = .fill
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonStack)
        
        NSLayoutConstraint.activate([
            // appNameLabel
            appNameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            appNameLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -50),
            
            // buttonStack
            buttonStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            buttonStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            buttonStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
        
    }
    
    private func setupButtonAction() {
        self.showSignUpPageButton.addTarget(self, action: #selector(signupButtonAction), for: .touchUpInside)
        self.showLogInPageButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
    }
    
    @objc private func signupButtonAction() {
        self.coordinator?.jumpToSignUpView()
    }
    
    @objc private func loginButtonAction() {
        self.coordinator?.jumpToLogInView()
    }
    
}
