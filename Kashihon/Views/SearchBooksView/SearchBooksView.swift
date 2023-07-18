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
            TextField("タイトル/著者/ISBN...で検索", text: $keyword)
                .font(.system(size: 20, weight: .bold))
                .padding()
                .background(Color.thema4)
                .foregroundColor(.white)
                .cornerRadius(20)

            Button {
                if !keyword.isEmpty {
                    GoogleBooksAPIRepository().getAPI(keyword: keyword) { results in
                        books = results
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

            AvailableListBookStack(books: books) { book in
                RowBooksView(book: book)
            }
        }.padding()
    }
}

struct SearchBooksView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBooksView()
    }
}
