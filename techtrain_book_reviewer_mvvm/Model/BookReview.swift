//
//  BookReview.swift
//  techtrain_book_reviewer_mvvm
//
//  Created by 林 明虎 on 2025/01/11.
//

import Foundation

struct BookReview: Codable {
    let id: String
    let title: String
    let url: String
    let detail: String
    let review: String
    let reviewer: String
    let isMine: Bool?
    
    /// 単一のBookReviewに対するデコード
    static func decodeSingleBookReview(_ data: Data) throws(TBRError) -> BookReview {
        do {
            let decoder = JSONDecoder()
            let decodedBookReview = try decoder.decode(BookReview.self, from: data)
            return decodedBookReview
        } catch {
            throw TBRError.decodingError(at: "decodeSingleBookReview")
        }
    }
    /// 配列のBookReviewに対するデコード
    static func decodeBookReviewList(_ data: Data) throws(TBRError) -> [BookReview] {
        do {
            let decoder = JSONDecoder()
            let decodedBookReviewList = try decoder.decode([BookReview].self, from: data)
            return decodedBookReviewList
        } catch {
            throw TBRError.decodingError(at: "decodeBookReviewList")
        }
    }
}
