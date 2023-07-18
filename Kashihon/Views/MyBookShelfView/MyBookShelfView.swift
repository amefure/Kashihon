//
//  MyBookShelfView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/16.
//

import SwiftUI

struct MyBookShelfView: View {
    private let deviceSizeViewModel = DeviceSizeViewModel()

    private let imgVM = ImageFileManager()

    @ObservedObject var localRepositoryVM = LocalRepositoryViewModel.shared

    private let columns = Array(repeating: GridItem(.fixed(DeviceSizeViewModel().deviceWidth / 4 - 20)), count: 4)

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(localRepositoryVM.books) { book in
                        if book.secureThumbnailUrl != nil {
                            NavigationLink {
                                DetailBookView(book: book)
                            } label: {
                                imgVM.loadImage(urlStr: book.secureThumbnailUrl!.absoluteString)
                                    .resizable()
                                    .shadow(color: .gray, radius: 3, x: 4, y: 4)
                                    .frame(height: 120)
                            }
                        } else {
                            NavigationLink {
                                DetailBookView(book: book)
                            } label: {
                                VStack {
                                    Image("logo")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .padding()
                                    Text("No Image...")
                                        .fontWeight(.bold)
                                        .foregroundColor(.gray)
                                }
                            }
                            .background(.white)
                            .shadow(color: .gray, radius: 3, x: 4, y: 4)
                            .frame(height: 120)
                        }
                    }
                }
            } // ScrollView

            NavigationLink {
                SearchBooksView()
            } label: {
                Text("本を検索して本棚に追加する")
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: DeviceSizeViewModel().deviceWidth - 40)
                    .background(Color.thema4)
                    .cornerRadius(20)
            }.shadow(color: .gray, radius: 3, x: 4, y: 4)
        } // VStack
        .onAppear {
            localRepositoryVM.readAllBooks()
        }
    }
}
