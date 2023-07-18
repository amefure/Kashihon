//
//  RowLeftBookThumbnailView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/18.
//

import SwiftUI

struct RowLeftBookThumbnailView: View {
    public var book: Book
    var body: some View {
        if let url = book.secureThumbnailUrl {
            AsyncImage(url: url) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }.frame(width: 80, height: 100)
                .shadow(color: .gray, radius: 3, x: 4, y: 4)
        } else {
            NoImageView(logoSize: 60, thumbnailSize: 80)
        }
    }
}
