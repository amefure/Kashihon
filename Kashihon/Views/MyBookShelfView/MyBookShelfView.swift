//
//  MyBookShelfView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/16.
//

import SwiftUI

struct MyBookShelfView: View {
    private let viewModel = MyBookShelfViewModel()
    @ObservedObject var localRepositoryVM = LocalRepositoryViewModel.shared

    @State var isSearch = false
    @State var searchText = ""

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    withAnimation {
                        isSearch.toggle()
                    }
                } label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(searchText.isEmpty ? .thema4 : .thema1)
                }.padding(.leading, 20)
                Spacer()
                Text("本棚")
                    .fontWeight(.bold)
                    .font(.headline)
                    .foregroundColor(.gray)
                Spacer()
                Menu {
                    Button {
                        localRepositoryVM.filteringOnLoan()
                    } label: {
                        if localRepositoryVM.isFiltering == .onLoan {
                            Image(systemName: "checkmark")
                        }
                        Text("貸出中のみ")
                    }

                    Button {
                        localRepositoryVM.filteringOffLoan()
                    } label: {
                        if localRepositoryVM.isFiltering == .offLoan {
                            Image(systemName: "checkmark")
                        }
                        Text("未貸出のみ")
                    }

                    Button {
                        withAnimation {
                            isSearch.toggle()
                        }
                    } label: {
                        if localRepositoryVM.isFiltering == .search {
                            Image(systemName: "checkmark")
                        }
                        Text("検索")
                    }
                    Button {
                        localRepositoryVM.readAllBooks()
                    } label: {
                        if localRepositoryVM.isFiltering == .none {
                            Image(systemName: "checkmark")
                        }
                        Text("解除")
                    }
                } label: {
                    Image(systemName: "list.bullet")
                }.padding(.trailing, 20)
            }.padding([.horizontal, .bottom])

            if isSearch {
                HStack {
                    TextField("タイトル/著者/ISBN...で検索", text: $searchText)
                        .font(.system(size: 20, weight: .bold))
                        .padding(10)
                        .background(Color.thema4)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                    Button {
                        localRepositoryVM.filteringSearchText(searchText)
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.thema1)
                            .cornerRadius(20)
                    }
                }.transition(.scale)
                    .padding()
            }

            if localRepositoryVM.books.isEmpty {
                NoBookView(text: searchText.isEmpty ? "登録されている書籍はありません。" : "\(searchText)にヒットする書籍はありませんでした。")
            } else {
                ScrollView {
                    LazyVGrid(columns: viewModel.columns) {
                        ForEach(localRepositoryVM.books) { book in
                            ZStack {
                                if book.OnLoan {
                                    Text("貸出中")
                                        .padding(5)
                                        .foregroundColor(.white)
                                        .background(Color.thema2)
                                        .zIndex(2)
                                        .opacity(0.8)
                                }

                                Text("\(book.order)")
                                    .padding()
                                    .background(Color.thema2)
                                    .zIndex(6)

                                if book.secureThumbnailUrl != nil {
                                    NavigationLink {
                                        DetailBookView(book: book)
                                    } label: {
                                        viewModel.getThumbnailImage(book)
                                            .resizable()
                                            .shadow(color: .gray, radius: 3, x: 4, y: 4)
                                            .frame(height: viewModel.isSESize ? 90 : 120)
                                    }
                                } else {
                                    NavigationLink {
                                        DetailBookView(book: book)
                                    } label: {
                                        Text(book.title)
                                            .fontWeight(.bold)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                            .padding(5)
                                            .frame(minWidth: viewModel.isiPadSize ? viewModel.deviceWidth / 8 - 20 : viewModel.deviceWidth / 4 - 20)
                                            .frame(height: viewModel.isSESize ? 90 : 120)
                                            .frame(maxHeight: viewModel.isSESize ? 90 : 120)
                                            .background(.white)
                                            .clipped()
                                            .shadow(color: .gray, radius: 3, x: 4, y: 4)
                                    }
                                }
                            }.contextMenu {
                                Button {
                                    localRepositoryVM.deleteBook(book: book)
                                    localRepositoryVM.readAllBooks()
                                } label: {
                                    Text("削除する")
                                        .foregroundColor(Color.thema2)
                                }
                            }.onDrag {
                                // 並び替え操作実行時は検索フィルターをリセット
                                withAnimation {
                                    isSearch = false
                                }
                                localRepositoryVM.readAllBooks()
                                localRepositoryVM.currentBook = book
                                return NSItemProvider(contentsOf: URL(string: "\(book.id)")!)!
                            }.onDrop(of: [.url], delegate:
                                DropViewDelegate(item: book,
                                                 viewModel: localRepositoryVM))
                        }
                    }
                } // ScrollView
            }

            NavigationLink {
                SearchBooksView()
            } label: {
                Text("本を検索して本棚に追加する")
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: viewModel.deviceWidth - 40)
                    .background(Color.thema4)
                    .cornerRadius(20)
            }.shadow(color: .gray, radius: 3, x: 4, y: 4)
        } // VStack
        .onAppear {
            localRepositoryVM.readAllBooks()
            viewModel.migration()
        }
    }
}
