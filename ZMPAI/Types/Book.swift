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
    case fantasy = "Fantasy" // 1
    case scienceFiction = "Science Fiction" // 2
    case technical = "Literatura techniczna" // 3
    
    var id: String { self.rawValue }
}


struct Book: Identifiable, Equatable, Codable {
    let id = UUID()
    let title: String
    let author: String
    let description: String
    let genre: String
    let image: String
    let rating: Int = 4
    let epubFile: String = ""
    let epubContent: String = ""
    var audioName: String?
    
    private enum CodingKeys: String, CodingKey {
        case title, author, description
        case genre = "genre_name"
        case image = "image_file", rating,  audioName = "audio_file_name" ,epubFile = "epub_file", epubContent = "epub_content"
    }
    
    init(title: String, author: String, description: String, genre: String, image: String, audioName: String? = nil) {
            self.title = title
            self.author = author
            self.description = description
            self.genre = genre
            self.image = image
            self.audioName = audioName
    }
    
    init(title: String, author: String, description: String, genre: String, image: String, pages: Int, progress: Int, audioName: String? = nil) {
            self.title = title
            self.author = author
            self.description = description
            self.genre = genre
            self.image = image
            self.audioName = audioName
    }
    
    init(title: String, author: String, description: String, genre: String, image: String, pages: Int, progress: Int, pageContents: [String], audioName: String? = nil) {
            self.title = title
            self.author = author
            self.description = description
            self.genre = genre
            self.image = image
            self.audioName = audioName
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
