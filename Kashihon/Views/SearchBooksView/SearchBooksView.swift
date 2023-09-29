//
//  SearchBooksView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/15.
//

import SwiftUI

struct SearchBooksView: View {
    private let viewModel = SearchBooksViewModel()
    private let publicRepositoryVM = PublicRepositoryViewModel()
    @ObservedObject var localRepositoryVM = LocalRepositoryViewModel.shared

    @State var keyword: String = ""
    @State var books: [Book] = []

    @State var isEmpty: Bool = false
    @State var isLoading: Bool = false

    /// ローカルに既に保存しているものがあれば除去する
    private func customFilter() -> [Book] {
        let localRepositoryIds = localRepositoryVM.books.map(\.id)
        let filtering = books.filter { !localRepositoryIds.contains($0.id) }
        return filtering
    }

    var body: some View {
        VStack(spacing: 0) {
            OldVersionBackButtonView()
            SearchTextFieldView(placeholder: "タイトル/著者/ISBN...で検索",
                                searchText: $keyword,
                                searchAction: {
                                    isLoading = true
                                    if !keyword.isEmpty {
                                        publicRepositoryVM.getAPI(keyword: keyword) { results in
                                            isLoading = false
                                            if results != nil {
                                                books = results!
                                            } else {
                                                books = []
                                                isEmpty = true
                                            }
                                        }
                                    }
                                })

            if !viewModel.isNetwork {
                NoBookView(text: "ネットワークに接続してください。")
            } else {
                if isLoading {
                    ProgressView()
                        .offset(y: -10)
                }
                if isEmpty, books.isEmpty {
                    NoBookView(text: "検索に一致する書籍が見つかりませんでした。")

                } else {
                    AvailableListBookStack(books: customFilter()) { book in
                        RowBooksView(book: book)
                    }.offset(y: -10)
                }
            }
        }
    }
}

struct SearchBooksView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBooksView()
    }
}
