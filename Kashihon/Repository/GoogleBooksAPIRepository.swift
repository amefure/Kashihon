//
//  GoogleBooksAPIRepository.swift
//  Kashihon
//
//  Created by t&a on 2023/07/13.
//

import Alamofire
import SwiftyJSON
import UIKit

class GoogleBooksAPIRepository {
    private let preKeyword: String = "?q="
    private let apiUrl: String = "https://www.googleapis.com/books/v1/volumes"

    /// 日本語をエンコーディング
    private func getEncodingUrl(url: String) -> String {
        if let encurl = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            return encurl
        }
        return ""
    }

    public func getAPI(keyword: String, completion: @escaping ([Book]) -> Void) {
        let urlStr = apiUrl + preKeyword + keyword
        let encUrl = getEncodingUrl(url: urlStr)
        AF.request(encUrl).response { response in
            do {
                let json = try? JSON(data: response.data!)
                completion(self.convertJsonToBook(json!))
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    private func convertJsonToBook(_ json: JSON) -> [Book] {
        let items = json["items"].array!
        var books: [Book] = []
        for item in items {
            let bk = Book()
            bk.id = item["id"].stringValue
            bk.title = item["volumeInfo"]["title"].stringValue
            if let authors = item["volumeInfo"]["authors"].array {
                for author in authors {
                    bk.authors.append(author.stringValue)
                }
            }
            bk.desc = item["volumeInfo"]["description"].stringValue
            bk.ISBN_13 = item["volumeInfo"]["industryIdentifiers"][1]["identifier"].stringValue
            bk.pageCount = item["volumeInfo"]["pageCount"].int ?? 0
            bk.publishedDate = item["volumeInfo"]["publishedDate"].stringValue
            bk.thumbnailUrl = item["volumeInfo"]["imageLinks"]["thumbnail"].stringValue
            books.append(bk)
        }
        return books
    }
}
