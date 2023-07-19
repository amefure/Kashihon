//
//  OldVersionBackButtonView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/19.
//

import SwiftUI

struct OldVersionBackButtonView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        if #available(iOS 16.0, *) {
        } else {
            HStack {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("戻る")
                    }.foregroundColor(.thema4)
                        .padding()
                }.navigationBarHidden(true)
                Spacer()
            }
        }
    }
}
