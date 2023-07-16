//
//  SearchBooksView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/15.
//

import SwiftUI

struct SearchBooksView: View {
    @State var keyword: String = ""
    @State var books: [Book] = []

    var body: some View {
        VStack {
            TextField("検索キーワードを入力してね", text: $keyword)
            Button {
                if !keyword.isEmpty {
                    GoogleBooksAPIRepository().getAPI(keyword: keyword) { results in
                        books = results
                    }
                }
            } label: {
                Text("検索")
            }

            ListBooksView(books: books)
        }
    }
}

struct SearchBooksView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBooksView()
    }
}
