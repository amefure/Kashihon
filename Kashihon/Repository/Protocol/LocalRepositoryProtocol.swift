//
//  LocalRepositoryProtocol.swift
//  Kashihon
//
//  Created by t&a on 2023/07/24.
//

import UIKit

protocol LocalRepositoryProtocol {
    // Book
    func createBook(_ book: Book)
    func readAllBooks() -> [Book]
    func updateBookOnLoan(name: String, memo: String, date: Date, book: Book)
    func updateBookMemo(memo: String, book: Book)
    func deleteBook(book: Book)
    func deleteAllBooks()
    // History
    func createLoanHistory(_ history: LoanHistory)
    func readAllLoanHistorys() -> [LoanHistory]
    func deleteAllLoanHistorys()
}
