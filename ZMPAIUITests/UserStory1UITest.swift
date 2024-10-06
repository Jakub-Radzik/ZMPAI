import XCTest

final class UserStory1UITest: XCTestCase {
    
    func testUserStory1() throws {
        let app = XCUIApplication()
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
        let fantasyCategory = app.buttons["Fantastyka"]
        XCTAssertTrue(fantasyCategory.waitForExistence(timeout: 1), "We should be able to navigate to fantasy category")
        fantasyCategory.tap()
        
        // Choose Book
        let hobbitBook = app.buttons["The Hobbit"]
        XCTAssertTrue(hobbitBook.waitForExistence(timeout: 1), "We should be able see The Hobbit book")
        hobbitBook.tap()
        
        // Rent book
        let rentBook = app.buttons["rentBook"]
        XCTAssertTrue(rentBook.waitForExistence(timeout: 1), "We should be able to rent a book")
        rentBook.tap()
        
        // Check if book is rented
        let bookRented = app.staticTexts["Książka wypożyczona"]
        XCTAssertTrue(bookRented.waitForExistence(timeout: 1), "We should be able to see information that book is rented")
        
        // Navigate to rented books
        myBooks.tap()
        listItems = app.descendants(matching: .cell)
        XCTAssertEqual(listItems.count, 1, "The book list should be empty")
        
        // Read rented book
        let firstBook = app.cells.firstMatch
        XCTAssertTrue(firstBook.exists, "The first book in the list should exist")
        firstBook.tap()
        
        // Go to the 50th page
        let nextPageButton = app.buttons["nextPageButton"]
        for _ in 1...49 {
            nextPageButton.tap()
        }
        
        let currentPageText = app.staticTexts["pageText"]
        XCTAssertTrue(currentPageText.exists, "Page Text should exist")
        XCTAssertEqual(currentPageText.label, "Strona 50 / 100", "Page text should match the expected value after 49 taps")
    }
}
