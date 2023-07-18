//
//  RowBooksView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/15.
//

import SwiftUI

struct RowBooksView: View {
    public var book: Book

    var body: some View {
        HStack(spacing: 10) {
            // 本のサムネイル
            RowLeftBookThumbnailView(book: book)
            // 本の情報&追加ボタン
            RowRightBookInfoView(book: book)

        }.padding()
            .background(Color(hexString: "#e7e7e7"))
            .cornerRadius(10)
    }
}
