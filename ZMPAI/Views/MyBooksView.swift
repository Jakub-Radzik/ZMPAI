import SwiftUI

struct MyBooksView: View {
    @EnvironmentObject var bookStore: BookStore
    
    var body: some View {
        NavigationView {
            List {
                ForEach(bookStore.myBooks) { book in
                    NavigationLink(destination: ReadBookView(book: book)) {
                        VStack {
                            Image(book.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 150)
                                .padding()
                            let progress = book.pages > 0 ? Double(book.progress+1) / Double(book.pages) : 0.0

                            ProgressView(value: progress)
                                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                        }
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle("Wypożyczone książki")
        }
    }
}

struct MyBooksView_Previews: PreviewProvider {
    static var previews: some View {
        let bookStore = BookStore()
        bookStore.myBooks = [
            Book(title: "Clean Code", author: "Robert C. Martin", description: "A handbook of agile software craftsmanship.", genre: .technical, image: "you_dont_know_js"),
            Book(title: "The Pragmatic Programmer", author: "Andrew Hunt and David Thomas", description: "A guide to becoming a better programmer.", genre: .technical, image: "swift"),
            Book(title: "Introduction to Algorithms", author: "Thomas H. Cormen et al.", description: "A comprehensive textbook on algorithms.", genre: .technical, image: "swift")
        ]

        return NavigationView {
            MyBooksView()
                .environmentObject(bookStore)
        }
    }
}
