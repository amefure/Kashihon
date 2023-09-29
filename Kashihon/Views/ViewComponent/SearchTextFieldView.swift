//
//  SearchTextFieldView.swift
//  Kashihon
//
//  Created by t&a on 2023/09/29.
//

import SwiftUI

struct SearchTextFieldView: View {
    public var placeholder: String
    @Binding var searchText: String
    public var searchAction: () -> Void

    var body: some View {
        HStack {
            TextField(placeholder, text: $searchText)
                .font(.system(size: 20, weight: .bold))
                .padding(10)
                .background(Color.thema4)
                .foregroundColor(.white)
                .cornerRadius(20)
            Button {
                searchAction()
            } label: {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.thema1)
                    .cornerRadius(20)
            }
        }.transition(.scale)
            .padding()
    }
}

struct SearchTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTextFieldView(placeholder: "placeholder", searchText: Binding.constant(""), searchAction: {})
    }
}
