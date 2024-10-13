import SwiftUI

struct BooksView: View {
    @EnvironmentObject var bookStore: BookStore
    let categoryName: Genre


    var body: some View {
        CardView(
            books: bookStore.books,
            title: categoryName.rawValue
        )
    }


}

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        let bookStore = BookStore()
        
        bookStore.books = [
            Book(title: "Clean Code", author: "Robert C. Martin", description: "A handbook of agile software craftsmanship.", genre: .technical, image: "you_dont_know_js"),
            Book(title: "The Pragmatic Programmer", author: "Andrew Hunt and David Thomas", description: "A guide to becoming a better programmer.", genre: .technical, image: "swift"),
            Book(title: "Introduction to Algorithms", author: "Thomas H. Cormen et al.", description: "A comprehensive textbook on algorithms.", genre: .technical, image: "swift")
        ]

        return NavigationView {
            BooksView(categoryName: Genre.technical)
                .environmentObject(bookStore)
        }
    }
}
