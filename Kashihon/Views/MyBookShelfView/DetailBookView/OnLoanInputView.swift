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
            HStack {
                Image(systemName: "figure.wave")
                Text("貸し出した人")
                Spacer()
            }.foregroundColor(.gray)

            ZStack(alignment: .leading) {
                if name.isEmpty {
                    Text("お名前")
                        .fontWeight(.bold)
                        .padding(.leading, 20)
                        .opacity(0.6)
                        .zIndex(2)
                        .frame(height: 20)
                }
                TextField("", text: $name)
                    .font(.system(size: 20, weight: .bold))
                    .padding()
                    .background(Color.thema1)
                    .cornerRadius(20).zIndex(1)
            }

            HStack {
                Image(systemName: "highlighter")
                Text("貸し出しメモ")
                Spacer()
            }.foregroundColor(.gray)

            TextField("Memo", text: $memo)
                .font(.system(size: 20, weight: .bold))
                .padding()
                .background(Color.thema2)
                .cornerRadius(20)

            HStack {
                Image(systemName: "calendar")
                Text("貸し出した日")
                Spacer()
            }.foregroundColor(.gray)
            DatePicker("貸し出した日", selection: $date, displayedComponents: [.date])
                .environment(\.locale, Locale(identifier: "ja_JP"))
                .environment(\.calendar, Calendar(identifier: .japanese))
                .datePickerStyle(.wheel)
                .colorInvert()
                .colorMultiply(Color.thema1)
                .padding(10)
                .background(Color.thema3)
                .cornerRadius(20)
                .labelsHidden()

            Button {
                if validation.validationText(name) {
                    localRepositoryVM.updateBookOnLoan(name: name, memo: memo, date: date, book: book)
                    localRepositoryVM.readAllBooks()
                    dismiss()
                }
            } label: {
                HStack {
                    HStack {
                        Image(systemName: "hand.wave.fill")
                        Text("貸し出す")
                            .fontWeight(.bold)
                        Image(systemName: "hand.wave.fill")
                            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    }

                }.padding()
                    .background(!validation.validationText(name) ? .gray : Color.thema4)
                    .cornerRadius(20)
            }.disabled(!validation.validationText(name))
                .padding()
        }.padding()
            .foregroundColor(.white)
    }
}
