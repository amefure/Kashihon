//
//  DetailBookView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/16.
//

import SwiftUI

struct DetailBookView: View {
    public let book: Book
    private let displayDateManager = DisplayDateManager()
    private let imgVM = ImageFileManager()
    private let deviceSizeViewModel = DeviceSizeViewModel()
    @ObservedObject var localRepositoryVM = LocalRepositoryViewModel.shared

    @State var isPresented: Bool = false
    @State var isPresented2: Bool = false

    var body: some View {
        VStack {
            OldVersionBackButtonView()

            HStack {
                Spacer()
                if book.secureThumbnailUrl != nil {
                    imgVM.loadImage(urlStr: book.secureThumbnailUrl!.absoluteString)
                        .resizable()
                        .shadow(color: .gray, radius: 3, x: 4, y: 4)
                        .frame(width: 130, height: 165)

                } else {
                    NoImageView(logoSize: 90, thumbnailSize: 130)
                }
                Spacer()
                VStack(spacing: 0) {
                    Button {
                        if book.OnLoan == false {
                            isPresented = true
                        }
                    } label: {
                        HStack {
                            if book.OnLoan == false {
                                Text("貸出する")
                                    .fontWeight(.bold)
                                Image(systemName: "hand.tap")
                            } else {
                                Image(systemName: "hand.wave.fill")
                                Text("貸出中")
                                    .fontWeight(.bold)
                                Image(systemName: "hand.wave.fill")
                                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                            }
                        }.padding()
                            .frame(width: deviceSizeViewModel.deviceWidth / 2)
                            .background(book.OnLoan ? Color.thema1 : .clear)
                            .foregroundColor(book.OnLoan ? .white : .thema1)
                            .cornerRadius(20)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.thema1, lineWidth: 3)
                                    .frame(width: deviceSizeViewModel.deviceWidth / 2 - 2)
                            }
                    }
                    .sheet(isPresented: $isPresented) {
                        OnLoanInputView(book: book)
                    }

                    Text(book.concatenationAuthors)
                        .padding()
                        .frame(width: deviceSizeViewModel.deviceWidth / 2)
                        .background(Color.thema2)
                        .cornerRadius(20)
                        .lineLimit(2)

                    Text(displayDateManager.getPublishedDateString(book.publishedDate))
                        .padding()
                        .frame(width: deviceSizeViewModel.deviceWidth / 2)
                        .background(Color.thema3)
                        .cornerRadius(20)

                }.foregroundColor(.white)
                Spacer()
            }

            VStack {
                Text(book.title)
                    .fontWeight(.bold)
                    .padding(.bottom)

                Divider()

                ScrollView {
                    if book.desc.isEmpty {
                        Text("この本の説明はありません。")
                    } else {
                        Text(book.desc)
                    }
                }.frame(maxHeight: deviceSizeViewModel.isSESize ? 80 : 150)

                Divider()

                HStack {
                    Text("MEMO")
                        .fontWeight(.bold)
                        .opacity(0.8)
                    Spacer()
                    Button {
                        isPresented2 = true
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 20, weight: .bold))
                    }
                }.padding(8)

                Text(book.bookMemo)

                Spacer()

            }.padding()
                .background(Color.thema4)
                .cornerRadius(20)
                .foregroundColor(.white)
                .offset(y: 40)
                .sheet(isPresented: $isPresented2) {
                    InputMemoView(book: book)
                }
            AdMobBannerView().frame(width: deviceSizeViewModel.deviceWidth, height: 60)
        }
    }
}
