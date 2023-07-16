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

    public func createBook(_ book: Book) {
        try! realm.write {
            realm.add(book)
        }
    }

    public func updateBookOnLoan(_ book: Book) {
        try! realm.write {
            realm.add(book)
        }
    }

    public func readAllBooks() -> Results<Book> {
        let books = realm.objects(Book.self)
        return books
    }

    public func deleteBook(_: String) {
        try! realm.write {
//            realm.add(book)
        }
    }

    public func deleteAllBook() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}
