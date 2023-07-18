//
//  OnLoanInputView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/18.
//

import SwiftUI

struct OnLoanInputView: View {
    @ObservedObject var localRepositoryVM = LocalRepositoryViewModel.shared

    @State var name: String = ""
    @State var memo: String = ""
    @State var date: Date = .init()

    public var book: Book

    var body: some View {
        VStack {
            TextField("貸し出した人", text: $name)
            TextField("Memo", text: $memo)
            DatePicker("", selection: $date)
            Button {
                localRepositoryVM.updateBookOnLoan(name: name, memo: memo, date: date, book: book)
                localRepositoryVM.readAllBooks()
            } label: {
                HStack {
                    Text("貸し出す")
                        .fontWeight(.bold)
                }.padding()
                    .background(Color.thema1)
                    .cornerRadius(20)
            }
        }
    }
}
