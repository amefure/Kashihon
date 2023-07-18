//
//  LoanHistory.swift
//  Kashihon
//
//  Created by t&a on 2023/07/18.
//

import RealmSwift
import UIKit

class LoanHistory: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String // ID
    @Persisted var title: String // タイトル
    @Persisted var loanName: String // 貸出している人
    @Persisted var loanDate: Date // 貸出した日付
    @Persisted var returnDate: Date // 返却された日付
    @Persisted var loanMemo: String // 貸出した日付
    @Persisted var localThumbnailPath: String // ローカルに保存したサムネイルパス
}
