//
//  MyBookShelfViewModel.swift
//  Kashihon
//
//  Created by t&a on 2023/09/28.
//

import SwiftUI

class MyBookShelfViewModel: ObservableObject {
    @Published var editSortMode: EditMode = .inactive

    public func onSortMode() {
        editSortMode = .active
    }

    public func offSortMode() {
        editSortMode = .inactive
    }
}
