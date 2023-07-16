//
//  MyBookShelfView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/16.
//

import SwiftUI

struct MyBookShelfView: View {
    private let relamLocalRepository = RelamLocalRepository()

    @State var books: [Book] = []

    private let columns = Array(repeating: GridItem(.flexible(maximum: 130)), count: 3)

    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(books) { book in
                        if let url = book.secureThumbnailUrl {
                            AsyncImage(url: url) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }.shadow(color: .gray, radius: 3, x: 4, y: 4)
                        } else {
                            NavigationLink {
                                DetailBookView(book: book)
                            } label: {
                                VStack {
                                    Image("logo")
                                        .resizable()
                                        .frame(maxHeight: 100)
                                        .padding()
                                    Text("No Image...")
                                        .fontWeight(.bold)
                                        .foregroundColor(.gray)
                                }

                            }.background(.white)
                                .shadow(color: .gray, radius: 3, x: 4, y: 4)
                        }
                    }
                }
            }
        }
//        ListBooksView(books: books)
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
