//
//  HistoryLoanBookView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/18.
//

import SwiftUI

struct HistoryLoanBookView: View {
    private let displayDateManager = DisplayDateManager()
    private let imageFileManager = ImageFileManager()
    @ObservedObject var localRepositoryVM = LocalRepositoryViewModel.shared

    @State var isBookInfo: Bool = false

    var body: some View {
        AvailableListPlaneStack {
            ForEach(localRepositoryVM.historys) { history in
                HStack {
                    if history.localThumbnailPath != "" {
                        imageFileManager.loadImage(urlStr: history.localThumbnailPath)
                            .resizable()
                            .shadow(color: .gray, radius: 3, x: 4, y: 4)
                            .frame(width: 80, height: 100)

                    } else {
                        Text(history.title)
                            .fontWeight(.bold)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(5)
                            .frame(width: 80, height: 100)
                            .background(.white)
                            .clipped()
                            .shadow(color: .gray, radius: 3, x: 4, y: 4)
                    }

                    VStack(spacing: 0) {
                        HStack {
                            Text(isBookInfo ? "タイトル：" : "貸していた人：")
                                .font(.caption)
                            Spacer()
                            Text(isBookInfo ? history.title : history.loanName)
                                .fontWeight(.bold)
                                .lineLimit(1)
                        }

                        HStack {
                            Text("貸した日付：")
                                .font(.caption)
                            Spacer()
                            Text(displayDateManager.getJapanDateDisplayFormatString(history.loanDate))
                                .fontWeight(.bold)
                        }

                        HStack {
                            Text("返却日：")
                                .font(.caption)
                            Spacer()
                            Text(displayDateManager.getJapanDateDisplayFormatString(history.returnDate))
                                .fontWeight(.bold)
                        }

                        HStack {
                            Text("MEMO：")
                                .font(.caption)
                            Text(history.loanMemo)
                                .fontWeight(.bold)
                                .lineLimit(1)
                            Spacer()
                        }
                    }.foregroundColor(Color(hexString: "#555555"))
                        .padding(8)
                }
            }
        }.onAppear {
            localRepositoryVM.readAllLoanHistorys()
        }.toolbar {
            ToolbarItem(placement: .principal) {
                Text("貸し出し履歴")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
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
            }
        }
    }
}
