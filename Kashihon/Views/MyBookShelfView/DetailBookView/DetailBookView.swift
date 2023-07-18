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
    @ObservedObject var localRepositoryVM = LocalRepositoryViewModel.shared

    @State var isPresented: Bool = false
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
                    NoImageView(logoSize: 90, thumbnailSize: 130)
                }
                Spacer()
                VStack(spacing: 0) {
                    Button {
                        if book.OnLoan == false {
                            isPresented = true
                        }
                    } label: {
                        HStack {
                            Text(book.OnLoan ? "貸出中" : "貸出する")
                                .fontWeight(.bold)
                            if book.OnLoan == false {
                                Image(systemName: "hand.tap")
                            }
                        }.padding()
                            .frame(width: deviceSizeViewModel.deviceWidth / 2)
                            .background(book.OnLoan ? Color.thema1 : .clear)
                            .foregroundColor(book.OnLoan ? .white : .thema1)
                            .cornerRadius(20)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.thema1, lineWidth: 3)
                                    .frame(width: deviceSizeViewModel.deviceWidth / 2 - 2)
                            }
                    }
                    .sheet(isPresented: $isPresented) {
                        OnLoanInputView(book: book)
                    }

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
                Text(book.bookMemo)

                Spacer()
            }.padding()
                .background(Color.thema4)
                .cornerRadius(20)
                .foregroundColor(.white)
                .offset(y: 40)
        }
    }
}
