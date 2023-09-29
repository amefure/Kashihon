//
//  PublicRepositoryViewModel.swift
//  Kashihon
//
//  Created by t&a on 2023/07/24.
//

import UIKit

class PublicRepositoryViewModel {
    private let googleBooksAPIRepository = GoogleBooksAPIRepository()

    public func getAPI(keyword: String, completion: @escaping ([Book]?) -> Void) {
        googleBooksAPIRepository.getAPI(keyword: keyword) { result in
            completion(result)
        }
    }
}
