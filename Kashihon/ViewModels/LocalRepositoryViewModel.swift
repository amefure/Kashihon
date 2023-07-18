//
//  LocalRepositoryViewModel.swift
//  Kashihon
//
//  Created by t&a on 2023/07/18.
//

import SwiftUI

class LocalRepositoryViewModel: ObservableObject {
    static let shared = LocalRepositoryViewModel()

    private let relamLocalRepository = RelamLocalRepository()

    @Published var books: [Book] = []

    // MARK: - Create

    public func createBook(_ book: Book) {
        relamLocalRepository.createBook(book)
    }

    // MARK: - Read

    public func readAllBooks() {
        let result = relamLocalRepository.readAllBooks()
        books = Array(result)
    }

    // MARK: - Update

    public func updateBookOnLoan(name: String, memo: String, date: Date, book: Book) {
        relamLocalRepository.updateBookOnLoan(name: name, memo: memo, date: date, book: book)
    }

    public func updateBookMemo(memo: String, book: Book) {
        relamLocalRepository.updateBookMemo(memo: memo, book: book)
    }

    // MARK: - Delete

    public func deleteBook(book: Book) {
        relamLocalRepository.deleteBook(book: book)
    }

    public func deleteAllBook() {
        relamLocalRepository.deleteAllBook()
    }
}
