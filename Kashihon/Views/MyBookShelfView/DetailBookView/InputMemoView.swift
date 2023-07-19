//
//  InputMemoView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/19.
//

import SwiftUI

struct InputMemoView: View {
    private let validation = ValidationManager()
    @ObservedObject var localRepositoryVM = LocalRepositoryViewModel.shared

    @State var memo: String = ""
    public let book: Book

    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "highlighter")
                Text("Bookメモ")
                Spacer()
            }.foregroundColor(.gray)

            TextField("Memo", text: $memo)
                .font(.system(size: 20, weight: .bold))
                .padding()
                .background(Color.thema2)
                .cornerRadius(20)

            Button {
                if validation.validationText(memo) {
                    localRepositoryVM.updateBookMemo(memo: memo, book: book)
                    localRepositoryVM.readAllBooks()
                    dismiss()
                }
            } label: {
                Text("メモを登録")
                    .fontWeight(.bold).padding()
                    .background(!validation.validationText(memo) ? .gray : Color.thema4)
                    .cornerRadius(20)
            }.disabled(!validation.validationText(memo))
        }.padding()
            .foregroundColor(.white)
            .onAppear {
                memo = book.bookMemo
            }
    }
}
