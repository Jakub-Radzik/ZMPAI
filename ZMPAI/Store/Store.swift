import SwiftUI

enum Genre: String, CaseIterable, Identifiable {
    case fantasy = "Fantastyka"
    case scienceFiction = "Science Fiction"
    case technical = "Literatura techniczna"
    
    var id: String { self.rawValue }
}

let contents = [
    """
    In a far away land, there lived a dragon that protected the village from invaders. The dragon had the wisdom of the ancients...
    """,
    """
    The secrets of the universe are hidden in plain sight, but only those with the patience to look can uncover them. Many have tried...
    """,
    """
    A programmer sat hunched over his laptop, the code dancing before his eyes. Bugs kept appearing like ghosts in the night...
    """,
    """
    Long ago, the kingdoms of men and elves fought side by side against the darkness. Legends speak of a time when magic...
    """,
    """
    As the astronaut floated through the endless void, thoughts of home became increasingly distant. Would they ever return...
    """
]

struct Book: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let author: String
    let description: String
    let genre: Genre
    let image: String
    let rating: Int = 4
    let pages: Int
    let pageContents: [String]
    
    private var _progress: Int = 1
    var progress: Int {
        get {
            return _progress
        }
        set {
            if newValue >= 0 && newValue <= pages {
                _progress = newValue
            } else if newValue > pages {
                _progress = pages
            } else {
                _progress = 0
            }
        }
    }
    
    var audioName: String?
    
    init(title: String, author: String, description: String, genre: Genre, image: String, audioName: String? = nil) {
            self.title = title
            self.author = author
            self.description = description
            self.genre = genre
            self.image = image
            self.audioName = audioName
            self.pages = 100
            self.pageContents = Book.generateRandomPageContents(count: 5)
            self.progress = 0
    }
    
    init(title: String, author: String, description: String, genre: Genre, image: String, pages: Int, progress: Int, audioName: String? = nil) {
            self.title = title
            self.author = author
            self.description = description
            self.genre = genre
            self.image = image
            self.audioName = audioName
            self.pages = pages
            self.pageContents = Book.generateRandomPageContents(count: 5)
            self.progress = progress
    }
    
    init(title: String, author: String, description: String, genre: Genre, image: String, pages: Int, progress: Int, pageContents: [String], audioName: String? = nil) {
            self.title = title
            self.author = author
            self.description = description
            self.genre = genre
            self.image = image
            self.audioName = audioName
            self.pages = pages
            self.pageContents = pageContents
            self.progress = progress
    }
    
    private static func generateRandomPageContents(count: Int) -> [String] {
        var randomPages: [String] = []
        for index in 0..<count {
            if let randomContent = contents.randomElement() {
                let pageNumber = index
                let pageContent = "Page \(pageNumber): " + randomContent + randomContent + randomContent + randomContent + randomContent + randomContent + randomContent + randomContent + randomContent + randomContent + randomContent + randomContent + randomContent
                randomPages.append(pageContent)
            }
        }
        return randomPages
    }

    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.title == rhs.title && lhs.author == rhs.author
    }
}

class BookStore: ObservableObject {
    @Published var books: [Book] = [
        Book(title: "The Hobbit", author: "J.R.R. Tolkien", description: "A fantasy novel about the adventures of Bilbo Baggins.", genre: .fantasy, image: "hobbit"),
        Book(title: "Harry Potter and the Sorcerer's Stone", author: "J.K. Rowling", description: "The first book in the Harry Potter series.", genre: .fantasy, image: "hp_1"),
        Book(title: "A Song of Ice and Fire", author: "George R.R. Martin", description: "A series of epic fantasy novels.", genre: .fantasy, image: "song_ice_fire"),
        Book(title: "The Name of the Wind", author: "Patrick Rothfuss", description: "A fantasy novel about a young man's journey.", genre: .fantasy, image: "name_of_wind"),
        Book(title: "Mistborn: The Final Empire", author: "Brandon Sanderson", description: "A unique take on the fantasy genre.", genre: .fantasy, image: "final_empire"),
        Book(title: "Lord of the rings: The Fellowship of the ring", author: "J.R.R. Tolkien", description: "A fantasy novel about the adventures of Frodo Baggins.", genre: .fantasy, image: "lotr_1", audioName: "lotr_1_audio"),
        
        Book(title: "Dune", author: "Frank Herbert", description: "A science fiction novel about politics and power on the desert planet Arrakis.", genre: .scienceFiction, image: "dune"),
        Book(title: "Neuromancer", author: "William Gibson", description: "A cyberpunk novel that helped define the genre.", genre: .scienceFiction, image: "neuromancer"),
        Book(title: "Foundation", author: "Isaac Asimov", description: "A science fiction series that explores the future of humanity.", genre: .scienceFiction, image: "foundation"),
        Book(title: "Snow Crash", author: "Neal Stephenson", description: "A fast-paced cyberpunk novel.", genre: .scienceFiction, image: "snow_crash"),
        Book(title: "The Martian", author: "Andy Weir", description: "A gripping tale of survival on Mars.", genre: .scienceFiction, image: "the_martian"),
        
        Book(title: "Clean Code", author: "Robert C. Martin", description: "A handbook of agile software craftsmanship.", genre: .technical, image: "clean_code"),
        Book(title: "Design Patterns: Elements of Reusable Object-Oriented Software", author: "Erich Gamma et al.", description: "A book on software design patterns.", genre: .technical, image: "design_patterns"),
        Book(title: "The Pragmatic Programmer", author: "Andrew Hunt and David Thomas", description: "A guide to becoming a better programmer.", genre: .technical, image: "pragmatic"),
        Book(title: "Introduction to Algorithms", author: "Thomas H. Cormen et al.", description: "A comprehensive textbook on algorithms.", genre: .technical, image: "intro"),
        Book(title: "You Don't Know JS", author: "Kyle Simpson", description: "An in-depth series on JavaScript.", genre: .technical, image: "you_dont_know_js")
    ]
    @Published var myBooks: [Book] = []
    
    @Published var fontSize: CGFloat = 16
    
    @Published var weeklyBook: Book?
    @Published var bestBooks: [Book] = []
    
    init() {
        self.weeklyBook = books.first
        self.bestBooks = Array(books[1..<8]) 
    }
    
    
    func rentBook(_ book: Book) {
            guard !isRented(bookId: book.id) else { return }
            myBooks.append(book)
        }
    
    func booksForGenre(_ genre: Genre) -> [Book] {
            return books.filter { $0.genre == genre }
    }
    
    func incrementPage(for bookId: UUID) {
        if let index = myBooks.firstIndex(where: { $0.id == bookId }) {
            if myBooks[index].progress < myBooks[index].pages {
                myBooks[index].progress += 1
            }
        }
    }

    func decrementPage(for bookId: UUID) {
        if let index = myBooks.firstIndex(where: { $0.id == bookId }) {
            if myBooks[index].progress > 0 {
                myBooks[index].progress -= 1
            }
        }
    }

    func isRented(bookId: UUID) -> Bool {
            return myBooks.contains(where: { $0.id == bookId })
        }
}
