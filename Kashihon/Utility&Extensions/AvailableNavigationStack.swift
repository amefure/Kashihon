//
//  AvailableNavigationStack.swift
//  Kashihon
//
//  Created by t&a on 2023/07/16.
//

import SwiftUI

struct AvailableNavigationStack<Content: View>: View {
    var content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                content
            }
        } else {
            NavigationView {
                content.navigationBarHidden(true)
            }
        }
    }
}
