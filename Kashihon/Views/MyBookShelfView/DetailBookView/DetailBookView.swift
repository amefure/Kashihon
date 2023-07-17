//
//  DetailBookView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/16.
//

import SwiftUI

struct DetailBookView: View {
    public let book: Book

    private let imgVM = ImageFileManager()
    private let deviceSizeViewModel = DeviceSizeViewModel()

    var body: some View {
        VStack {
            HStack {
                Spacer()
                if book.secureThumbnailUrl != nil {
                    imgVM.loadImage(urlStr: book.secureThumbnailUrl!.absoluteString)
                        .resizable()
                        .shadow(color: .gray, radius: 3, x: 4, y: 4)
                        .frame(width: 130, height: 165)

                } else {
                    VStack {
                        Image("logo")
                            .resizable()
                            .frame(width: 90, height: 90)
                            .padding()
                        Text("No Image...")
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                    }
                    .background(.white)
                    .shadow(color: .gray, radius: 3, x: 4, y: 4)
                    .frame(width: 130, height: 165)
                }
                Spacer()
                VStack(spacing: 0) {
                    Text(book.authors[0])
                        .padding()
                        .frame(width: deviceSizeViewModel.deviceWidth / 2)
                        .background(Color.thema2)
                        .cornerRadius(20)
                    Text(book.publishedDate)
                        .padding()
                        .frame(width: deviceSizeViewModel.deviceWidth / 2)
                        .background(Color.thema3)
                        .cornerRadius(20)

                }.foregroundColor(.white)
                Spacer()
            }

            VStack {
                Text(book.title)
                    .fontWeight(.bold)
                    .padding(.bottom)

                Divider()

                Text(book.desc)

                Divider()
                Text("MEMO")
                Text(book.memo)

                Spacer()
            }.padding()
                .background(Color.thema4)
                .cornerRadius(20)
                .foregroundColor(.white)
                .offset(y: 40)
        }
    }
}
