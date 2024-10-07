import Foundation

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

enum Genre: String, CaseIterable, Identifiable {
    case fantasy = "Fantastyka"
    case scienceFiction = "Science Fiction"
    case technical = "Literatura techniczna"
    
    var id: String { self.rawValue }
}


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
            self.pageContents = Book.generateRandomPageContents(count: 100)
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
            self.pageContents = Book.generateRandomPageContents(count: pages)
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
