//
//  OnLoanListView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/18.
//

import SwiftUI

struct OnLoanListView: View {
    private let deviceSizeManager = DeviceSizeManager()
    private let displayDateManager = DisplayDateManager()
    private let imageFileManager = ImageFileManager()

    @ObservedObject var localRepositoryVM = LocalRepositoryViewModel.shared

    @State var isBookInfo: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    isBookInfo.toggle()
                } label: {
                    Text(isBookInfo ? "書籍情報" : "貸出情報")
                        .fontWeight(.bold)
                        .padding(5)
                        .foregroundColor(.white)
                        .background(isBookInfo ? Color.thema3 : Color.thema4)
                        .cornerRadius(10)
                }.shadow(color: .gray, radius: 3, x: 4, y: 4)
                    .padding(.leading, 15)

                Spacer()

                Text("貸し出しリスト")
                    .fontWeight(.bold)
                    .font(.headline)
                    .foregroundColor(.gray)

                Spacer()

                NavigationLink {
                    HistoryLoanBookView()
                } label: {
                    Text("貸出履歴")
                        .fontWeight(.bold)
                        .padding(5)
                        .foregroundColor(.white)
                        .background(Color.thema4)
                        .cornerRadius(10)
                }.shadow(color: .gray, radius: 3, x: 4, y: 4)
                    .padding(.trailing, 15)
            }.padding(.bottom, 10)

            if localRepositoryVM.books.filter({ $0.OnLoan == true }).isEmpty {
                NoBookView(text: "貸し出ししている書籍はありません。")

            } else {
                AvailableListBookStack(books: localRepositoryVM.books.filter { $0.OnLoan == true }) { book in
                    NavigationLink {
                        DetailBookView(book: book)
                    } label: {
                        HStack {
                            if book.secureThumbnailUrl != nil {
                                imageFileManager.loadImage(urlStr: book.secureThumbnailUrl!.absoluteString)
                                    .resizable()
                                    .frame(width: 80, height: 100)
                                    .shadow(color: .gray, radius: 3, x: 4, y: 4)

                            } else {
                                Text(book.title)
                                    .fontWeight(.bold)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .padding(5)
                                    .frame(width: 80, height: 100)
                                    .background(.white)
                                    .clipped()
                                    .shadow(color: .gray, radius: 3, x: 4, y: 4)
                            }
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text(isBookInfo ? "タイトル：" : "貸している人：")
                                        .font(.caption)
                                    Spacer()
                                    Text(isBookInfo ? book.title : book.loanName)
                                        .fontWeight(.bold)
                                        .lineLimit(1)

                                }.padding(.horizontal, 8)

                                HStack {
                                    Text(isBookInfo ? "著書：" : "貸した日付：")
                                        .font(.caption)
                                    Spacer()
                                    Text(isBookInfo ? book.concatenationAuthors : displayDateManager.getJapanDateDisplayFormatString(book.loanDate))
                                        .fontWeight(.bold)
                                }.padding(.horizontal, 8)

                                HStack {
                                    Text(isBookInfo ? "書籍\nMEMO：" : "貸し出し\nMEMO：")
                                        .font(.caption)
                                    Text(isBookInfo ? book.bookMemo : book.loanMemo)
                                        .lineLimit(1)

                                    Spacer()
                                }.padding(.horizontal, 8)
                            }.foregroundColor(Color(hexString: "#555555"))
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

        }.onAppear {
            localRepositoryVM.readAllBooks()
        }
    }
}
