//
//  DetailBookView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/16.
//

import SwiftUI

struct DetailBookView: View {
    public let book: Book
    var body: some View {
        VStack {
            if let url = book.secureThumbnailUrl {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
            } else {
                Text("No Image")
            }
        }
    }
}
