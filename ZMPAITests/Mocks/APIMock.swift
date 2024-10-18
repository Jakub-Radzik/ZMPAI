import Foundation
@testable import ZMPAI

class MockAPIClient: APIClientProtocol {
    var fetchBookResult: Result<Book, Error>?
    var fetchBooksResult: Result<[Book], Error>?
    
    func fetchBook(by id: String, completion: @escaping (Result<Book, Error>) -> Void) {
        if let result = fetchBookResult {
            completion(result)
        }
    }
    
    func fetchBooks(by genreId: Int, completion: @escaping (Result<[Book], Error>) -> Void) {
        if let result = fetchBooksResult {
            completion(result)
        }
    }
}
