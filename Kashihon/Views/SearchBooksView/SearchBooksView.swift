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
            TextField("検索キーワードを入力してね(タイトル/著者/ISBN...)", text: $keyword)
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

            ListBooksView(books: books)
        }.padding()
    }
}

struct SearchBooksView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBooksView()
    }
}
