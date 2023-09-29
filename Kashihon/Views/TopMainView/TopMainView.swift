//
//  ContentView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/12.
//

import SwiftUI

struct TopMainView: View {
    @State var selectTag: Int = 2

    init() {
        UITableView.appearance().backgroundColor = .clear
        UINavigationBar.appearance().tintColor = UIColor(Color.thema4)
    }

    var body: some View {
        AvailableNavigationStack {
            VStack(spacing: 0) {
                HeaderView()

                if selectTag == 1 {
                    OnLoanListView()
                } else if selectTag == 2 {
                    MyBookShelfView()
                } else {
                    SettingView()
                }

                TabIconBarView(selectTag: $selectTag)

                AdMobBannerView().frame(height: 60)
            }
        }.tint(Color.thema4)
            .ignoresSafeArea(.keyboard)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TopMainView()
    }
}
