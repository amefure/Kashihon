//
//  SettingView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/16.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var localRepositoryVM = LocalRepositoryViewModel.shared

    @State var isBookDeleteAlert: Bool = false
    @State var isHistoryDeleteAlert: Bool = false
    @State var isDeleteConfirmAlert: Bool = false

    var body: some View {
        AvailableListPlaneStack {
            Section(header: Text("カシホン"), footer: Text("")) {
                Button {
                    isBookDeleteAlert = true
                } label: {
                    HStack {
                        Image(systemName: "trash")
                        Text("本棚をリセットする")
                            .fontWeight(.bold)
                    }
                }

                Button {
                    isHistoryDeleteAlert = true
                } label: {
                    HStack {
                        Image(systemName: "trash")
                        Text("貸し借り履歴をリセットする")
                            .fontWeight(.bold)
                    }
                }

                .alert("本棚をリセットしますか？", isPresented: $isBookDeleteAlert) {
                    Button(role: .destructive) {
                        localRepositoryVM.deleteAllBooks()
                        localRepositoryVM.readAllBooks()
                        isDeleteConfirmAlert = true
                    } label: {
                        Text("削除")
                            .fontWeight(.bold)
                    }
                } message: {
                    Text("")
                }
                .alert("貸し借り履歴をリセットしますか？", isPresented: $isHistoryDeleteAlert) {
                    Button(role: .destructive) {
                        localRepositoryVM.deleteAllLoanHistorys()
                        localRepositoryVM.readAllLoanHistorys()
                        isDeleteConfirmAlert = true
                    } label: {
                        Text("削除")
                            .fontWeight(.bold)
                    }
                } message: {
                    Text("")
                }
                .alert("削除しました。", isPresented: $isDeleteConfirmAlert) {} message: {
                    Text("")
                }
            }

            Section(header: Text("Link"), footer: Text("")) {
                // 1:レビューページ
                Link(destination: URL(string: "https://apps.apple.com/jp/app/%E3%82%AB%E3%82%B7%E3%83%9B%E3%83%B3/id6451445308?action=write-review")!, label: {
                    HStack {
                        Image(systemName: "hand.thumbsup")
                        Text("アプリをレビューする")
                    }
                })

                // 2:シェアボタン
                ShareButtonView()

                // 3:利用規約とプライバシーポリシー
                Link(destination: URL(string: "https://tech.amefure.com/app-terms-of-service")!, label: {
                    HStack {
                        Image(systemName: "note.text")
                        Text("利用規約とプライバシーポリシー")
                        Image(systemName: "link").font(.caption)
                    }
                })
            }
        }.foregroundColor(Color.thema1)
    }
}
