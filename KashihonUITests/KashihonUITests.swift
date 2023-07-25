//
//  KashihonUITests.swift
//  KashihonUITests
//
//  Created by t&a on 2023/07/12.
//

import XCTest

final class KashihonUITests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Google Books Apiから「Swift」を検索しマッチした一番上の本を本棚に追加する
    func testRegisterBookShelf() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        app.buttons["books.vertical"].tap()
        app.buttons["本を検索して本棚に追加する"].tap()
        let isbnTextField = app.textFields["タイトル/著者/ISBN...で検索"]
        isbnTextField.tap()
        isbnTextField.typeText("Swift")
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        app.buttons["検索"].tap()
        sleep(3)
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 0).buttons["追加"].tap()
        app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["戻る"].tap()
        XCTAssertTrue(app.scrollViews.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .button).element(boundBy: 0).exists)
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    // 本棚の1番目の本を貸し出し中にする
    func testRegisterLoanFlag() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        app.buttons["books.vertical"].tap()
        app.scrollViews.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .button).element(boundBy: 0).tap()

        app.buttons["貸出する"].tap()

        let elementsQuery = app.scrollViews.otherElements
        let textField = elementsQuery.containing(.image, identifier: "タクシー").children(matching: .textField).element(boundBy: 0)
        textField.tap()
        textField.typeText("Jon")

        let memoTextField = elementsQuery.textFields["Memo"]
        memoTextField.tap()
        memoTextField.typeText("これはメモです")

        elementsQuery.buttons["貸し出す"].tap()
        app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["戻る"].tap()
        app.buttons["hand.wave.fill"].tap()
        XCTAssertTrue(true)

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
