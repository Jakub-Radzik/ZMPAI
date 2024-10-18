import XCTest
@testable import ZMPAI

// UNIT TESTS OF API CLIENT
class APIClientTests: XCTestCase {
    var mockAPIClient: MockAPIClient!
    var bookStore: BookStore!
    
    override func setUp() {
        super.setUp()
        mockAPIClient = MockAPIClient()
        bookStore = BookStore(apiClient: mockAPIClient)
    }
    
    func testFetchBookSuccess() {
        let expectedBook = bookMock
        mockAPIClient.fetchBookResult = .success(expectedBook)
        
        mockAPIClient.fetchBook(by: "1") { result in
            switch result {
            case .success(let book):
                XCTAssertEqual(book.title, "The Pragmatic Programmer")
                XCTAssertEqual(book.author, "Andrew Hunt and David Thomas")
            case .failure:
                XCTFail("Expected success, got failure")
            }
        }
    }
    
    func testFetchBookFailure() {
        mockAPIClient.fetchBookResult = .failure(NetworkError.noData)
        
        mockAPIClient.fetchBook(by: "1") { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertEqual(error as? NetworkError, NetworkError.noData)
            }
        }
    }
    
    func testFetchBooksSuccess() {
        let expectedBooks = [
            bookMock,
            bookMock
        ]
        mockAPIClient.fetchBooksResult = .success(expectedBooks)
        
        mockAPIClient.fetchBooks(by: 1) { result in
            switch result {
            case .success(let books):
                XCTAssertEqual(books.count, 2)
                XCTAssertEqual(books.first?.title, "The Pragmatic Programmer")
            case .failure:
                XCTFail("Expected success, got failure")
            }
        }
    }
    
    func testFetchBooksFailure() {
        mockAPIClient.fetchBooksResult = .failure(NetworkError.decodingError)
        
        mockAPIClient.fetchBooks(by: 1) { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertEqual(error as? NetworkError, NetworkError.decodingError)
            }
        }
    }
}
