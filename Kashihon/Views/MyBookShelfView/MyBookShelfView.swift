//
//  MyBookShelfView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/16.
//

import SwiftUI

struct MyBookShelfView: View {
    @ObservedObject var viewModel = MyBookShelfViewModel()
    @ObservedObject var localRepositoryVM = LocalRepositoryViewModel.shared
    @ObservedObject private var interstitial = AdmobInterstitialView()

    @State var isSearch = false
    @State var searchText = ""
    @State var isPresented = false

    var body: some View {
        VStack(spacing: 0) {
            HStack {
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
                        Text("ノーマル")
                    }
                } label: {
                    Image(systemName: "list.bullet")
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .background(Color.thema4)
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 3, x: 4, y: 4)
                }.padding(.leading, 15)

                Spacer()
                Text("本棚")
                    .fontWeight(.bold)
                    .font(.headline)
                    .foregroundColor(.gray)
                Spacer()

                NavigationLink {
                    SearchBooksView()
                } label: {
                    Image(systemName: "plus")
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .background(Color.thema4)
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 3, x: 4, y: 4)
                }.padding(.trailing, 15)

            }.padding(.horizontal, 10)
                .padding(.bottom, 11)

            if isSearch {
                SearchTextFieldView(placeholder: "タイトル/著者名...で検索",
                                    searchText: $searchText,
                                    searchAction: {
                                        localRepositoryVM.filteringSearchText(searchText)
                                    })
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

                                #if DEBUG
                                    Text("\(book.order)")
                                        .padding()
                                        .background(Color.thema2)
                                        .zIndex(6)
                                #endif

                                NavigationLink {
                                    DetailBookView(book: book)
                                } label: {
                                    if book.secureThumbnailUrl != nil {
                                        viewModel.getThumbnailImage(book)
                                            .resizable()
                                            .shadow(color: .gray, radius: 3, x: 4, y: 4)
                                            .frame(height: viewModel.isSESize ? 100 : 120)
                                    } else {
                                        Text(book.title)
                                            .fontWeight(.bold)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                            .padding(5)
                                            .frame(minWidth: viewModel.isiPadSize ? viewModel.deviceWidth / 8 - 20 : viewModel.deviceWidth / 4 - 20)
                                            .frame(height: viewModel.isSESize ? 100 : 120)
                                            .frame(maxHeight: viewModel.isSESize ? 100 : 120)
                                            .background(.white)
                                            .clipped()
                                            .shadow(color: .gray, radius: 3, x: 4, y: 4)
                                    }
                                }.simultaneousGesture(TapGesture().onEnded {
                                    // 5回遷移したら広告を表示させる
                                    isPresented = true
                                    viewModel.addCountInterstitial()
                                    if viewModel.countInterstitial == 5 {
                                        viewModel.countInterstitial = 0
                                        interstitial.presentInterstitial()
                                    }
                                })

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
        } // VStack
        .onAppear {
            localRepositoryVM.readAllBooks()
            interstitial.loadInterstitial()
            viewModel.migration()
        }
    }
}
