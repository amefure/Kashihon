//
//  ListBooksView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/15.
//

import SwiftUI

struct ListBooksView: View {
    public var books: [Book]

    var body: some View {
        VStack {
            if #available(iOS 16.0, *) {
                List(books) { book in
                    RowBooksView(book: book)
                }.listStyle(.grouped)
                    .scrollContentBackground(.hidden)
                    .background(.white)
            } else {
                List(books) { book in
                    RowBooksView(book: book)
                }.listStyle(.grouped)
            }
        }
    }
}
