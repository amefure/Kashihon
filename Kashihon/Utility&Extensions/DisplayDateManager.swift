//
//  DisplayDateManager.swift
//  Kashihon
//
//  Created by t&a on 2023/07/18.
//

import UIKit

class DisplayDateManager {
    // MARK: - 日付表示用モデル

    // DateFormatterをプロパティに持つ
    // 日付の表示形式を変更する

    private let df: DateFormatter = .init()
    private let calendar: Calendar = .current

    init() {
        df.calendar = Calendar(identifier: .gregorian)
        df.locale = Locale(identifier: "ja_JP")
        df.timeZone = TimeZone(identifier: "Asia/Tokyo")
        df.dateStyle = .short
        df.timeStyle = .none
    }

    /// yyyy年M月dd日形式：年月日のみ
    public func getJapanDateDisplayFormatString(_ date: Date) -> String {
        df.dateFormat = "yyyy年M月dd日"
        return df.string(from: date)
    }

    /// yyyy-MM-dd形式の文字列をDate型で返す
    public func getDateStringDate(_ date: String) -> Date {
        df.dateFormat = "yyyy-MM-dd"
        return df.date(from: date)!
    }
}
