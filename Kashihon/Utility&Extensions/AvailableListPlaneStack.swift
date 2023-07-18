//
//  AvailableListPlaneStack.swift
//  Kashihon
//
//  Created by t&a on 2023/07/18.
//

import SwiftUI

struct AvailableListPlaneStack<Content: View>: View {
    var content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        if #available(iOS 16.0, *) {
            List {
                content
            }.scrollContentBackground(.hidden)
                .listStyle(.grouped)
                .background(Color.white)
        } else {
            List {
                content
            }.listStyle(.grouped)
        }
    }
}
