//
//  MyBookShelfView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/16.
//

import SwiftUI

struct MyBookShelfView: View {
    private let relamLocalRepository = RelamLocalRepository()
    private let deviceSizeViewModel = DeviceSizeViewModel()

    private let imgVM = ImageFileManager()

    @State var books: [Book] = []

    private let columns = Array(repeating: GridItem(.fixed(DeviceSizeViewModel().deviceWidth / 3 - 20)), count: 3)

    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(books) { book in
                        if book.secureThumbnailUrl != nil {
                            NavigationLink {
                                DetailBookView(book: book)
                            } label: {
                                imgVM.loadImage(urlStr: book.secureThumbnailUrl!.absoluteString)
                                    .resizable()
                                    .shadow(color: .gray, radius: 3, x: 4, y: 4)
                                    .frame(height: 165)
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
                            .frame(height: 165)
                        }
                    }
                }
            }
        }
        .onAppear {
            let result = relamLocalRepository.readAllBooks()
            books = Array(result)
        }
    }
}

struct MyBookShelfView_Previews: PreviewProvider {
    static var previews: some View {
        MyBookShelfView()
    }
}
