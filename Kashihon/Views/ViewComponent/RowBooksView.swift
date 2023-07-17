//
//  RowBooksView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/15.
//

import SwiftUI

struct RowBooksView: View {
    private let imgVM = ImageFileManager()
    private let relamLocalRepository = RelamLocalRepository()

    public var book: Book

    var body: some View {
        HStack {
            if let url = book.secureThumbnailUrl {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }.frame(width: 100, height: 100)
            } else {
                Image(systemName: "iphone")
                    .frame(width: 100, height: 100)
            }
            Text(book.title)
            Text("\(book.pageCount)")
            Button {
                if book.secureThumbnailUrl != nil {
                    imgVM.savingImage(urlStr: book.secureThumbnailUrl!.absoluteString)
                }
                relamLocalRepository.createBook(book)
            } label: {
                Image(systemName: "plus")
            }
        }
    }
}
