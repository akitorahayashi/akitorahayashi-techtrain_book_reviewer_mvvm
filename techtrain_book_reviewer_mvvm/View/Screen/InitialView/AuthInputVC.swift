//
//  AuthInputVC.swift
//  techtrain_book_reviewer_mvvm
//
//  Created by 林 明虎 on 2025/01/11.
//

import UIKit

enum TBREmailAuthMode {
    case login
    case signup
}

class AuthInputVC: UIViewController {
    private let authMode: TBREmailAuthMode
    private weak var authInputCoordinator: AuthInputCoordinatorProtocol?
    // component
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    // textField
    private let emailTextField = TBRInputField(placeholder: "メールアドレス")
    private let passwordTextField = TBRInputField(placeholder: "パスワード", isSecure: true)
    private let nameTextFeld = TBRInputField(placeholder: "名前")
    // button
    private let actionButton = TBRCardButton()
    private let clearButton = TBRCardButton()
    
    init(
        authMode: TBREmailAuthMode,
        authInputCoordinator: AuthInputCoordinatorProtocol?
    ) {
        self.authMode = authMode
        self.authInputCoordinator = authInputCoordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle メソッド
    override func loadView() {
        super.loadView()
        setupUI()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - UIのセットアップ
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        // 操作ボタンのセットアップ
        actionButton.setTitle(self.authMode == .login ? "ログイン" : "登録", for: .normal)
        clearButton.setTitle("クリア", for: .normal)
        let buttonStackView = UIStackView(arrangedSubviews: [clearButton, actionButton])
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 16
        buttonStackView.distribution = .fillEqually
        buttonStackView.alignment = .fill
        
        // TextFieldのセットアップ
        let inputFields: [UIView] = (self.authMode == .login)
        ? [emailTextField, passwordTextField]
        : [nameTextFeld, emailTextField, passwordTextField]
        
        // フォーム全体のセットアップ
        let formStackView = UIStackView(arrangedSubviews: inputFields + [buttonStackView])
        formStackView.axis = .vertical
        formStackView.spacing = 20
        formStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(formStackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            formStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            formStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            formStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            formStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
}
