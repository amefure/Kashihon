//
//  OnLoanListView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/18.
//

import SwiftUI

struct OnLoanListView: View {
    private let imgVM = ImageFileManager()

    @ObservedObject var localRepositoryVM = LocalRepositoryViewModel.shared

    var body: some View {
        VStack(spacing: 0) {
            Text("貸し出しリスト")
                .fontWeight(.bold)
                .font(.headline)
                .foregroundColor(.gray)

            if localRepositoryVM.books.filter { $0.OnLoan == true }.isEmpty {
                NoBookView(text: "貸し出ししている書籍はありません。")

            } else {
                AvailableListBookStack(books: localRepositoryVM.books.filter { $0.OnLoan == true }) { book in
                    NavigationLink {
                        DetailBookView(book: book)
                    } label: {
                        HStack {
                            if book.secureThumbnailUrl != nil {
                                imgVM.loadImage(urlStr: book.secureThumbnailUrl!.absoluteString)
                                    .resizable()
                                    .shadow(color: .gray, radius: 3, x: 4, y: 4)
                                    .frame(width: 80, height: 100)

                            } else {
                                NoImageView(logoSize: 60, thumbnailSize: 80)
                            }
                            VStack(spacing: 0) {
                                HStack {
                                    Text("貸している人：")
                                        .font(.caption)
                                    Spacer()
                                    Text(book.loanName)
                                        .fontWeight(.bold)
                                        .lineLimit(1)

                                    Spacer()
                                }.padding(8)
                                    .background(Color.thema2)
                                    .cornerRadius(10)

                                HStack {
                                    Text("貸した日付：")
                                        .font(.caption)
                                    Spacer()
                                    Text(DisplayDateManager().getJapanDateDisplayFormatString(book.loanDate))
                                        .fontWeight(.bold)
                                    Spacer()
                                }.padding(8)
                                    .background(Color.thema3)
                                    .cornerRadius(10)

                                HStack {
                                    Text("MEMO：")
                                        .font(.caption)
                                    Text(book.bookMemo)
                                        .lineLimit(1)

                                    Spacer()
                                }.padding(8)
                                    .background(Color.thema4)
                                    .cornerRadius(10)
                            }.foregroundColor(.white)
                        }
                    }.swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button {
                            localRepositoryVM.createLoanHistory(book)
                            localRepositoryVM.updateBookReturn(book: book)
                            localRepositoryVM.readAllBooks()
                        } label: {
                            Text("返却")
                        }.tint(Color.thema3)
                    }
                }
            }
            NavigationLink {
                HistoryLoanBookView()
            } label: {
                Text("今までの貸出履歴")
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: DeviceSizeViewModel().deviceWidth - 40)
                    .background(Color.thema4)
                    .cornerRadius(20)
            }.shadow(color: .gray, radius: 3, x: 4, y: 4)
        }.onAppear {
            localRepositoryVM.readAllBooks()
        }
    }
}
