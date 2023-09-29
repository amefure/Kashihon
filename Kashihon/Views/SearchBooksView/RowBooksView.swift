//
//  RowBooksView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/15.
//

import SwiftUI

struct RowBooksView: View {
    private let deviceSizeManager = DeviceSizeManager()
    private let imageFileManager = ImageFileManager()
    @ObservedObject var localRepositoryVM = LocalRepositoryViewModel.shared

    public var book: Book

    @State var isClick: Bool = false

    var body: some View {
        HStack(spacing: 3) {
            // 本のサムネイル
            if let url = book.secureThumbnailUrl {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }.frame(width: 60, height: 90)
                    .shadow(color: .gray, radius: 3, x: 4, y: 4)
            } else {
                Image("No_Image")
                    .resizable()
                    .frame(width: 60, height: 90)
                    .shadow(color: .gray, radius: 3, x: 4, y: 4)
            }

            // 本の情報&追加ボタン
            VStack(alignment: .leading, spacing: 0) {
                Text(book.title)
                    .font(.system(size: 12))
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .padding(5)
                    .foregroundColor(Color.thema1)

                Text(book.concatenationAuthors)
                    .font(.system(size: 10))
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .padding(5)
                    .foregroundColor(Color.thema1)

                Spacer()

                HStack {
                    Spacer()
                    Button {
                        isClick = true
                        if book.secureThumbnailUrl != nil {
                            imageFileManager.savingImage(urlStr: book.secureThumbnailUrl!.absoluteString)
                        }
                        localRepositoryVM.createBook(book)
                    } label: {
                        Text(isClick ? "済み" : "追加")
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .padding(5)
                            .foregroundColor(isClick ? .white : Color.thema2)
                            .frame(width: 50)
                            .background(isClick ? Color.thema2 : .clear)
                            .cornerRadius(10)
                            .overlay {
                                if !isClick {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.thema2, lineWidth: 3)
                                }
                            }
                    }.buttonStyle(.borderless)
                        .disabled(isClick)
                }
            }
        }
        .padding(10)
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color(hexString: "#555555"), lineWidth: 3)
                .frame(width: deviceSizeManager.deviceWidth - 10)
                .opacity(0.4)
        }
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5))
    }
}
