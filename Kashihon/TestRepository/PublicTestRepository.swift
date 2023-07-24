//
//  PublicTestRepository.swift
//  Kashihon
//
//  Created by t&a on 2023/07/24.
//

import SwiftyJSON
import UIKit

class PublicTestRepository: PublicRepositoryProtocol {
    public func getAPI(keyword _: String, completion: @escaping ([Book]?) -> Void) {
        let jsonData = String(demoJson).data(using: .utf8)!

        let json = try? JSON(data: jsonData)
        if json != nil {
            if json!["totalItems"] != 0 {
                completion(convertJsonToBook(json!))
            } else {
                completion(nil)
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

    private let demoJson: String = """
    {
    \"kind\": \"books#volumes\",
    \"totalItems\": 403,
    \"items\": [
    {
    \"kind\": \"books#volume\",
    \"id\": \"ohdDEAAAQBAJ\",
    \"etag\": \"YMpgnHcCkVI\",
    \"selfLink\": \"https://www.googleapis.com/books/v1/volumes/ohdDEAAAQBAJ\",
    \"volumeInfo\": {
    \"title\": \"SwiftUIで学ぶVisionフレームワーク入門\",
    \"authors\": [
    \"佐藤 剛士\"
    ],
    \"publisher\": \"インプレス NextPublishing\",
    \"publishedDate\": \"2021-09-27\",
    \"description\": \"Visionフレームワークは顔検出、文字認識、バーコード認識などの画像分析ができるAppleのフレームワークです。高度なコンピュータービジョンの知識を持っていなくてもシンプルに画像分析アプリを作ることができます。本書ではVisionフレームワークの概要から、実務で応用できる実装方法までをわかりやすく解説します。サンプルアプリでは、静止画像の画像分析や、カメラを使ったリアルタイム分析などをSwiftUIを使って作成しています。これから画像分析を始めたい方オススメです。 【目次】 第1章 SwiftUI概要 第2章 Visionフレームワーク概要 第3章 静止画像を分析 第4章 カメラ画像をトラッキング\",
    \"industryIdentifiers\": [
    {
    \"type\": \"ISBN_13\",
    \"identifier\": \"9784295600466\"
    },
    {
    \"type\": \"ISBN_10\",
    \"identifier\": \"4295600466\"
    }
    ],
    \"readingModes\": {
    \"text\": true,
    \"image\": true
    },
    \"pageCount\": 78,
    \"printType\": \"BOOK\",
    \"categories\": [
    \"Technology & Engineering\"
    ],
    \"maturityRating\": \"NOT_MATURE\",
    \"allowAnonLogging\": false,
    \"contentVersion\": \"0.3.3.0.preview.3\",
    \"panelizationSummary\": {
    \"containsEpubBubbles\": false,
    \"containsImageBubbles\": false
    },
    \"imageLinks\": {
    \"smallThumbnail\": \"http://books.google.com/books/content?id=ohdDEAAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api\",
    \"thumbnail\": \"http://books.google.com/books/content?id=ohdDEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api\"
    },
    \"language\": \"ja\",
    \"previewLink\": \"http://books.google.co.jp/books?id=ohdDEAAAQBAJ&printsec=frontcover&dq=SwiftUI&hl=&cd=1&source=gbs_api\",
    \"infoLink\": \"https://play.google.com/store/books/details?id=ohdDEAAAQBAJ&source=gbs_api\",
    \"canonicalVolumeLink\": \"https://play.google.com/store/books/details?id=ohdDEAAAQBAJ\"
    },
    \"saleInfo\": {
    \"country\": \"JP\",
    \"saleability\": \"FOR_SALE\",
    \"isEbook\": true,
    \"listPrice\": {
    \"amount\": 1980,
    \"currencyCode\": \"JPY\"
    },
    \"retailPrice\": {
    \"amount\": 1782,
    \"currencyCode\": \"JPY\"
    },
    \"buyLink\": \"https://play.google.com/store/books/details?id=ohdDEAAAQBAJ&rdid=book-ohdDEAAAQBAJ&rdot=1&source=gbs_api\",
    \"offers\": [
    {
    \"finskyOfferType\": 1,
    \"listPrice\": {
    \"amountInMicros\": 1980000000,
    \"currencyCode\": \"JPY\"
    },
    \"retailPrice\": {
    \"amountInMicros\": 1782000000,
    \"currencyCode\": \"JPY\"
    }
    }
    ]
    },
    \"accessInfo\": {
    \"country\": \"JP\",
    \"viewability\": \"PARTIAL\",
    \"embeddable\": true,
    \"publicDomain\": false,
    \"textToSpeechPermission\": \"ALLOWED\",
    \"epub\": {
    \"isAvailable\": true,
    \"acsTokenLink\": \"http://books.google.co.jp/books/download/SwiftUI%E3%81%A7%E5%AD%A6%E3%81%B6Vision%E3%83%95%E3%83%AC%E3%83%BC%E3%83%A0%E3%83%AF%E3%83%BC-sample-epub.acsm?id=ohdDEAAAQBAJ&format=epub&output=acs4_fulfillment_token&dl_type=sample&source=gbs_api\"
    },
    \"pdf\": {
    \"isAvailable\": true,
    \"acsTokenLink\": \"http://books.google.co.jp/books/download/SwiftUI%E3%81%A7%E5%AD%A6%E3%81%B6Vision%E3%83%95%E3%83%AC%E3%83%BC%E3%83%A0%E3%83%AF%E3%83%BC-sample-pdf.acsm?id=ohdDEAAAQBAJ&format=pdf&output=acs4_fulfillment_token&dl_type=sample&source=gbs_api\"
    },
    \"webReaderLink\": \"http://play.google.com/books/reader?id=ohdDEAAAQBAJ&hl=&source=gbs_api\",
    \"accessViewStatus\": \"SAMPLE\",
    \"quoteSharingAllowed\": false
    },
    \"searchInfo\": {
    \"textSnippet\": \"Visionフレームワークは顔検出、文字認識、バーコード認識などの画像分析ができるAppleのフレームワークです。高度なコンピュータービジョンの知識を持っていなくてもシンプル ...\"
    }
    },
    {
    \"kind\": \"books#volume\",
    \"id\": \"-exSzQEACAAJ\",
    \"etag\": \"Nn/wQvSGwk8\",
    \"selfLink\": \"https://www.googleapis.com/books/v1/volumes/-exSzQEACAAJ\",
    \"volumeInfo\": {
    \"title\": \"基礎から学ぶSwiftUI\",
    \"authors\": [
    \"林晃\"
    ],
    \"publishedDate\": \"2020-02\",
    \"description\": \"SwiftUIの入門に最適な1冊!短いコードで実際の機能を試しながらユーザーインターフェイスを作るためのフレームワーク「SwiftUI」が学べる!\",
    \"industryIdentifiers\": [
    {
    \"type\": \"ISBN_10\",
    \"identifier\": \"4863542992\"
    },
    {
    \"type\": \"ISBN_13\",
    \"identifier\": \"9784863542990\"
    }
    ],
    \"readingModes\": {
    \"text\": false,
    \"image\": false
    },
    \"pageCount\": 328,
    \"printType\": \"BOOK\",
    \"maturityRating\": \"NOT_MATURE\",
    \"allowAnonLogging\": false,
    \"contentVersion\": \"preview-1.0.0\",
    \"panelizationSummary\": {
    \"containsEpubBubbles\": false,
    \"containsImageBubbles\": false
    },
    \"imageLinks\": {
    \"smallThumbnail\": \"http://books.google.com/books/content?id=-exSzQEACAAJ&printsec=frontcover&img=1&zoom=5&source=gbs_api\",
    \"thumbnail\": \"http://books.google.com/books/content?id=-exSzQEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api\"
    },
    \"language\": \"ja\",
    \"previewLink\": \"http://books.google.co.jp/books?id=-exSzQEACAAJ&dq=SwiftUI&hl=&cd=2&source=gbs_api\",
    \"infoLink\": \"http://books.google.co.jp/books?id=-exSzQEACAAJ&dq=SwiftUI&hl=&source=gbs_api\",
    \"canonicalVolumeLink\": \"https://books.google.com/books/about/%E5%9F%BA%E7%A4%8E%E3%81%8B%E3%82%89%E5%AD%A6%E3%81%B6SwiftUI.html?hl=&id=-exSzQEACAAJ\"
    },
    \"saleInfo\": {
    \"country\": \"JP\",
    \"saleability\": \"NOT_FOR_SALE\",
    \"isEbook\": false
    },
    \"accessInfo\": {
    \"country\": \"JP\",
    \"viewability\": \"NO_PAGES\",
    \"embeddable\": false,
    \"publicDomain\": false,
    \"textToSpeechPermission\": \"ALLOWED\",
    \"epub\": {
    \"isAvailable\": false
    },
    \"pdf\": {
    \"isAvailable\": false
    },
    \"webReaderLink\": \"http://play.google.com/books/reader?id=-exSzQEACAAJ&hl=&source=gbs_api\",
    \"accessViewStatus\": \"NONE\",
    \"quoteSharingAllowed\": false
    },
    \"searchInfo\": {
    \"textSnippet\": \"SwiftUIの入門に最適な1冊!短いコードで実際の機能を試しながらユーザーインターフェイスを作るためのフレームワーク「SwiftUI」が学べる!\"
    }
    },
    {
    \"kind\": \"books#volume\",
    \"id\": \"zZrFDwAAQBAJ\",
    \"etag\": \"MvIsykHc+x8\",
    \"selfLink\": \"https://www.googleapis.com/books/v1/volumes/zZrFDwAAQBAJ\",
    \"volumeInfo\": {
    \"title\": \"SwiftUI 徹底入門\",
    \"authors\": [
    \"金田浩明\"
    ],
    \"publisher\": \"SBクリエイティブ\",
    \"publishedDate\": \"2019-12-20\",
    \"description\": \"iOS、macOSのアプリ開発を根底から変える ※この電子書籍は固定レイアウト型で配信されております。固定レイアウト型は文字だけを拡大することや、文字列のハイライト、検索、辞書の参照、引用などの機能が使用できません。 iOS、macOSのアプリ開発を根底から変えるSwiftUIとは何か SwiftUIはXcode 11から利用可能になった、iOS、macOSアプリケーションのUI作成のための新しいフレームワークです。Swift 5.1で導入された機能をフルに使って、ビューの配置を直感的に記述できるとともに、イベント処理の方法も根底から変更されています。また、Xcode 11では、新しいプレビュー機能により、エミュレータを起動しなくても動作確認ができたり、ビューの属性を変更するとそれがコードにされるなど、さまざまな改良が加えられています。 本書では、SwiftUIの基本から、アプリケーション開発の実際まで、サンプルを用いながらわかりやすく解説していきます。 対象読者： ・Swiftプログラミングの基礎は理解している人 ・UIKitによるiPhoneアプリケーション開発の経験者\",
    \"industryIdentifiers\": [
    {
    \"type\": \"ISBN_13\",
    \"identifier\": \"9784815604066\"
    },
    {
    \"type\": \"ISBN_10\",
    \"identifier\": \"4815604061\"
    }
    ],
    \"readingModes\": {
    \"text\": true,
    \"image\": true
    },
    \"pageCount\": 400,
    \"printType\": \"BOOK\",
    \"categories\": [
    \"Computers\"
    ],
    \"maturityRating\": \"NOT_MATURE\",
    \"allowAnonLogging\": false,
    \"contentVersion\": \"1.2.2.0.preview.3\",
    \"panelizationSummary\": {
    \"containsEpubBubbles\": false,
    \"containsImageBubbles\": false
    },
    \"imageLinks\": {
    \"smallThumbnail\": \"http://books.google.com/books/content?id=zZrFDwAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api\",
    \"thumbnail\": \"http://books.google.com/books/content?id=zZrFDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api\"
    },
    \"language\": \"ja\",
    \"previewLink\": \"http://books.google.co.jp/books?id=zZrFDwAAQBAJ&printsec=frontcover&dq=SwiftUI&hl=&cd=3&source=gbs_api\",
    \"infoLink\": \"https://play.google.com/store/books/details?id=zZrFDwAAQBAJ&source=gbs_api\",
    \"canonicalVolumeLink\": \"https://play.google.com/store/books/details?id=zZrFDwAAQBAJ\"
    },
    \"saleInfo\": {
    \"country\": \"JP\",
    \"saleability\": \"FOR_SALE\",
    \"isEbook\": true,
    \"listPrice\": {
    \"amount\": 3278,
    \"currencyCode\": \"JPY\"
    },
    \"retailPrice\": {
    \"amount\": 2950,
    \"currencyCode\": \"JPY\"
    },
    \"buyLink\": \"https://play.google.com/store/books/details?id=zZrFDwAAQBAJ&rdid=book-zZrFDwAAQBAJ&rdot=1&source=gbs_api\",
    \"offers\": [
    {
    \"finskyOfferType\": 1,
    \"listPrice\": {
    \"amountInMicros\": 3278000000,
    \"currencyCode\": \"JPY\"
    },
    \"retailPrice\": {
    \"amountInMicros\": 2950000000,
    \"currencyCode\": \"JPY\"
    }
    }
    ]
    },
    \"accessInfo\": {
    \"country\": \"JP\",
    \"viewability\": \"PARTIAL\",
    \"embeddable\": true,
    \"publicDomain\": false,
    \"textToSpeechPermission\": \"ALLOWED\",
    \"epub\": {
    \"isAvailable\": true,
    \"acsTokenLink\": \"http://books.google.co.jp/books/download/SwiftUI_%E5%BE%B9%E5%BA%95%E5%85%A5%E9%96%80-sample-epub.acsm?id=zZrFDwAAQBAJ&format=epub&output=acs4_fulfillment_token&dl_type=sample&source=gbs_api\"
    },
    \"pdf\": {
    \"isAvailable\": true,
    \"acsTokenLink\": \"http://books.google.co.jp/books/download/SwiftUI_%E5%BE%B9%E5%BA%95%E5%85%A5%E9%96%80-sample-pdf.acsm?id=zZrFDwAAQBAJ&format=pdf&output=acs4_fulfillment_token&dl_type=sample&source=gbs_api\"
    },
    \"webReaderLink\": \"http://play.google.com/books/reader?id=zZrFDwAAQBAJ&hl=&source=gbs_api\",
    \"accessViewStatus\": \"SAMPLE\",
    \"quoteSharingAllowed\": false
    },
    \"searchInfo\": {
    \"textSnippet\": \"iOS、macOSのアプリ開発を根底から変える ※この電子書籍は固定レイアウト型で配信されております。固定レイアウト型は文字だけを拡大することや、文字列のハイライト、検索、 ...\"
    }
    },
    {
    \"kind\": \"books#volume\",
    \"id\": \"dk-mzQEACAAJ\",
    \"etag\": \"GIltZEvgYkE\",
    \"selfLink\": \"https://www.googleapis.com/books/v1/volumes/dk-mzQEACAAJ\",
    \"volumeInfo\": {
    \"title\": \"SwiftUIではじめるiPhoneアプリプログラミング入門\",
    \"authors\": [
    \"大津真\"
    ],
    \"publishedDate\": \"2020-06\",
    \"description\": \"Xcode+SwiftUIでiPhoneアプリ開発の基礎を学ぶ。サンプルプログラムを確認しながら学べるのでわかりやすい。とにかくつくってみたい!という前向きな方に最適!JavaやPythonなど、オーソドックスな言語のプログラミング経験者が対象。Swiftの経験はなくても読みこなせるように、Swift言語のポイントも解説しています。SwiftUIの操作環境:macOS10.15(Catalina)以降、Xcodeバージョン11.4以降。\",
    \"industryIdentifiers\": [
    {
    \"type\": \"ISBN_10\",
    \"identifier\": \"4899775040\"
    },
    {
    \"type\": \"ISBN_13\",
    \"identifier\": \"9784899775041\"
    }
    ],
    \"readingModes\": {
    \"text\": false,
    \"image\": false
    },
    \"pageCount\": 319,
    \"printType\": \"BOOK\",
    \"maturityRating\": \"NOT_MATURE\",
    \"allowAnonLogging\": false,
    \"contentVersion\": \"preview-1.0.0\",
    \"panelizationSummary\": {
    \"containsEpubBubbles\": false,
    \"containsImageBubbles\": false
    },
    \"imageLinks\": {
    \"smallThumbnail\": \"http://books.google.com/books/content?id=dk-mzQEACAAJ&printsec=frontcover&img=1&zoom=5&source=gbs_api\",
    \"thumbnail\": \"http://books.google.com/books/content?id=dk-mzQEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api\"
    },
    \"language\": \"ja\",
    \"previewLink\": \"http://books.google.co.jp/books?id=dk-mzQEACAAJ&dq=SwiftUI&hl=&cd=4&source=gbs_api\",
    \"infoLink\": \"http://books.google.co.jp/books?id=dk-mzQEACAAJ&dq=SwiftUI&hl=&source=gbs_api\",
    \"canonicalVolumeLink\": \"https://books.google.com/books/about/SwiftUI%E3%81%A7%E3%81%AF%E3%81%98%E3%82%81%E3%82%8BiPhone%E3%82%A2%E3%83%97%E3%83%AA%E3%83%97.html?hl=&id=dk-mzQEACAAJ\"
    },
    \"saleInfo\": {
    \"country\": \"JP\",
    \"saleability\": \"NOT_FOR_SALE\",
    \"isEbook\": false
    },
    \"accessInfo\": {
    \"country\": \"JP\",
    \"viewability\": \"NO_PAGES\",
    \"embeddable\": false,
    \"publicDomain\": false,
    \"textToSpeechPermission\": \"ALLOWED\",
    \"epub\": {
    \"isAvailable\": false
    },
    \"pdf\": {
    \"isAvailable\": false
    },
    \"webReaderLink\": \"http://play.google.com/books/reader?id=dk-mzQEACAAJ&hl=&source=gbs_api\",
    \"accessViewStatus\": \"NONE\",
    \"quoteSharingAllowed\": false
    },
    \"searchInfo\": {
    \"textSnippet\": \"SwiftUIは、iOSアプリやmacOSアプリなどAppleデバイス用プログラム開発用のSwift言語によるフレームワークです。 ...\"
    }
    },
    {
    \"kind\": \"books#volume\",
    \"id\": \"o5EIEAAAQBAJ\",
    \"etag\": \"MDMkDaZVTWM\",
    \"selfLink\": \"https://www.googleapis.com/books/v1/volumes/o5EIEAAAQBAJ\",
    \"volumeInfo\": {
    \"title\": \"1人でアプリを作る人を支えるSwiftUI開発レシピ\",
    \"authors\": [
    \"佐藤 剛士\"
    ],
    \"publisher\": \"インプレスR&D\",
    \"publishedDate\": \"2020-11-20\",
    \"description\": \"SwiftUIとは、iPhoneアプリ開発で用いられる新しいUIフレームワークです。本書はSwiftUIでアプリをつくりたい方のために、レイアウトシステム、基本Viewの使い方、Combine、豊富で実践的なサンプルアプリを掲載。SwiftUIを使いこなして思いどおりのアプリをつくろう！最新のiOS 14,Xcode 12にも対応した内容です。 【目次】 第1章 SwiftUI概要 第2章 SwiftUIのレイアウトシステム 第3章 SwiftUIの座標空間 第4章 基本Viewの使い方 第5章 iOS 14新機能: App、Scene、WindowGroup 第6章 SwiftUIのデータ管理 第7章 Combine 第8章 レシピ：GitHubAPIリポジトリー検索アプリ 第9章 レシピ：お絵かきアプリ 第10章 レシピ：写真フィルターアプリ 第11章 iOS 14新機能: Widget\",
    \"readingModes\": {
    \"text\": true,
    \"image\": true
    },
    \"printType\": \"BOOK\",
    \"categories\": [
    \"Technology & Engineering\"
    ],
    \"maturityRating\": \"NOT_MATURE\",
    \"allowAnonLogging\": false,
    \"contentVersion\": \"1.1.1.0.preview.3\",
    \"panelizationSummary\": {
    \"containsEpubBubbles\": false,
    \"containsImageBubbles\": false
    },
    \"imageLinks\": {
    \"smallThumbnail\": \"http://books.google.com/books/content?id=o5EIEAAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api\",
    \"thumbnail\": \"http://books.google.com/books/content?id=o5EIEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api\"
    },
    \"language\": \"ja\",
    \"previewLink\": \"http://books.google.co.jp/books?id=o5EIEAAAQBAJ&printsec=frontcover&dq=SwiftUI&hl=&cd=5&source=gbs_api\",
    \"infoLink\": \"https://play.google.com/store/books/details?id=o5EIEAAAQBAJ&source=gbs_api\",
    \"canonicalVolumeLink\": \"https://play.google.com/store/books/details?id=o5EIEAAAQBAJ\"
    },
    \"saleInfo\": {
    \"country\": \"JP\",
    \"saleability\": \"FOR_SALE\",
    \"isEbook\": true,
    \"listPrice\": {
    \"amount\": 1980,
    \"currencyCode\": \"JPY\"
    },
    \"retailPrice\": {
    \"amount\": 1782,
    \"currencyCode\": \"JPY\"
    },
    \"buyLink\": \"https://play.google.com/store/books/details?id=o5EIEAAAQBAJ&rdid=book-o5EIEAAAQBAJ&rdot=1&source=gbs_api\",
    \"offers\": [
    {
    \"finskyOfferType\": 1,
    \"listPrice\": {
    \"amountInMicros\": 1980000000,
    \"currencyCode\": \"JPY\"
    },
    \"retailPrice\": {
    \"amountInMicros\": 1782000000,
    \"currencyCode\": \"JPY\"
    }
    }
    ]
    },
    \"accessInfo\": {
    \"country\": \"JP\",
    \"viewability\": \"PARTIAL\",
    \"embeddable\": true,
    \"publicDomain\": false,
    \"textToSpeechPermission\": \"ALLOWED\",
    \"epub\": {
    \"isAvailable\": true,
    \"acsTokenLink\": \"http://books.google.co.jp/books/download/1%E4%BA%BA%E3%81%A7%E3%82%A2%E3%83%97%E3%83%AA%E3%82%92%E4%BD%9C%E3%82%8B%E4%BA%BA%E3%82%92%E6%94%AF%E3%81%88%E3%82%8B-sample-epub.acsm?id=o5EIEAAAQBAJ&format=epub&output=acs4_fulfillment_token&dl_type=sample&source=gbs_api\"
    },
    \"pdf\": {
    \"isAvailable\": true,
    \"acsTokenLink\": \"http://books.google.co.jp/books/download/1%E4%BA%BA%E3%81%A7%E3%82%A2%E3%83%97%E3%83%AA%E3%82%92%E4%BD%9C%E3%82%8B%E4%BA%BA%E3%82%92%E6%94%AF%E3%81%88%E3%82%8B-sample-pdf.acsm?id=o5EIEAAAQBAJ&format=pdf&output=acs4_fulfillment_token&dl_type=sample&source=gbs_api\"
    },
    \"webReaderLink\": \"http://play.google.com/books/reader?id=o5EIEAAAQBAJ&hl=&source=gbs_api\",
    \"accessViewStatus\": \"SAMPLE\",
    \"quoteSharingAllowed\": false
    },
    \"searchInfo\": {
    \"textSnippet\": \"SwiftUIとは、iPhoneアプリ開発で用いられる新しいUIフレームワークです。本書はSwiftUIでアプリをつくりたい方のために、レイアウトシステム、基本Viewの使い方、Combine、豊富で実践 ...\"
    }
    },
    {
    \"kind\": \"books#volume\",
    \"id\": \"nN2CzwEACAAJ\",
    \"etag\": \"XacZebdFeYk\",
    \"selfLink\": \"https://www.googleapis.com/books/v1/volumes/nN2CzwEACAAJ\",
    \"volumeInfo\": {
    \"title\": \"SwiftUI開発レシピ\",
    \"subtitle\": \"1人でアプリを作る人を支える : iOSアプリ開発の新スタンダード!SwiftUIで思いどおりのアプリを作ろう!\",
    \"authors\": [
    \"佐藤剛士\"
    ],
    \"publishedDate\": \"2020-11-20\",
    \"description\": \"iOSアプリ開発の新スタンダード!SwiftUIで思いどおりのアプリを作成!iOS14、Xcode12対応。\",
    \"industryIdentifiers\": [
    {
    \"type\": \"ISBN_10\",
    \"identifier\": \"4844378678\"
    },
    {
    \"type\": \"ISBN_13\",
    \"identifier\": \"9784844378679\"
    }
    ],
    \"readingModes\": {
    \"text\": false,
    \"image\": false
    },
    \"pageCount\": 0,
    \"printType\": \"BOOK\",
    \"maturityRating\": \"NOT_MATURE\",
    \"allowAnonLogging\": false,
    \"contentVersion\": \"preview-1.0.0\",
    \"panelizationSummary\": {
    \"containsEpubBubbles\": false,
    \"containsImageBubbles\": false
    },
    \"imageLinks\": {
    \"smallThumbnail\": \"http://books.google.com/books/content?id=nN2CzwEACAAJ&printsec=frontcover&img=1&zoom=5&source=gbs_api\",
    \"thumbnail\": \"http://books.google.com/books/content?id=nN2CzwEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api\"
    },
    \"language\": \"ja\",
    \"previewLink\": \"http://books.google.co.jp/books?id=nN2CzwEACAAJ&dq=SwiftUI&hl=&cd=6&source=gbs_api\",
    \"infoLink\": \"http://books.google.co.jp/books?id=nN2CzwEACAAJ&dq=SwiftUI&hl=&source=gbs_api\",
    \"canonicalVolumeLink\": \"https://books.google.com/books/about/SwiftUI%E9%96%8B%E7%99%BA%E3%83%AC%E3%82%B7%E3%83%94.html?hl=&id=nN2CzwEACAAJ\"
    },
    \"saleInfo\": {
    \"country\": \"JP\",
    \"saleability\": \"NOT_FOR_SALE\",
    \"isEbook\": false
    },
    \"accessInfo\": {
    \"country\": \"JP\",
    \"viewability\": \"NO_PAGES\",
    \"embeddable\": false,
    \"publicDomain\": false,
    \"textToSpeechPermission\": \"ALLOWED\",
    \"epub\": {
    \"isAvailable\": false
    },
    \"pdf\": {
    \"isAvailable\": false
    },
    \"webReaderLink\": \"http://play.google.com/books/reader?id=nN2CzwEACAAJ&hl=&source=gbs_api\",
    \"accessViewStatus\": \"NONE\",
    \"quoteSharingAllowed\": false
    },
    \"searchInfo\": {
    \"textSnippet\": \"iOSアプリ開発の新スタンダード!SwiftUIで思いどおりのアプリを作成!iOS14、Xcode12対応。\"
    }
    },
    {
    \"kind\": \"books#volume\",
    \"id\": \"1hgAEAAAQBAJ\",
    \"etag\": \"5rfyI1Mvmtk\",
    \"selfLink\": \"https://www.googleapis.com/books/v1/volumes/1hgAEAAAQBAJ\",
    \"volumeInfo\": {
    \"title\": \"iOS/macOS UIフレームワーク SwiftUIプログラミング\",
    \"authors\": [
    \"掌田津耶乃\"
    ],
    \"publisher\": \"秀和システム\",
    \"publishedDate\": \"2020-05-30\",
    \"description\": \"※この商品はタブレットなど大きいディスプレイを備えた端末で読むことに適しています。また、文字だけを拡大することや、文字列のハイライト、検索、辞書の参照、引用などの機能が使用できません。 SwiftUIは、Swiftのために設計された、Swiftのための全く新しいUI開発用フレームワークです。従来のフレームワークの知識は役に立たないため、初心者もベテランも同じスタートラインに立つことになります。本書は、SwiftUIの基本からSwift独自のオブジェクト指向まで、188のサンプルプログラムを使いながらハンズオン形式で学ぶ入門書です。文法に不安がある人も、巻末の「Swift基礎文法入門」で復習すれば安心です。\",
    \"industryIdentifiers\": [
    {
    \"type\": \"OTHER\",
    \"identifier\": \"PKEY:BT000085281300100101900209\"
    }
    ],
    \"readingModes\": {
    \"text\": true,
    \"image\": true
    },
    \"printType\": \"BOOK\",
    \"categories\": [
    \"Computers\"
    ],
    \"maturityRating\": \"NOT_MATURE\",
    \"allowAnonLogging\": false,
    \"contentVersion\": \"preview-1.0.0\",
    \"panelizationSummary\": {
    \"containsEpubBubbles\": false,
    \"containsImageBubbles\": false
    },
    \"imageLinks\": {
    \"smallThumbnail\": \"http://books.google.com/books/content?id=1hgAEAAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api\",
    \"thumbnail\": \"http://books.google.com/books/content?id=1hgAEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api\"
    },
    \"language\": \"ja\",
    \"previewLink\": \"http://books.google.co.jp/books?id=1hgAEAAAQBAJ&printsec=frontcover&dq=SwiftUI&hl=&cd=7&source=gbs_api\",
    \"infoLink\": \"https://play.google.com/store/books/details?id=1hgAEAAAQBAJ&source=gbs_api\",
    \"canonicalVolumeLink\": \"https://play.google.com/store/books/details?id=1hgAEAAAQBAJ\"
    },
    \"saleInfo\": {
    \"country\": \"JP\",
    \"saleability\": \"FOR_SALE\",
    \"isEbook\": true,
    \"listPrice\": {
    \"amount\": 2772,
    \"currencyCode\": \"JPY\"
    },
    \"retailPrice\": {
    \"amount\": 2495,
    \"currencyCode\": \"JPY\"
    },
    \"buyLink\": \"https://play.google.com/store/books/details?id=1hgAEAAAQBAJ&rdid=book-1hgAEAAAQBAJ&rdot=1&source=gbs_api\",
    \"offers\": [
    {
    \"finskyOfferType\": 1,
    \"listPrice\": {
    \"amountInMicros\": 2772000000,
    \"currencyCode\": \"JPY\"
    },
    \"retailPrice\": {
    \"amountInMicros\": 2495000000,
    \"currencyCode\": \"JPY\"
    }
    }
    ]
    },
    \"accessInfo\": {
    \"country\": \"JP\",
    \"viewability\": \"PARTIAL\",
    \"embeddable\": true,
    \"publicDomain\": false,
    \"textToSpeechPermission\": \"ALLOWED\",
    \"epub\": {
    \"isAvailable\": true,
    \"acsTokenLink\": \"http://books.google.co.jp/books/download/iOS_macOS_UI%E3%83%95%E3%83%AC%E3%83%BC%E3%83%A0%E3%83%AF%E3%83%BC%E3%82%AF_SwiftU-sample-epub.acsm?id=1hgAEAAAQBAJ&format=epub&output=acs4_fulfillment_token&dl_type=sample&source=gbs_api\"
    },
    \"pdf\": {
    \"isAvailable\": true,
    \"acsTokenLink\": \"http://books.google.co.jp/books/download/iOS_macOS_UI%E3%83%95%E3%83%AC%E3%83%BC%E3%83%A0%E3%83%AF%E3%83%BC%E3%82%AF_SwiftU-sample-pdf.acsm?id=1hgAEAAAQBAJ&format=pdf&output=acs4_fulfillment_token&dl_type=sample&source=gbs_api\"
    },
    \"webReaderLink\": \"http://play.google.com/books/reader?id=1hgAEAAAQBAJ&hl=&source=gbs_api\",
    \"accessViewStatus\": \"SAMPLE\",
    \"quoteSharingAllowed\": false
    },
    \"searchInfo\": {
    \"textSnippet\": \"※この商品はタブレットなど大きいディスプレイを備えた端末で読むことに適しています。また、文字だけを拡大することや、文字列のハイライト、検索、辞書の参照、引用など ...\"
    }
    },
    {
    \"kind\": \"books#volume\",
    \"id\": \"k474zAEACAAJ\",
    \"etag\": \"bnYrgaLesto\",
    \"selfLink\": \"https://www.googleapis.com/books/v1/volumes/k474zAEACAAJ\",
    \"volumeInfo\": {
    \"title\": \"詳細!SwiftUI iPhoneアプリ開発入門ノート\",
    \"subtitle\": \"iOS13+Xcode11対応\",
    \"authors\": [
    \"大重美幸\"
    ],
    \"publishedDate\": \"2019-12\",
    \"description\": \"SwiftUIでアプリ開発がスピードアップ!新手法SwiftUIを全力で学ぶならこの1冊!今までやってきた人もこれから始める人も。SwiftUIを丁寧にやさしく解説。Swiftシンタックスの基礎知識も図解入りでしっかり学べます。\",
    \"industryIdentifiers\": [
    {
    \"type\": \"ISBN_10\",
    \"identifier\": \"480071253X\"
    },
    {
    \"type\": \"ISBN_13\",
    \"identifier\": \"9784800712530\"
    }
    ],
    \"readingModes\": {
    \"text\": false,
    \"image\": false
    },
    \"pageCount\": 336,
    \"printType\": \"BOOK\",
    \"maturityRating\": \"NOT_MATURE\",
    \"allowAnonLogging\": false,
    \"contentVersion\": \"preview-1.0.0\",
    \"panelizationSummary\": {
    \"containsEpubBubbles\": false,
    \"containsImageBubbles\": false
    },
    \"imageLinks\": {
    \"smallThumbnail\": \"http://books.google.com/books/content?id=k474zAEACAAJ&printsec=frontcover&img=1&zoom=5&source=gbs_api\",
    \"thumbnail\": \"http://books.google.com/books/content?id=k474zAEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api\"
    },
    \"language\": \"ja\",
    \"previewLink\": \"http://books.google.co.jp/books?id=k474zAEACAAJ&dq=SwiftUI&hl=&cd=8&source=gbs_api\",
    \"infoLink\": \"http://books.google.co.jp/books?id=k474zAEACAAJ&dq=SwiftUI&hl=&source=gbs_api\",
    \"canonicalVolumeLink\": \"https://books.google.com/books/about/%E8%A9%B3%E7%B4%B0_SwiftUI_iPhone%E3%82%A2%E3%83%97%E3%83%AA%E9%96%8B%E7%99%BA%E5%85%A5.html?hl=&id=k474zAEACAAJ\"
    },
    \"saleInfo\": {
    \"country\": \"JP\",
    \"saleability\": \"NOT_FOR_SALE\",
    \"isEbook\": false
    },
    \"accessInfo\": {
    \"country\": \"JP\",
    \"viewability\": \"NO_PAGES\",
    \"embeddable\": false,
    \"publicDomain\": false,
    \"textToSpeechPermission\": \"ALLOWED\",
    \"epub\": {
    \"isAvailable\": false
    },
    \"pdf\": {
    \"isAvailable\": false
    },
    \"webReaderLink\": \"http://play.google.com/books/reader?id=k474zAEACAAJ&hl=&source=gbs_api\",
    \"accessViewStatus\": \"NONE\",
    \"quoteSharingAllowed\": false
    },
    \"searchInfo\": {
    \"textSnippet\": \"SwiftUIでアプリ開発がスピードアップ!新手法SwiftUIを全力で学ぶならこの1冊!今までやってきた人もこれから始める人も。SwiftUIを丁寧にやさしく解説。Swiftシンタックスの基礎知識 ...\"
    }
    },
    {
    \"kind\": \"books#volume\",
    \"id\": \"wOx-zwEACAAJ\",
    \"etag\": \"vym4rEpVNEg\",
    \"selfLink\": \"https://www.googleapis.com/books/v1/volumes/wOx-zwEACAAJ\",
    \"volumeInfo\": {
    \"title\": \"詳細!SwiftUI iPhoneアプリ開発入門ノート[2022] iOS 16+Xcode 14対応\",
    \"authors\": [
    \"大重美幸\"
    ],
    \"publishedDate\": \"2022-11-14\",
    \"description\": \"Swift言語に精通したプログラミング界の重鎮・大重美幸氏が基礎からSwiftUIを使ったアプリ開発の実際までを詳細に解説。\",
    \"industryIdentifiers\": [
    {
    \"type\": \"ISBN_10\",
    \"identifier\": \"4800713129\"
    },
    {
    \"type\": \"ISBN_13\",
    \"identifier\": \"9784800713124\"
    }
    ],
    \"readingModes\": {
    \"text\": false,
    \"image\": false
    },
    \"pageCount\": 0,
    \"printType\": \"BOOK\",
    \"maturityRating\": \"NOT_MATURE\",
    \"allowAnonLogging\": false,
    \"contentVersion\": \"preview-1.0.0\",
    \"panelizationSummary\": {
    \"containsEpubBubbles\": false,
    \"containsImageBubbles\": false
    },
    \"imageLinks\": {
    \"smallThumbnail\": \"http://books.google.com/books/content?id=wOx-zwEACAAJ&printsec=frontcover&img=1&zoom=5&source=gbs_api\",
    \"thumbnail\": \"http://books.google.com/books/content?id=wOx-zwEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api\"
    },
    \"language\": \"ja\",
    \"previewLink\": \"http://books.google.co.jp/books?id=wOx-zwEACAAJ&dq=SwiftUI&hl=&cd=9&source=gbs_api\",
    \"infoLink\": \"http://books.google.co.jp/books?id=wOx-zwEACAAJ&dq=SwiftUI&hl=&source=gbs_api\",
    \"canonicalVolumeLink\": \"https://books.google.com/books/about/%E8%A9%B3%E7%B4%B0_SwiftUI_iPhone%E3%82%A2%E3%83%97%E3%83%AA%E9%96%8B%E7%99%BA%E5%85%A5.html?hl=&id=wOx-zwEACAAJ\"
    },
    \"saleInfo\": {
    \"country\": \"JP\",
    \"saleability\": \"NOT_FOR_SALE\",
    \"isEbook\": false
    },
    \"accessInfo\": {
    \"country\": \"JP\",
    \"viewability\": \"NO_PAGES\",
    \"embeddable\": false,
    \"publicDomain\": false,
    \"textToSpeechPermission\": \"ALLOWED\",
    \"epub\": {
    \"isAvailable\": false
    },
    \"pdf\": {
    \"isAvailable\": false
    },
    \"webReaderLink\": \"http://play.google.com/books/reader?id=wOx-zwEACAAJ&hl=&source=gbs_api\",
    \"accessViewStatus\": \"NONE\",
    \"quoteSharingAllowed\": false
    },
    \"searchInfo\": {
    \"textSnippet\": \"Swift言語に精通したプログラミング界の重鎮・大重美幸氏が基礎からSwiftUIを使ったアプリ開発の実際までを詳細に解説。\"
    }
    },
    {
    \"kind\": \"books#volume\",
    \"id\": \"ir_8DwAAQBAJ\",
    \"etag\": \"x2NC2Kke4JE\",
    \"selfLink\": \"https://www.googleapis.com/books/v1/volumes/ir_8DwAAQBAJ\",
    \"volumeInfo\": {
    \"title\": \"iOS/macOS UIﾌﾚｰﾑﾜｰｸSwiftUIﾌﾟﾛｸﾞﾗﾐﾝｸﾞ\",
    \"authors\": [
    \"掌田津耶乃\"
    ],
    \"publisher\": \"秀和システム\",
    \"publishedDate\": \"2020-05\",
    \"description\": \"新しいiOS/macOS用ユーザーインタフェース開発フレームワークSwiftUIの使い方をミニプログラム形式で学びます。\",
    \"industryIdentifiers\": [
    {
    \"type\": \"ISBN_13\",
    \"identifier\": \"9784798061931\"
    },
    {
    \"type\": \"ISBN_10\",
    \"identifier\": \"479806193X\"
    }
    ],
    \"readingModes\": {
    \"text\": false,
    \"image\": true
    },
    \"pageCount\": 449,
    \"printType\": \"BOOK\",
    \"maturityRating\": \"NOT_MATURE\",
    \"allowAnonLogging\": false,
    \"contentVersion\": \"0.0.1.0.preview.1\",
    \"panelizationSummary\": {
    \"containsEpubBubbles\": false,
    \"containsImageBubbles\": false
    },
    \"imageLinks\": {
    \"smallThumbnail\": \"http://books.google.com/books/content?id=ir_8DwAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api\",
    \"thumbnail\": \"http://books.google.com/books/content?id=ir_8DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api\"
    },
    \"language\": \"ja\",
    \"previewLink\": \"http://books.google.co.jp/books?id=ir_8DwAAQBAJ&pg=PA4&dq=SwiftUI&hl=&cd=10&source=gbs_api\",
    \"infoLink\": \"http://books.google.co.jp/books?id=ir_8DwAAQBAJ&dq=SwiftUI&hl=&source=gbs_api\",
    \"canonicalVolumeLink\": \"https://books.google.com/books/about/iOS_macOS_UI%EF%BE%8C%EF%BE%9A%EF%BD%B0%EF%BE%91%EF%BE%9C%EF%BD%B0%EF%BD%B8SwiftUI.html?hl=&id=ir_8DwAAQBAJ\"
    },
    \"saleInfo\": {
    \"country\": \"JP\",
    \"saleability\": \"NOT_FOR_SALE\",
    \"isEbook\": false
    },
    \"accessInfo\": {
    \"country\": \"JP\",
    \"viewability\": \"PARTIAL\",
    \"embeddable\": true,
    \"publicDomain\": false,
    \"textToSpeechPermission\": \"ALLOWED\",
    \"epub\": {
    \"isAvailable\": false
    },
    \"pdf\": {
    \"isAvailable\": true,
    \"acsTokenLink\": \"http://books.google.co.jp/books/download/iOS_macOS_UI%EF%BE%8C%EF%BE%9A%EF%BD%B0%EF%BE%91%EF%BE%9C%EF%BD%B0%EF%BD%B8SwiftUI-sample-pdf.acsm?id=ir_8DwAAQBAJ&format=pdf&output=acs4_fulfillment_token&dl_type=sample&source=gbs_api\"
    },
    \"webReaderLink\": \"http://play.google.com/books/reader?id=ir_8DwAAQBAJ&hl=&source=gbs_api\",
    \"accessViewStatus\": \"SAMPLE\",
    \"quoteSharingAllowed\": false
    },
    \"searchInfo\": {
    \"textSnippet\": \" Builderに置き換わる、新しいGUIデザイン機能です。といっても、「もっと使いやすいデザインツールができた」ということではありません。...\"
    }
    }
    ]
    }
    """
}
