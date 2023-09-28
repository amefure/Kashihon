//
//  SearchBooksView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/15.
//

import SwiftUI

struct SearchBooksView: View {
    private let networkConnectStatusManager = NetworkConnectStatusManager()
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
        VStack {
            OldVersionBackButtonView()
            TextField("タイトル/著者/ISBN...で検索", text: $keyword)
                .font(.system(size: 20, weight: .bold))
                .padding()
                .background(Color.thema4)
                .foregroundColor(.white)
                .cornerRadius(20)

            Button {
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
            } label: {
                Text("検索")
                    .fontWeight(.bold)
                    .frame(width: 100)
                    .padding()
                    .background(Color.thema2)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }

            if !networkConnectStatusManager.getNetworkConnectStatus() {
                NoBookView(text: "ネットワークに接続してください。")
            } else {
                if isLoading {
                    ProgressView()
                }
                if isEmpty, books.isEmpty {
                    NoBookView(text: "検索に一致する書籍が見つかりませんでした。")

                } else {
                    AvailableListBookStack(books: customFilter()) { book in
                        RowBooksView(book: book)
                    }
                }
            }

        }.padding()
    }
}

struct SearchBooksView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBooksView()
    }
}
