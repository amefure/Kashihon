//
//  HistoryLoanBookView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/18.
//

import SwiftUI

struct HistoryLoanBookView: View {
    private let imgVM = ImageFileManager()
    @ObservedObject var localRepositoryVM = LocalRepositoryViewModel.shared

    var body: some View {
        AvailableListPlaneStack {
            ForEach(localRepositoryVM.historys) { history in
                HStack {
                    if history.localThumbnailPath != "" {
                        imgVM.loadImage(urlStr: history.localThumbnailPath)
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
                            Spacer()
                            Text(history.loanName)
                                .fontWeight(.bold)
                                .foregroundColor(.thema1)
                        }

                        HStack {
                            Text("貸した日付：")
                            Spacer()
                            Text(DisplayDateManager().getJapanDateDisplayFormatString(history.loanDate))
                                .fontWeight(.bold)
                                .foregroundColor(.thema1)
                        }

                        HStack {
                            Text("返却日：")
                            Spacer()
                            Text(DisplayDateManager().getJapanDateDisplayFormatString(history.returnDate))
                                .fontWeight(.bold)
                                .foregroundColor(.thema1)
                        }

                        HStack {
                            Text("MEMO：")
                            Text(history.loanMemo)
                                .lineLimit(1)
                                .foregroundColor(.gray)
                                .foregroundColor(.thema1)
                            Spacer()
                        }
                    }.foregroundColor(.white)
                        .padding(8)
                        .background(.gray)
                        .cornerRadius(10)
                }
            }
        }.onAppear {
            localRepositoryVM.readAllLoanHistorys()
        }
    }
}
