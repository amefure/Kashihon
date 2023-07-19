//
//  NoBookView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/19.
//

import SwiftUI

struct NoBookView: View {
    public var text: String

    var body: some View {
        Spacer()
        Image("logo")
            .resizable()
            .frame(width: 200, height: 200)
            .opacity(0.8)

        Text(text)
            .padding()
            .foregroundColor(.gray)
        Spacer()
    }
}
