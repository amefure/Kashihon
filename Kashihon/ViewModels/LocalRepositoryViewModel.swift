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

    public func createBook(_ book: Book) {
        relamLocalRepository.createBook(book)
    }

    public func updateBookOnLoan(_ book: Book) {
        relamLocalRepository.updateBookOnLoan(book)
    }

    public func readAllBooks() {
        let result = relamLocalRepository.readAllBooks()
        books = Array(result)
    }

    public func deleteBook(_ id: String) {
        relamLocalRepository.deleteBook(id)
    }

    public func deleteAllBook() {
        relamLocalRepository.deleteAllBook()
    }
}
