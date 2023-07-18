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
        VStack {
            AvailableListStack(books: localRepositoryVM.books.filter { $0.OnLoan == true }) { book in
                NavigationLink {
                    DetailBookView(book: book)
                } label: {
                    HStack {
                        if book.secureThumbnailUrl != nil {
                            imgVM.loadImage(urlStr: book.secureThumbnailUrl!.absoluteString)
                                .resizable()
                                .shadow(color: .gray, radius: 3, x: 4, y: 4)
                                .frame(width: 80, height: 60)

                        } else {
                            VStack {
                                Image("logo")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding()
                                Text("No Image...")
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                            }.background(.white)
                                .shadow(color: .gray, radius: 3, x: 4, y: 4)
                                .frame(height: 80)
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
                }
            }.listStyle(.grouped)
        }
    }
}
