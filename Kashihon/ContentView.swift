//
//  ContentView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/12.
//

import SwiftUI

struct ContentView: View {
    @State var selectTag: Int = 1

    var body: some View {
        AvailableNavigationStack {
            VStack {
                HStack {
                    Spacer()
                    Image("logo-name")
                        .resizable()
                        .frame(width: 130, height: 40)
                    Spacer()
                }
                Divider()

                TabView(selection: $selectTag) {
                    SearchBooksView().tag(1)

                    Text("LoanList").tag(2)

                    MyBookShelfView().tag(3)

                    SettingView().tag(4)
                }.tabViewStyle(.page)

                HStack {
                    Button {
                        selectTag = 1
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                    Button {
                        selectTag = 2
                    } label: {
                        Image(systemName: "book")
                    }
                    Button {
                        selectTag = 3
                    } label: {
                        Image(systemName: "books.vertical")
                    }
                    Button {
                        selectTag = 4
                    } label: {
                        Image(systemName: "gearshape")
                    }

                }.foregroundColor(.white)
                    .padding()
                    .frame(width: DeviceSizeViewModel().deviceWidth - 40)
                    .background(Color.thema1)
                    .opacity(0.8)
                    .cornerRadius(20)
                    .shadow(color: .gray, radius: 3, x: 4, y: 4)
                    .padding(.bottom, 30)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
