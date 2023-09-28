//
//  Book.swift
//  Kashihon
//
//  Created by t&a on 2023/07/14.
//

import RealmSwift
import UIKit

class Book: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String // 書籍ID
    @Persisted var title: String // タイトル
    @Persisted var authors = RealmSwift.List<String>() // 著書の配列
    @Persisted var desc: String // 説明
    @Persisted var ISBN_13: String // ISBN
    @Persisted var pageCount: Int // ページ数
    @Persisted var publishedDate: String // 発行日
    @Persisted var thumbnailUrl: String // サムネイルURL(http)

    // MARK: - ↑　APIから取得する情報

    // MARK: - ↓　個人で蓄積できる情報

    @Persisted var loanName: String // 貸出している人
    @Persisted var loanDate: Date // 貸出した日付
    @Persisted var OnLoan: Bool = false // 貸出中フラグ
    @Persisted var loanMemo: String // 貸出した際のMemo
    @Persisted var bookMemo: String // 本自体のメモ
    @Persisted var order: Int // 並び順

    /// サムネイルURLをセキュアなURLに変換
    public var secureThumbnailUrl: URL? {
        if thumbnailUrl == "" {
            return nil
        }
        let replaceUrlStr = thumbnailUrl.replacingOccurrences(of: "http://", with: "https://")
        if let url = URL(string: replaceUrlStr) {
            return url
        }
        return nil
    }

    /// サムネイルURLをセキュアなURLに変換
    public var concatenationAuthors: String {
        var connect = ""
        for author in authors {
            if authors[0] == author {
                connect += author
            } else {
                connect += "/" + author
            }
        }
        return connect
    }
}
