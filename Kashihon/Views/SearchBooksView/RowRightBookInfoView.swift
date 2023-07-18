//
//  RowRightBookInfoView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/18.
//

import SwiftUI

struct RowRightBookInfoView: View {
    private let deviceSizeViewModel = DeviceSizeViewModel()
    private let imgManager = ImageFileManager()
    @ObservedObject var localRepositoryVM = LocalRepositoryViewModel.shared

    public var book: Book

    var body: some View {
        VStack {
            Spacer()

            Text(book.title)
                .fontWeight(.bold)
                .frame(width: deviceSizeViewModel.deviceWidth - 170)
                .lineLimit(2)
                .padding(5)

                .foregroundColor(Color.thema1)

            Spacer()

            HStack {
                Spacer()

                Text(book.concatenationAuthors)
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .frame(width: 140)
                    .padding(5)
                    .foregroundColor(Color.thema1)
                    .cornerRadius(5)

                Spacer()

                Button {
                    if book.secureThumbnailUrl != nil {
                        imgManager.savingImage(urlStr: book.secureThumbnailUrl!.absoluteString)
                    }
                    localRepositoryVM.createBook(book)
                } label: {
                    Text("追加")
                        .fontWeight(.bold)
                        .padding(8)
                        .foregroundColor(.white)
                        .frame(width: 70)
                        .background(Color.thema1)
                        .cornerRadius(20)
                }

                Spacer()
            }

            Spacer()
        }
    }
}
