import SwiftUI

struct TabNavigator: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Strona główna")
                }
                .accessibilityIdentifier("homeTab")
            
            CategoryView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Kategorie")
                }
                .accessibilityIdentifier("categoriesTab")
            
            MyBooksView()
                .tabItem {
                    Image(
                        systemName: "book.fill"
                    )
                    Text("Twoje książki")
                }
                .accessibilityIdentifier("myBooksTab")
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profil")
                }
                .accessibilityIdentifier("profileTab")
        }
    }
}

struct TabNavigator_Previews: PreviewProvider {
    static var previews: some View {
        let bookStore = BookStore()
        
        bookStore.myBooks = [
            Book(title: "Clean Code", author: "Robert C. Martin", description: "A handbook of agile software craftsmanship.", genre: "Literatura techniczna", epubFile: "", chapters: 11, image: "you_dont_know_js"),
            Book(title: "The Pragmatic Programmer", author: "Andrew Hunt and David Thomas", description: "A guide to becoming a better programmer.", genre: "Literatura techniczna", epubFile: "", chapters: 11, image: "swift"),
            Book(title: "Introduction to Algorithms", author: "Thomas H. Cormen et al.", description: "A comprehensive textbook on algorithms.", genre: "Literatura techniczna",  epubFile: "", chapters: 11, image: "swift")
        ]

        return TabNavigator()
            .environmentObject(bookStore)
    }
}
