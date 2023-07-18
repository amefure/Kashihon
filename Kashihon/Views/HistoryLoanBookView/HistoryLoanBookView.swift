//
//  HistoryLoanBookView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/18.
//

import SwiftUI

struct HistoryLoanBookView: View {
    @ObservedObject var localRepositoryVM = LocalRepositoryViewModel.shared

    var body: some View {
        AvailableListPlaneStack {
            ForEach(localRepositoryVM.historys) { history in
                Text(history.title)
            }
        }.onAppear {
            localRepositoryVM.readAllLoanHistorys()
        }
    }
}
