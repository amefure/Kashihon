//
//  SearchBooksViewModel.swift
//  Kashihon
//
//  Created by t&a on 2023/09/29.
//

import UIKit

class SearchBooksViewModel {
    private let networkConnectStatusManager = NetworkConnectStatusManager()
    private let publicRepositoryVM = PublicRepositoryViewModel()

    public var isNetwork: Bool {
        networkConnectStatusManager.getNetworkConnectStatus()
    }
}
