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
            List(books) { book in
                RowBooksView(book: book)
            }
        }
    }
}
