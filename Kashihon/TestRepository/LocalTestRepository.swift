//
//  LocalTestRepository.swift
//  Kashihon
//
//  Created by t&a on 2023/07/24.
//

import RealmSwift
import UIKit

class LocalTestRepository: LocalRepositoryProtocol {
    private var demoBooks: [Book] = []
    private var demoHistory: [LoanHistory] = []

    public func createBook(_ book: Book) {
        demoBooks.append(book)
    }

    public func readAllBooks() -> [Book] {
        demoBooks
    }

    public func updateBookOnLoan(name: String, memo: String, date: Date, book: Book) {
        if let index = demoBooks.firstIndex(where: { $0.id == book.id }) {
            if demoBooks[index].OnLoan == false {
                demoBooks[index].loanName = name
                demoBooks[index].loanMemo = memo
                demoBooks[index].loanDate = date
            }
            demoBooks[index].OnLoan.toggle()
        }
    }

    public func updateBookMemo(memo: String, book: Book) {
        if let index = demoBooks.firstIndex(where: { $0.id == book.id }) {
            demoBooks[index].bookMemo = memo
        }
    }

    public func deleteBook(book: Book) {
        demoBooks.removeAll(where: { $0.id == book.id })
    }

    public func deleteAllBooks() {
        demoBooks.removeAll()
    }

    public func createLoanHistory(_ history: LoanHistory) {
        demoHistory.append(history)
    }

    public func readAllLoanHistorys() -> [LoanHistory] {
        demoHistory
    }

    public func deleteAllLoanHistorys() {
        demoHistory.removeAll()
    }

    // MARK: -  以下デモデータ格納用

    init() {
        registerDemoData()
    }

    // Bookインスタンス1つの格納メソッド
    private func localCreateBook(id: String, title: String, authors: List<String>, desc: String, ISBN: String, pageCount: Int, publishedDate: String, thumbnailUrl: String, loanName: String, loanDate: Date, OnLoan: Bool, loanMemo: String, bookMemo: String) {
        let book = Book()
        book.id = id
        book.title = title
        book.authors = authors
        book.desc = desc
        book.ISBN_13 = ISBN
        book.pageCount = pageCount
        book.publishedDate = publishedDate
        book.thumbnailUrl = thumbnailUrl
        book.loanName = loanName
        book.loanDate = loanDate
        book.OnLoan = OnLoan
        book.loanMemo = loanMemo
        book.bookMemo = bookMemo
        createBook(book)
    }

    // Book情報を格納メソッド
    private func registerDemoData() {
        let list1 = RealmSwift.List<String>()
        list1.append("かがくいひろし")

        let list2 = RealmSwift.List<String>()
        list2.append("金田浩明")

        let list3 = RealmSwift.List<String>()
        list3.append("恩田陸")

        let list4 = RealmSwift.List<String>()

        localCreateBook(
            id: "hWqLSgAACAAJ",
            title: "だるまさんが",
            authors: list1,
            desc: "「だ・る・ま・さ・ん・が...」左右にうごくだるまさん。「だるまさん」シリーズ第1弾です。",
            ISBN: "9784893095015",
            pageCount: 24,
            publishedDate: "2010-05",
            thumbnailUrl: "http://books.google.com/books/content?id=hWqLSgAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api",
            loanName: "川本　依ちゃん",
            loanDate: Date(),
            OnLoan: true,
            loanMemo: "",
            bookMemo: ""
        )

        localCreateBook(
            id: "zZrFDwAAQBAJ",
            title: "SwiftUI 徹底入門",
            authors: list2,
            desc: "iOS、macOSのアプリ開発を根底から変える ※この電子書籍は固定レイアウト型で配信されております。固定レイアウト型は文字だけを拡大することや、文字列のハイライト、検索、辞書の参照、引用などの機能が使用できません。 iOS、macOSのアプリ開発を根底から変えるSwiftUIとは何か SwiftUIはXcode 11から利用可能になった、iOS、macOSアプリケーションのUI作成のための新しいフレームワークです。Swift 5.1で導入された機能をフルに使って、ビューの配置を直感的に記述できるとともに、イベント処理の方法も根底から変更されています。また、Xcode 11では、新しいプレビュー機能により、エミュレータを起動しなくても動作確認ができたり、ビューの属性を変更するとそれがコードにされるなど、さまざまな改良が加えられています。 本書では、SwiftUIの基本から、アプリケーション開発の実際まで、サンプルを用いながらわかりやすく解説していきます。 対象読者： ・Swiftプログラミングの基礎は理解している人 ・UIKitによるiPhoneアプリケーション開発の経験者;",
            ISBN: "4815604061",
            pageCount: 400,
            publishedDate: "2019-12-20",
            thumbnailUrl: "http://books.google.com/books/content?id=zZrFDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api",
            loanName: "中川　健太",
            loanDate: Date(),
            OnLoan: true,
            loanMemo: "",
            bookMemo: ""
        )
        localCreateBook(
            id: "Rg4cxAEACAAJ",
            title: "蜜蜂と遠雷",
            authors: list3,
            desc: "近年その覇者が音楽界の寵児となる芳ヶ江国際ピアノコンクール。自宅に楽器を持たない少年・風間塵16歳。かつて天才少女としてデビューしながら突然の母の死以来、弾けなくなった栄伝亜夜20歳。楽器店勤務のサラリーマン・高島明石28歳。完璧な技術と音楽性の優勝候補マサル19歳。天才たちによる、競争という名の自らとの闘い。その火蓋が切られた。",
            ISBN: "9784344428522",
            pageCount: 454,
            publishedDate: "2019-04-10",
            thumbnailUrl: "http://books.google.com/books/content?id=Rg4cxAEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api",
            loanName: "",
            loanDate: Date(),
            OnLoan: false,
            loanMemo: "",
            bookMemo: ""
        )

        localCreateBook(
            id: "XedxPgAACAAJ",
            title: "しましまぐるぐる",
            authors: list4,
            desc: "あかちゃんが大好きなしましまとぐるぐる模様を、2ヶ月児でも見やすいコントラストの強い配色にデザインしたベイビーブック。",
            ISBN: "9784052031113",
            pageCount: 0,
            publishedDate: "2009-04",
            thumbnailUrl: "http://books.google.com/books/content?id=XedxPgAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api",
            loanName: "",
            loanDate: Date(),
            OnLoan: false,
            loanMemo: "",
            bookMemo: ""
        )
    }
}
