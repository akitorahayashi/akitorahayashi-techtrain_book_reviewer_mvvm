//
//  TBRAuthInputValidator.swift
//  techtrain_book_reviewer_mvvm
//
//  Created by 林 明虎 on 2025/01/11.
//

import UIKit

enum TBRAuthError: Error {
    case invalidName
    case invalidEmail
    case invalidPassword
    
    var errorMessage: (title: String, message: String) {
        switch self {
        case .invalidName:
            return (title: "入力エラー", message: "名前は10文字以下で空白以外の文字を含めてください")
        case .invalidEmail:
            return (title: "入力エラー", message: "正しい形式のメールアドレスを入力してください")
        case .invalidPassword:
            return (title: "入力エラー", message: "パスワードは6文字以上20文字以下で設定してください")
        }
    }
}
