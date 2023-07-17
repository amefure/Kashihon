//
//  SettingView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/16.
//

import SwiftUI

struct SettingView: View {
    private let realm = RelamLocalRepository()

    var body: some View {
        List {
            Section(header: Text("カシホン"), footer: Text("")) {
                Button {
                    realm.deleteAllBook()
                } label: {
                    HStack {
                        Image(systemName: "hand.thumbsup")
                        Text("本棚をリセットする")
                            .fontWeight(.bold)
                    }
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
        }
        .listStyle(GroupedListStyle())
        .foregroundColor(.gray)
    }
}
