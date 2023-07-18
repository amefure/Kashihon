//
//  HeaderView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/18.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Spacer()
            Image("logo-name")
                .resizable()
                .frame(width: 130, height: 40)
            Spacer()
        }.padding(.bottom, 10)

        Divider()
            .padding(.bottom, 10)
    }
}
