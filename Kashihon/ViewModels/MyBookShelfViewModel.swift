//
//  MyBookShelfViewModel.swift
//  Kashihon
//
//  Created by t&a on 2023/09/28.
//

import SwiftUI

class MyBookShelfViewModel {
    private let deviceSizeManager = DeviceSizeManager()
    private let userDefaultsManager = UserDefaultsManager()
    private let imageFileManager = ImageFileManager()
    private let localRepositoryVM = LocalRepositoryViewModel.shared

    public var isSESize: Bool {
        deviceSizeManager.isSESize
    }

    public var isiPadSize: Bool {
        deviceSizeManager.isiPadSize
    }

    public var deviceWidth: CGFloat {
        deviceSizeManager.deviceWidth
    }

    public var columns: [GridItem] {
        let deviceSizeManager = DeviceSizeManager()
        if deviceSizeManager.isiPadSize {
            return Array(repeating: GridItem(.fixed(deviceSizeManager.deviceWidth / 8 - 20)), count: 8)
        } else {
            return Array(repeating: GridItem(.fixed(deviceSizeManager.deviceWidth / 4 - 20)), count: 4)
        }
    }

    public func migration() {
        if userDefaultsManager.getMigration() == MigrationInfo.PRE_MIGRATION_VERSION {
            localRepositoryVM.migrationSetOrder()
            userDefaultsManager.setMigration()
        }
    }

    public func getThumbnailImage(_ book: Book) -> Image {
        imageFileManager.loadImage(urlStr: book.secureThumbnailUrl!.absoluteString)
    }
}

// MyBookShelfViewの並び替え用
struct DropViewDelegate: DropDelegate {
    var item: Book
    var viewModel: LocalRepositoryViewModel

    func performDrop(info _: DropInfo) -> Bool {
        true
    }

    func dropEntered(info _: DropInfo) {
        // from
        let fromIndex = viewModel.books.firstIndex { item -> Bool in
            item.id == viewModel.currentBook?.id
        } ?? 0

        // to
        let toIndex = viewModel.books.firstIndex { item -> Bool in
            item.id == self.item.id
        } ?? 0

        if fromIndex != toIndex {
            withAnimation(.default) {
                viewModel.changeOrder(viewModel.currentBook, source: fromIndex, destination: toIndex)
            }
        }
    }

    func dropUpdated(info _: DropInfo) -> DropProposal? {
        DropProposal(operation: .move)
    }
}
