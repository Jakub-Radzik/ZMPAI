import SwiftUI

struct BooksView: View {
    @EnvironmentObject var bookStore: BookStore
    let categoryName: Genre
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading books...")
            } else if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            } else {
                CardView(
                    books: bookStore.books,
                    title: categoryName.rawValue
                )
            }
        }
        .onAppear {
            fetchBooksForSelectedGenre()
        }
        .navigationTitle(categoryName.rawValue)
    }

    private func fetchBooksForSelectedGenre() {
        isLoading = true
        errorMessage = nil

        let genreId: Int
        switch categoryName {
        case .fantasy:
            genreId = 1
        case .scienceFiction:
            genreId = 2
        case .technical:
            genreId = 3
        }

        bookStore.fetchBooks(by: genreId) {
            isLoading = false
        }
    }
}

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        let bookStore = BookStore()
        
        bookStore.books = [
            Book(title: "Clean Code", author: "Robert C. Martin", description: "A handbook of agile software craftsmanship.", genre: "Literatura techniczna", epubFile: "", image: "you_dont_know_js"),
            Book(title: "The Pragmatic Programmer", author: "Andrew Hunt and David Thomas", description: "A guide to becoming a better programmer.", genre: "Literatura techniczna", epubFile: "", image: "swift"),
            Book(title: "Introduction to Algorithms", author: "Thomas H. Cormen et al.", description: "A comprehensive textbook on algorithms.", genre: "Literatura techniczna", epubFile: "", image: "swift")
        ]

        return NavigationView {
            BooksView(categoryName: Genre.technical)
                .environmentObject(bookStore)
        }
    }
}
