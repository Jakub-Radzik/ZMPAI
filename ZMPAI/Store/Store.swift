import SwiftUI

class BookStore: ObservableObject {
    @Published var books: [Book] = []
    @Published var myBooks: [Book] = []
    
    @Published var weeklyBook: Book?
    @Published var bestBooks: [Book]?
    @Published var genreBooks: [Book] = []
    
    private let apiClient: APIClientProtocol
        
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
        fetchWeeklyBook()
        fetchBestBooks()
    }
    
    func fetchWeeklyBook() {
        let bookId = "be9750b5-506e-443c-bd39-3156e1a1b7b3";
        
        apiClient.fetchBook(by: bookId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let book):
                    print(result)
                    print(book)
                    self.weeklyBook = book
                case .failure(let error):
                    print(result)
                    print("Error fetching weekly book: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func fetchBestBooks() {
        apiClient.fetchBooks(by: 1) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let books):
                    self.bestBooks = books
                case .failure(let error):
                    print("Error fetching weekly book: \(error.localizedDescription)")
                }
            }
        }
    }
    

    func fetchBooks(by genreId: Int, completion: @escaping () -> Void) {
            apiClient.fetchBooks(by: genreId) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let fetchedBooks):
                        self?.books = fetchedBooks
                    case .failure(let error):
                        print("Error fetching books: \(error.localizedDescription)")
                    }
                    completion()
                }
            }
        }

    
    
    func rentBook(_ book: Book) {
        guard !isRented(bookId: book.id) else { return }
        myBooks.append(book)
        
        print(book.id, book.title)
        if bookProgressMap[book.id] == nil {
            bookProgressMap[book.id] = BookProgress(currentChapter: 0, scrollPosition: 0.0)
        }
    }
    
    func booksForGenre(genre: Genre) {
            let genreId: Int
            switch genre {
            case .fantasy:
                genreId = 1
            case .scienceFiction:
                genreId = 2
            case .technical:
                genreId = 3
            }
            
            apiClient.fetchBooks(by: genreId) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let books):
                        self.genreBooks = books
                    case .failure(let error):
                        print("Error fetching books for genre \(genre.rawValue): \(error.localizedDescription)")
                    }
                }
            }
        }
    
    func isRented(bookId: UUID) -> Bool {
        return myBooks.contains(where: { $0.id == bookId })
    }
    
    func getBookProgress(for bookId: UUID) -> Int? {
        return 10
    }
    
    //PROGRESS NEW
    @Published var bookProgressMap: [UUID: BookProgress] = [:]
        
    // Update the current chapter for a given bookId
    func updateCurrentChapter(for bookId: UUID, chapter: Int) {
        if var progress = bookProgressMap[bookId] {
            progress.currentChapter = chapter
            bookProgressMap[bookId] = progress
        } else {
            bookProgressMap[bookId] = BookProgress(currentChapter: chapter, scrollPosition: 0.0)
        }
        print(bookProgressMap)
    }
    
    // Update the scroll position for a given bookId
    func updateScrollPosition(for bookId: UUID, position: Double) {
        if var progress = bookProgressMap[bookId] {
            progress.scrollPosition = position
            bookProgressMap[bookId] = progress
        } else {
            bookProgressMap[bookId] = BookProgress(currentChapter: 0, scrollPosition: position)
        }
        print(bookProgressMap)
    }
    
    // Retrieve progress for a given bookId
    func getProgress(for bookId: UUID) -> BookProgress? {
        return bookProgressMap[bookId]
    }

}
