//
//  NoImageView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/18.
//

import SwiftUI

struct NoImageView: View {
    public var logoSize: CGFloat
    public var thumbnailSize: CGFloat

    var body: some View {
        VStack(spacing: 0) {
            Image("logo")
                .resizable()
                .frame(width: logoSize, height: logoSize)
                .padding(10)

            Text("No Image...")
                .fontWeight(.bold)
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.bottom)
        }.background(.white)
            .frame(width: thumbnailSize, height: thumbnailSize / 0.8)
            .clipped()
            .shadow(color: .gray, radius: 3, x: 4, y: 4)
    }
}
