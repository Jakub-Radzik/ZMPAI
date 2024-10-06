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
                    Image(systemName: "book.fill")
                    Text("Twoje książki")
                }
                .accessibilityIdentifier("bookTab")
            
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

        return TabNavigator()
            .environmentObject(bookStore)
    }
}
