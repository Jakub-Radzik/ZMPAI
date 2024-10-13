import SwiftUI

struct CategoryView: View {
    var body: some View {
        NavigationView {
            List(Genre.allCases) { genre in
                NavigationLink(destination: BooksView(categoryName: genre)) {
                    Text(genre.rawValue)
                }
                .accessibilityIdentifier(genre.rawValue)
            }
            .navigationTitle("Kategorie")
        }
    }
}

#Preview {
    CategoryView()
}
