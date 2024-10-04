import SwiftUI

struct CategoryView: View {
    var body: some View {
        NavigationView {
            List(Genre.allCases) { genre in
                NavigationLink(destination: BooksCategoryView(categoryName: genre)) {
                    Text(genre.rawValue)
                }
            }
            .navigationTitle("Kategorie")
        }
    }
}

#Preview {
    CategoryView()
}
