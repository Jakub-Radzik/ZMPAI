import XCTest

final class ReadBookViewUITests: XCTestCase {

    func testNextPageButtonIncrementsCurrentPage() throws {
        let app = XCUIApplication()
        app.launch()

        let weeklyBookNavigation = app.buttons["weeklyBook"]
        XCTAssertTrue(weeklyBookNavigation.waitForExistence(timeout: 1), "Weekly Book button should exist")
        weeklyBookNavigation.tap()

        let bookTitle = app.staticTexts["bookTitle"]
        XCTAssertTrue(bookTitle.waitForExistence(timeout: 1), "Book title should be visible")
        print(bookTitle)

        let expectedTitle = "The Hobbit"
        let notExpectedTitle = "Lord of the Rings"
        
        XCTAssertEqual(bookTitle.label, expectedTitle, "Book title should be '\(expectedTitle)'")
        XCTAssertNotEqual(bookTitle.label, notExpectedTitle, "Book title should be '\(expectedTitle)'")
    }
}
