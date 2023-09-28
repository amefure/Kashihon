//
//  RelamLocalRepository.swift
//  Kashihon
//
//  Created by t&a on 2023/07/15.
//

import RealmSwift
import UIKit

class RelamLocalRepository: LocalRepositoryProtocol {
    private var realm: Realm

    init() {
        do {
            // ver：理由
            // 1  ：orderプロパティの追加
            let config = Realm.Configuration(schemaVersion: UInt64(MigrationInfo.MIGRATION_VERSION))
            Realm.Configuration.defaultConfiguration = config
            realm = try! Realm()
        } catch {
            print("インスタンス化エラー")
        }
    }

    // MARK: - Create

    public func createBook(_ book: Book) {
        try! realm.write {
            realm.add(book)
        }
    }

    // MARK: - Read

    private func readFindOneBooks(id: String) -> Book? {
        if let result = realm.objects(Book.self).where({ $0.id == id }).first {
            return result
        } else {
            return nil
        }
    }

    public func readAllBooks() -> [Book] {
        let books = realm.objects(Book.self).freeze()
        return Array(books)
    }

    // MARK: - Update

    /// 貸出フラグの更新
    public func updateBookOnLoan(name: String, memo: String, date: Date, book: Book) {
        try! realm.write {
            if let bk = readFindOneBooks(id: book.id) {
                if bk.OnLoan == false {
                    bk.loanName = name
                    bk.loanMemo = memo
                    bk.loanDate = date
                }
                bk.OnLoan.toggle()
            }
        }
    }

    /// Bookメモの更新
    public func updateBookMemo(memo: String, book: Book) {
        try! realm.write {
            if let bk = readFindOneBooks(id: book.id) {
                bk.bookMemo = memo
            }
        }
    }

    /// Book並び替えの更新
    public func updateOrderStock(id: String, order: Int) {
        try! realm.write {
            let books = realm.objects(Book.self)
            if let book = books.where({ $0.id == id }).first {
                book.order = order
            }
        }
    }

    // MARK: - Delete

    public func deleteBook(book: Book) {
        try! realm.write {
            if let bk = readFindOneBooks(id: book.id) {
                realm.delete(bk)
            }
        }
    }

    public func deleteAllBooks() {
        try! realm.write {
            let bookTable = realm.objects(Book.self)
            realm.delete(bookTable)
        }
    }

    // MARK: - Create

    public func createLoanHistory(_ loanHistory: LoanHistory) {
        try! realm.write {
            realm.add(loanHistory)
        }
    }

    public func readAllLoanHistorys() -> [LoanHistory] {
        let historys = realm.objects(LoanHistory.self)
        return Array(historys)
    }

    public func deleteAllLoanHistorys() {
        try! realm.write {
            let historyTable = realm.objects(LoanHistory.self)
            realm.delete(historyTable)
        }
    }
}
