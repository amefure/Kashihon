//
//  FilteringMode.swift
//  Kashihon
//
//  Created by t&a on 2023/09/28.
//

import UIKit

enum FilteringMode {
    // 検索テキスト
    case search
    // 貸出中のみ
    case onLoan
    // 未貸出のみ
    case offLoan
    // デフォルト
    case none
}
