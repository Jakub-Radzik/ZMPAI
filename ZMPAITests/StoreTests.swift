import XCTest
@testable import ZMPAI

final class BookStoreTests: XCTestCase {
    var mockAPIClient: MockAPIClient!
    var bookStore: BookStore!
    
    override func setUp() {
        super.setUp()
        mockAPIClient = MockAPIClient()
        bookStore = BookStore(apiClient: mockAPIClient)
    }
    
    override func tearDown() {
        mockAPIClient = nil
        bookStore = nil
        super.tearDown()
    }
    
    func testFetchWeeklyBookSuccess() {
        let expectedBook = bookMock
        mockAPIClient.fetchBookResult = .success(expectedBook)
        
        bookStore.fetchWeeklyBook()
        
        XCTAssertEqual(bookStore.weeklyBook?.title, expectedBook.title)
        XCTAssertEqual(bookStore.weeklyBook?.author, expectedBook.author)
    }
    
    func testFetchWeeklyBookFailure() {
        mockAPIClient.fetchBookResult = .failure(NetworkError.noData)
        
        bookStore.fetchWeeklyBook()
        
        XCTAssertNil(bookStore.weeklyBook)
    }
    
    func testFetchBestBooksSuccess() {
        let expectedBooks = [bookMock, bookMock]
        mockAPIClient.fetchBooksResult = .success(expectedBooks)
        
        bookStore.fetchBestBooks()
        
        XCTAssertEqual(bookStore.bestBooks?.count, expectedBooks.count)
        XCTAssertEqual(bookStore.bestBooks?.first?.title, expectedBooks.first?.title)
    }
    
    func testFetchBestBooksFailure() {
        mockAPIClient.fetchBooksResult = .failure(NetworkError.decodingError)
        
        bookStore.fetchBestBooks()
        
        XCTAssertNil(bookStore.bestBooks)
    }
    
    func testRentBook() {
        let book = bookMock
        bookStore.rentBook(book)
        
        XCTAssertTrue(bookStore.myBooks.contains(where: { $0.id == book.id }))
        XCTAssertNotNil(bookStore.getProgress(for: book.id))
    }
    
    func testRentBookAlreadyRented() {
        let book = bookMock
        bookStore.rentBook(book)
        bookStore.rentBook(book)
        
        XCTAssertEqual(bookStore.myBooks.filter { $0.id == book.id }.count, 1)
    }
    
    func testUpdateCurrentChapter() {
        let bookId = UUID()
        bookStore.updateCurrentChapter(for: bookId, chapter: 5)
        
        XCTAssertEqual(bookStore.getProgress(for: bookId)?.currentChapter, 5)
    }
    
    func testUpdateScrollPosition() {
        let bookId = UUID()
        let position: Double = 0.8
        bookStore.updateScrollPosition(for: bookId, position: position)
        
        XCTAssertEqual(bookStore.getProgress(for: bookId)?.scrollPosition, position)
    }
    
    func testFetchBooksByGenreSuccess() {
        let genreId = 1
        let expectedBooks = [bookMock, bookMock]
        mockAPIClient.fetchBooksResult = .success(expectedBooks)
        
        let expectation = self.expectation(description: "Completion handler called")
        bookStore.fetchBooks(by: genreId) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertEqual(bookStore.books.count, expectedBooks.count)
    }
    
    func testFetchBooksByGenreFailure() {
        let genreId = 1
        mockAPIClient.fetchBooksResult = .failure(NetworkError.noData)
        
        let expectation = self.expectation(description: "Completion handler called")
        bookStore.fetchBooks(by: genreId) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertTrue(bookStore.books.isEmpty)
    }
}
