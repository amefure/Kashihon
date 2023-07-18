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
            List(localRepositoryVM.books.filter { $0.OnLoan == true }) { book in
                HStack {
                    if book.secureThumbnailUrl != nil {
                        NavigationLink {
                            DetailBookView(book: book)
                        } label: {
                            imgVM.loadImage(urlStr: book.secureThumbnailUrl!.absoluteString)
                                .resizable()
                                .shadow(color: .gray, radius: 3, x: 4, y: 4)
                                .frame(height: 60)
                        }
                    } else {
                        NavigationLink {
                            DetailBookView(book: book)
                        } label: {
                            VStack {
                                Image("logo")
                                    .resizable()
                                    .frame(width: 90, height: 90)
                                    .padding()
                                Text("No Image...")
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                            }
                        }
                        .background(.white)
                        .shadow(color: .gray, radius: 3, x: 4, y: 4)
                        .frame(height: 60)
                    }
                    Text(book.loanName)
                    Text(book.bookMemo)
                }
            }
        }
    }
}
