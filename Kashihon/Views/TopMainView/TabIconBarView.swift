//
//  TabIconBarView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/18.
//

import SwiftUI

struct TabIconBarView: View {
    @Binding var selectTag: Int

    var body: some View {
        HStack {
            Button {
                selectTag = 1
            } label: {
                Image(systemName: "hand.wave.fill")
                    .font(.system(size: 20, weight: .bold))
            }.padding(.horizontal)
            Button {
                selectTag = 2
            } label: {
                Image(systemName: "books.vertical")
                    .font(.system(size: 20, weight: .bold))
            }.padding(.horizontal)
            Button {
                selectTag = 3
            } label: {
                Image(systemName: "gearshape")
                    .font(.system(size: 20, weight: .bold))
            }.padding(.horizontal)

        }.foregroundColor(.white)
            .padding()
            .frame(width: DeviceSizeViewModel().deviceWidth - 40)
            .background(Color.thema1)
            .opacity(0.8)
            .cornerRadius(20)
            .shadow(color: .gray, radius: 3, x: 4, y: 4)
    }
}
