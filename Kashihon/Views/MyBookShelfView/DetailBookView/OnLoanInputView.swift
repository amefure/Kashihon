//
//  OnLoanInputView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/18.
//

import SwiftUI

struct OnLoanInputView: View {
    @ObservedObject var localRepositoryVM = LocalRepositoryViewModel.shared
    private let validation = ValidationManager()

    @State var name: String = ""
    @State var memo: String = ""
    @State var date: Date = .init()

    @Environment(\.dismiss) var dismiss
    public var book: Book

    var body: some View {
        VStack {
            Text("貸し出した人を入力してください。")
            ZStack(alignment: .leading) {
                if name.isEmpty {
                    Text("貸し出した人")
                        .fontWeight(.bold)
                        .padding(.leading, 20)
                        .opacity(0.5)
                        .zIndex(2)
                        .frame(height: 20)
                }
                TextField("", text: $name)
                    .padding()
                    .background(Color.thema1)
                    .cornerRadius(20).zIndex(1)
            }

            TextField("Memo", text: $memo)
                .padding()
                .background(Color.thema2)
                .cornerRadius(20)

            DatePicker("", selection: $date, displayedComponents: [.date])
                .environment(\.locale, Locale(identifier: "ja_JP"))
                .environment(\.calendar, Calendar(identifier: .japanese))
                .pickerStyle(.wheel)
                .colorInvert()
                .colorMultiply(Color.thema1)
                .padding(10)
                .background(Color.thema3)
                .cornerRadius(20)

            Button {
                if validation.validationText(name) {
                    localRepositoryVM.updateBookOnLoan(name: name, memo: memo, date: date, book: book)
                    localRepositoryVM.readAllBooks()
                    dismiss()
                }
            } label: {
                HStack {
                    Text("貸し出す")
                        .fontWeight(.bold)
                }.padding()
                    .background(!validation.validationText(name) ? .gray : Color.thema4)
                    .cornerRadius(20)
            }.disabled(!validation.validationText(name))
        }.padding()
            .foregroundColor(.white)
    }
}
