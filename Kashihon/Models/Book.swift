//
//  Book.swift
//  Kashihon
//
//  Created by t&a on 2023/07/14.
//

import UIKit

class Book: Identifiable {
    var id: String?
    var title: String?
    var authors: [String] = []
    var description: String?
    var ISBN_13:String?
    var pageCount: Int?
    var publishedDate: String?
    var thumbnailUrl: String?

}
