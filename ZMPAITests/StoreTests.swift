import XCTest
@testable import ZMPAI

final class ZMPAITests: XCTestCase {
    func testIncrementPage() throws {
        let book = Book(title: "The Pragmatic Programmer",
                        author: "Andrew Hunt and David Thomas",
                        description: "A guide to becoming a better programmer.",
                        genre: .technical,
                        image: "swift",
                        pages: 10,
                        progress: 2)
        
        let store = BookStore()
        store.myBooks = [book]

        store.incrementPage(for: book.id)

        let updatedBook = store.myBooks.first { $0.id == book.id }
        
        XCTAssertEqual(updatedBook?.progress, 3, "Book progress should be incremented by 1")
    }
    
    func testDecrementPage() throws {
        let book = Book(title: "The Pragmatic Programmer",
                        author: "Andrew Hunt and David Thomas",
                        description: "A guide to becoming a better programmer.",
                        genre: .technical,
                        image: "swift",
                        pages: 10,
                        progress: 9)
        
        let store = BookStore()
        store.myBooks = [book]

        store.decrementPage(for: book.id)

        let updatedBook = store.myBooks.first { $0.id == book.id }
        
        XCTAssertEqual(updatedBook?.progress, 8, "Book progress should be decremented by 1")
    }
}
