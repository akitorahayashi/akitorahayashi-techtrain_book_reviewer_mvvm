//
//  EditBookReviewView.swift
//  techtrain_book_reviewer_mvvm
//
//  Created by 林 明虎 on 2025/01/12.
//

import UIKit

class EditBookReviewVC: UIViewController, UITextViewDelegate {
    private let bookReviewID: String?
    
    // component
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    // input form
    private let titleHeader = UILabel()
    private let titleTestField = TBRInputField()
    private let urlHeader = UILabel()
    private let urlTextField = TBRInputField()
    private let detailHeader = UILabel()
    private let detailInputField = UITextView()
    private let reviewHeader = UILabel()
    private let reviewInputField = UITextView()
    // button
    private let compliteButton = TBRCardButton()
    private let clearButton = TBRCardButton()
    
    // UITextViewの高さの制約を保持
    private var detailInputFieldHeightConstraint: NSLayoutConstraint?
    private var reviewInputFieldHeightConstraint: NSLayoutConstraint?
    
    // レイアウト関連の定数
    private struct LayoutConstants {
        static let containerPadding: CGFloat = 20
        static let inputStackSpacing: CGFloat = 20
        static let inputFieldHeight: CGFloat = 60
        static let spacerViewHeight: CGFloat = 300
        static let buttonHeight: CGFloat = 44
    }
    
    // テキストビュー関連の定数
    private struct TextViewConstants {
        static let textViewHeightInRows: CGFloat = 3
        static let oneLineHeight: CGFloat = 20
    }
    
    init(bookReviewID: String?) {
        self.bookReviewID = bookReviewID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle メソッド
    override func loadView() {
        super.loadView()
        self.setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewInputField.delegate = self
        detailInputField.delegate = self
    }
    
    // MARK: - UIのセットアップ
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        // スクロールビューとコンテナの設定
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(containerView)
        
        // 各入力要素のヘッダーの設定
        setupHeader(titleHeader, text: "- Title -")
        setupHeader(urlHeader, text: "- URL -")
        setupHeader(detailHeader, text: "- Detail -")
        setupHeader(reviewHeader, text: "- Review -")
        
        // 入力フィールドのペアを作成
        let titleStack = createInputFieldPair(header: titleHeader, inputField: titleTestField)
        let urlStack = createInputFieldPair(header: urlHeader, inputField: urlTextField)
        let detailStack = createInputFieldPair(header: detailHeader, inputField: detailInputField)
        let reviewStack = createInputFieldPair(header: reviewHeader, inputField: reviewInputField)
        
        // UITextViewの設定
        configureTextView(detailInputField, heightConstraint: &detailInputFieldHeightConstraint)
        configureTextView(reviewInputField, heightConstraint: &reviewInputFieldHeightConstraint)
        
        // InputForm全体のStackの配置
        let inputFieldFormStack = UIStackView(arrangedSubviews: [titleStack, urlStack, detailStack, reviewStack])
        inputFieldFormStack.axis = .vertical
        inputFieldFormStack.spacing = LayoutConstants.inputStackSpacing
        inputFieldFormStack.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(inputFieldFormStack)
        
        // Spacerの配置
        let spacerView = UIView()
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(spacerView)
        
        // ボタンのテキストの設定
        compliteButton.setTitle(bookReviewID == nil ? "Post" : "Edit", for: .normal)
        clearButton.setTitle("Clear", for: .normal)
        
        // ボタンスタックビューの配置
        let buttonStackView = UIStackView(arrangedSubviews: [clearButton, compliteButton])
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 16
        buttonStackView.distribution = .fillEqually
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            // scrollViewとcontainerViewの制約
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // inputFieldFormStackの制約
            inputFieldFormStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: LayoutConstants.inputStackSpacing),
            inputFieldFormStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: LayoutConstants.containerPadding),
            inputFieldFormStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -LayoutConstants.containerPadding),
            
            // spacerViewの制約
            spacerView.topAnchor.constraint(equalTo: inputFieldFormStack.bottomAnchor),
            spacerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            spacerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            spacerView.heightAnchor.constraint(equalToConstant: LayoutConstants.spacerViewHeight),
            spacerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            // buttonStackViewの制約
            buttonStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: LayoutConstants.containerPadding),
            buttonStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -LayoutConstants.containerPadding),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            buttonStackView.heightAnchor.constraint(equalToConstant: LayoutConstants.buttonHeight)
        ])
    }
    
    // 各入力要素のヘッダーを生成する関数
    private func setupHeader(_ header: UILabel, text: String) {
        header.text = text
        header.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        header.textAlignment = .left
        header.textColor = .gray
    }
    
    // 入力フィールドのペアを作成する関数
    private func createInputFieldPair(header: UILabel, inputField: UIView) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [header, inputField])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        inputField.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
    
    // UITextViewの設定する関数
    private func configureTextView(_ textView: UITextView, heightConstraint: inout NSLayoutConstraint?) {
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.systemGray5.cgColor
        textView.layer.cornerRadius = 5.0
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        // 初期高さを3行分かそれ以上に設定
        let minHeight = TextViewConstants.textViewHeightInRows * TextViewConstants.oneLineHeight + textView.textContainerInset.top + textView.textContainerInset.bottom
        let heightConstraintInstance = textView.heightAnchor.constraint(equalToConstant: minHeight)
        heightConstraintInstance.isActive = true
        heightConstraint = heightConstraintInstance
        self.adjustHeight(for: textView, constraint: heightConstraint)
    }
    
    // MARK: -　UITextViewDelegate（textViewDidChange）
    func textViewDidChange(_ textView: UITextView) {
        if textView == detailInputField, let constraint = detailInputFieldHeightConstraint {
            self.adjustHeight(for: textView, constraint: constraint)
        } else if textView == reviewInputField, let constraint = reviewInputFieldHeightConstraint {
            self.adjustHeight(for: textView, constraint: constraint)
        }
    }
    
    private func adjustHeight(for textView: UITextView, constraint: NSLayoutConstraint?) {
        guard let constraint = constraint else { return }
        let size = textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude))
        let minHeight = TextViewConstants.textViewHeightInRows * TextViewConstants.oneLineHeight + textView.textContainerInset.top + textView.textContainerInset.bottom
        
        constraint.constant = max(size.height, minHeight)
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
}
