import SwiftUI

struct BooksGridView: View {
    let books: [Book]
    let geometry: GeometryProxy
    let isTwoColumnLayout: Bool
    
    var columns: [GridItem] {
        isTwoColumnLayout ? [GridItem(.flexible()), GridItem(.flexible())] : [GridItem(.flexible())]
    }

    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(books) { book in
                NavigationLink(destination: BookPresentationView(book: book)) {
                    BookItemView(book: book, geometry: geometry, isTwoColumnLayout: isTwoColumnLayout)
                }
                .background(Color(.systemGray6))
                .accessibilityIdentifier(book.title)
            }
        }
    }
}

struct BooksGridPreview: PreviewProvider {
    static var previews: some View {
        @State var isTwoColumnLayout: Bool = true
        
        let books: [Book] = [
            Book(title: "Clean Code", author: "Robert C. Martin", description: "A handbook of agile software craftsmanship.", genre: .technical, image: "you_dont_know_js"),
            Book(title: "The Pragmatic Programmer", author: "Andrew Hunt and David Thomas", description: "A guide to becoming a better programmer.", genre: .technical, image: "swift"),
            Book(title: "Introduction to Algorithms", author: "Thomas H. Cormen et al.", description: "A comprehensive textbook on algorithms.", genre: .technical, image: "swift")
        ]

        return Group {
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                            BooksGridView(
                                books: books,
                                geometry: geometry,
                                isTwoColumnLayout: true
                            )
                            .padding()
                            .navigationTitle("Test")
                            .background(Color(.systemGray6))
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    ToggleLayoutButton(isTwoColumnLayout: $isTwoColumnLayout)
                                }
                            }
                    }
                    .background(Color(.systemBackground))
                }
            };
        }
    }
}
