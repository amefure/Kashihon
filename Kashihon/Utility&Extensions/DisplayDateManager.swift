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

    /// publishedDateを適切に変換する
    public func getPublishedDateString(_ date: String) -> String {
        let cnt = date.count
        if cnt == 4 {
            df.dateFormat = "yyyy"
            let dateObj = df.date(from: date)!
            df.dateFormat = "yyyy年"
            return df.string(from: dateObj)
        } else if cnt == 7 {
            df.dateFormat = "yyyy-MM"
            let dateObj = df.date(from: date)!
            df.dateFormat = "yyyy年M月"
            return df.string(from: dateObj)
        } else if cnt == 10 {
            df.dateFormat = "yyyy-MM-dd"
            let dateObj = df.date(from: date)!
            df.dateFormat = "yyyy年M月dd日"
            return df.string(from: dateObj)
        }
        return "不明"
    }
}
