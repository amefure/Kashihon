//
//  RelamLocalRepository.swift
//  Kashihon
//
//  Created by t&a on 2023/07/15.
//

import RealmSwift
import UIKit

class RelamLocalRepository {
    private var realm: Realm

    init() {
        do {
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

    public func readAllBooks() -> Results<Book> {
        let books = realm.objects(Book.self)
        return books
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

    // MARK: - Delete

    public func deleteBook(book: Book) {
        try! realm.write {
            if let bk = readFindOneBooks(id: book.id) {
                realm.delete(bk)
            }
        }
    }

    public func deleteAllBook() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}

extension RelamLocalRepository {
    // MARK: - Create

    public func createLoanHistory(_ loanHistory: LoanHistory) {
        try! realm.write {
            realm.add(loanHistory)
        }
    }

    public func readAllLoanHistorys() -> Results<LoanHistory> {
        let historys = realm.objects(LoanHistory.self)
        return historys
    }
}
