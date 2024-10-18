import XCTest

final class UserStory1UITest: XCTestCase {
    // END 2 END TEST
    func testUserStory1() throws {
        let app = XCUIApplication()
        app.launchArguments = ["-mockAPI"]
        app.launch()
        
        // Navigate to rented books
        let myBooks = app.tabBars.buttons["Twoje książki"]
        XCTAssertTrue(myBooks.waitForExistence(timeout: 5), "My books tab should exist")
        myBooks.tap()
        
        // Check if there is no rented books
        var listItems = app.descendants(matching: .cell)
        XCTAssertEqual(listItems.count, 0, "The book list should be empty")

        // Navigate to categories
        let categoriesTab = app.tabBars.buttons["Kategorie"]
        XCTAssertTrue(categoriesTab.waitForExistence(timeout: 5), "Categories tab should exist")
        categoriesTab.tap()
        
        // Choose category
        let fantasyCategory = app.buttons["Fantasy"]
        XCTAssertTrue(fantasyCategory.waitForExistence(timeout: 1), "We should be able to navigate to fantasy category")
        fantasyCategory.tap()
        
        // Choose Book
        let alice = app.buttons["Alice's Adventures in Wonderland"]
        XCTAssertTrue(alice.waitForExistence(timeout: 1), "We should be able see The Hobbit book")
        alice.tap()
        
        // Rent book
        let rentBook = app.buttons["rentBook"]
        XCTAssertTrue(rentBook.waitForExistence(timeout: 1), "We should be able to rent a book")
        rentBook.tap()
        
        // Check if book is rented
        let bookRented = app.buttons["Czytaj"]
        XCTAssertTrue(bookRented.waitForExistence(timeout: 1), "We should be able to see information that book is rented")
        bookRented.tap()
        
        // Go to the 50th page
        let nextPageButton = app.buttons["nextPageButton"]
        for _ in 1...3 {
            nextPageButton.tap()
        }
        
        let expectedText = "Strona 4/15"
        let pageText = app.staticTexts[expectedText]
        
        // Sprawdź, czy tekst jest widoczny
        XCTAssertTrue(pageText.exists, "Tekst '\(expectedText)' powinien być widoczny na ekranie.")
            
    }
}
