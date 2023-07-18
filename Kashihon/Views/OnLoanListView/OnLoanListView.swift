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
                        VStack {
                            HStack {
                                Text("貸している人：")

                                Text(book.loanName)
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            HStack {
                                Text("貸した日付：")
                                Text(DisplayDateManager().getJapanDateDisplayFormatString(book.loanDate))
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            HStack {
                                Text("MEMO：")
                                Text(book.bookMemo)
                                    .lineLimit(1)
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                        }
                    }
                }.swipeActions(edge: .trailing) {
                    Button(role: .none) {
                        localRepositoryVM.updateBookReturn(book: book)
                        localRepositoryVM.createLoanHistory(book)
                        localRepositoryVM.readAllBooks()
                    } label: {
                        Text("返却")
                    }.background(Color.thema1)
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
