//
//  AvailableListStack.swift
//  Kashihon
//
//  Created by t&a on 2023/07/18.
//

import SwiftUI

struct AvailableListStack<Content: View>: View {
    var content: (Book) -> Content
    var books: [Book]

    init(books: [Book], @ViewBuilder content: @escaping (Book) -> Content) {
        self.books = books
        self.content = content
    }

    var body: some View {
        if #available(iOS 16.0, *) {
            List(books) { book in
                self.content(book)
            }
            .listStyle(.grouped)
            .scrollContentBackground(.hidden)
            .background(Color.white)
        } else {
            List(books) { book in
                content(book)
            }
            .listStyle(.grouped)
        }
    }
}
