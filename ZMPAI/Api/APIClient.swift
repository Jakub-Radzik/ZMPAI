import Foundation

protocol APIClientProtocol {
    func fetchBook(by id: String, completion: @escaping (Result<Book, Error>) -> Void)
    func fetchBooks(by genreId: Int, completion: @escaping (Result<[Book], Error>) -> Void)
}

class APIClient: APIClientProtocol {
    private let baseURL = "http://iosappapi.ddns.net:3111/books/"
    
    func fetchBook(by id: String, completion: @escaping (Result<Book, Error>) -> Void) {
        let urlString = "\(baseURL)\(id)/"
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            print(data)
            do {
                let book = try JSONDecoder().decode(Book.self, from: data)
                print(book)
                completion(.success(book))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
        
    func fetchBooks(by genreId: Int, completion: @escaping (Result<[Book], Error>) -> Void) {
        let urlString = "\(baseURL)genre/\(genreId)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let books = try JSONDecoder().decode([Book].self, from: data)
                completion(.success(books))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

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
