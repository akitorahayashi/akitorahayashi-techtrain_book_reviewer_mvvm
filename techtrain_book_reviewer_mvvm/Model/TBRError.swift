//
//  TBRError.swift
//  techtrain_book_reviewer_mvvm
//
//  Created by 林 明虎 on 2025/01/11.
//

enum TBRError: Error {
    // JSONシリアライズ
    case encodingError(at: String)
    case decodingError(at: String)
    
    var localizedDescription: String {
        switch self {
        case .encodingError(let at):
            print("encodingError at \(at)")
            return "データの変換に失敗しました"
        case .decodingError(let at):
            print("decodingError at \(at)")
            return "データの解読に失敗しました"
        }
    }
}
