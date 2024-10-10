import SwiftUI

struct BooksCategoryView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var bookStore: BookStore
    let categoryName: Genre

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(bookStore.booksForGenre(categoryName)) { book in
                    NavigationLink(destination: BookPresentationView(book: book)) {
                        VStack {
                            Image(book.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 150)
                                .clipped()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)

                            Text(book.title)
                                .font(.headline)
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .frame(height: 20)
                                .padding(.top, 4)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    }
                    .accessibilityIdentifier(book.title)
                }
            }
            .padding()
            .navigationTitle(categoryName.rawValue)
        }
    }
}

struct BooksCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        let bookStore = BookStore()
        
        bookStore.books = [
            Book(title: "Clean Code", author: "Robert C. Martin", description: "A handbook of agile software craftsmanship.", genre: .technical, image: "you_dont_know_js"),
            Book(title: "The Pragmatic Programmer", author: "Andrew Hunt and David Thomas", description: "A guide to becoming a better programmer.", genre: .technical, image: "swift"),
            Book(title: "Introduction to Algorithms", author: "Thomas H. Cormen et al.", description: "A comprehensive textbook on algorithms.", genre: .technical, image: "swift")
        ]

        return NavigationView {
            BooksCategoryView(categoryName: Genre.technical)
                .environmentObject(bookStore)
        }
    }
}
