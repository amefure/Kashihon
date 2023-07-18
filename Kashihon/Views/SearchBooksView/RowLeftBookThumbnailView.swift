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
            VStack {
                Image("logo")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .padding()
                Text("No Image...")
                    .fontWeight(.bold)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.bottom)
            }.background(.white)
                .frame(width: 80, height: 100)
                .clipped()
                .shadow(color: .gray, radius: 3, x: 4, y: 4)
        }
        
    }
}

