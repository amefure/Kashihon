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
                            Text("貸している人：")
                                .font(.caption)
                            Spacer()
                            Text(history.loanName)
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
                    }.foregroundColor(.thema1)
                        .padding(8)
                        .background(Color(hexString: "#e7e7e7"))
                        .cornerRadius(10)
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
        }
    }
}
