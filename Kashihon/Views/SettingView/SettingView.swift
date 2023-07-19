//
//  SettingView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/16.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var localRepositoryVM = LocalRepositoryViewModel.shared

    @State var isPresented: Bool = false
    @State var isPresented2: Bool = false
    @State var isPresented3: Bool = false

    var body: some View {
        AvailableListPlaneStack {
            Section(header: Text("カシホン"), footer: Text("")) {
                Button {
                    isPresented = true
                } label: {
                    HStack {
                        Image(systemName: "trash")
                        Text("本棚をリセットする")
                            .fontWeight(.bold)
                    }
                }

                Button {
                    isPresented2 = true
                } label: {
                    HStack {
                        Image(systemName: "trash")
                        Text("貸し借り履歴をリセットする")
                            .fontWeight(.bold)
                    }
                }

                .alert("本棚をリセットしますか？", isPresented: $isPresented) {
                    Button(role: .destructive) {
                        localRepositoryVM.deleteAllBooks()
                        localRepositoryVM.readAllBooks()
                        isPresented3 = true
                    } label: {
                        Text("削除")
                            .fontWeight(.bold)
                    }
                } message: {
                    Text("")
                }
                .alert("貸し借り履歴をリセットしますか？", isPresented: $isPresented2) {
                    Button(role: .destructive) {
                        localRepositoryVM.deleteAllLoanHistorys()
                        localRepositoryVM.readAllLoanHistorys()
                        isPresented3 = true
                    } label: {
                        Text("削除")
                            .fontWeight(.bold)
                    }
                } message: {
                    Text("")
                }
                .alert("削除しました。", isPresented: $isPresented3) {} message: {
                    Text("")
                }
            }

            Section(header: Text("Link"), footer: Text("")) {
                // 1:レビューページ
                Link(destination: URL(string: "https://apps.apple.com/jp/app/%E3%81%BF%E3%82%93%E3%81%AA%E3%81%AE%E8%AA%95%E7%94%9F%E6%97%A5/id1673431227?action=write-review")!, label: {
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
