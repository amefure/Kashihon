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
    @Published var currentBook: Book?
    @Published var historys: [LoanHistory] = []

    // フィルタリングモード
    @Published var isFiltering: FilteringMode = .none

    // 新規書籍登録用Order番号
    private var orderNum = 1

    // MARK: - Create

    public func createBook(_ book: Book) {
        book.order = orderNum
        orderNum += 1
        relamLocalRepository.createBook(book)
    }

    // MARK: - Read

    public func readAllBooks() {
        isFiltering = .none
        books = relamLocalRepository.readAllBooks().sorted(by: { $0.order < $1.order })
        if books.count != 0 {
            orderNum = books.count + 1
        } else {
            // 削除されたとき場合もあるため明示的にリセット
            orderNum = 1
        }
    }

    // MARK: - Update

    public func updateBookOnLoan(name: String, memo: String, date: Date, book: Book) {
        relamLocalRepository.updateBookOnLoan(name: name, memo: memo, date: date, book: book)
    }

    public func updateBookReturn(book: Book) {
        relamLocalRepository.updateBookOnLoan(name: "", memo: "", date: Date(), book: book)
    }

    public func updateBookMemo(memo: String, book: Book) {
        relamLocalRepository.updateBookMemo(memo: memo, book: book)
    }

    // MARK: - Delete

    public func deleteBook(book: Book) {
        let items = books
        // 削除する行の行番号を取得
        let deleteOrder = book.order

        // 削除する行の行番号より大きい行番号を全て -1 する
        for i in deleteOrder ..< items.count {
            relamLocalRepository.updateOrderStock(id: items[i].id, order: items[i].order - 1)
        }
        relamLocalRepository.deleteBook(book: book)
        readAllBooks()
    }

    public func deleteAllBooks() {
        relamLocalRepository.deleteAllBooks()
    }

    // MARK: - History

    public func createLoanHistory(_ book: Book) {
        let history = LoanHistory()
        history.title = book.title
        history.loanName = book.loanName
        history.loanDate = book.loanDate
        history.returnDate = Date()
        history.loanMemo = book.loanMemo
        if book.secureThumbnailUrl != nil {
            history.localThumbnailPath = book.secureThumbnailUrl!.absoluteString
        }
        relamLocalRepository.createLoanHistory(history)
    }

    public func readAllLoanHistorys() {
        historys = relamLocalRepository.readAllLoanHistorys()
    }

    public func deleteAllLoanHistorys() {
        relamLocalRepository.deleteAllLoanHistorys()
    }
}

extension LocalRepositoryViewModel {
    // フィルタリング機能の追加
    public func filteringOnLoan() {
        isFiltering = .onLoan
        books = relamLocalRepository
            .readAllBooks()
            .filter { $0.OnLoan == true }
            .sorted(by: { $0.order < $1.order })
    }

    public func filteringOffLoan() {
        isFiltering = .offLoan
        books = relamLocalRepository
            .readAllBooks()
            .filter { $0.OnLoan == false }
            .sorted(by: { $0.order < $1.order })
    }

    public func filteringSearchText(_ text: String) {
        isFiltering = .search
        books = relamLocalRepository
            .readAllBooks()
            .filter(text.isEmpty ? { $0.title != "" } : { $0.title.contains(text) || $0.authors.contains(where: { $0.contains(text) }) })
            .sorted(by: { $0.order < $1.order })
    }

    // 並び替え機能
    public func changeOrder(_ book: Book?, source: Int, destination: Int) {
        guard let bk = book else {
            return
        }
        let items = books

        let moveId = bk.id
        // 上から下に移動する
        if source < destination {
            // 移動元番号から移動先番号の間のアイテムの番号を下げる
            // 0 → 5
            // 1 ~ 5 → 0 ~ 4
            for i in (source + 1) ... destination {
                relamLocalRepository.updateOrderStock(id: items[i].id, order: items[i].order - 1)
            }
            relamLocalRepository.updateOrderStock(id: moveId, order: destination + 1)

            // 下から上に移動する
        } else if destination < source + 1 {
            for i in (destination ... source).reversed() {
                relamLocalRepository.updateOrderStock(id: items[i].id, order: items[i].order + 1)
            }
            relamLocalRepository.updateOrderStock(id: moveId, order: destination + 1)
        }
        readAllBooks()
    }

    // 並び替え機能
    public func migrationSetOrder() {
        var order = 1
        for item in books {
            relamLocalRepository.updateOrderStock(id: item.id, order: order)
            order += 1
        }
        readAllBooks()
    }
}
