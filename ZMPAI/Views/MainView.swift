import SwiftUI

struct MainView: View {
    @EnvironmentObject var bookStore: BookStore
    @State private var isAnimating: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView{
            ScrollView {
                VStack(alignment: .leading) {
                    if let weeklyBook = bookStore.weeklyBook {
                        NavigationLink(destination: BookPresentationView(book: weeklyBook)){
                            ZStack(alignment: .center) {
                                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.white.opacity(0.0)]),
                                               startPoint: .top, endPoint: .bottom)
                                    .frame(height: 200)
                                
                                HStack {
                                    VStack{
                                        Text("Hit tygodnia!")
                                            .font(.largeTitle)
                                            .fontWeight(.bold)
                                            .foregroundColor(colorScheme == .dark ? .white : .black)
                                        
                                        
                                        Text(bookStore.weeklyBook?.title ?? "")
                                            .font(.title2)
                                            .foregroundColor(colorScheme == .dark ? .white : .black)
                                        
                                        Spacer()
                                    }
                                    BookImage(bookImage: weeklyBook.image, width: 100)
                                }
                                .padding(.top, 100)
                                .scaleEffect(isAnimating ? 1.1 : 0.9)
                                .onAppear{
                                    pulse()
                                }
                            }
                            .frame(height: 200)
                        }
                        .accessibilityIdentifier("weeklyBook")
                    } else {
                        Text("No Weekly Book Available")
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        if let bestBooks = bookStore.bestBooks {
                            Text("Polecamy")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .padding(.bottom, 10)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(alignment: .top, spacing: 16) {
                                        ForEach(bestBooks) { book in
                                            NavigationLink(destination: BookPresentationView(book: book)){
                                                VStack {
                                                    
                                                    BookImage(bookImage: book.image, width: 100)
                                                    
                                                    Text(book.title)
                                                        .font(.headline)
                                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                                }
                                                .frame(width: 150)
                                            }
                                        }
                                    
                                }
                                .padding(.horizontal)
                            }
                        } else {
                            Text("No Weekly Book Available")
                        }
                        
                        Text("Polecane kategorie")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .padding(.bottom, 10)

                        ScrollView(.horizontal, showsIndicators: false){
                            HStack {
                                NavigationLink(destination: BooksView(categoryName: .fantasy)) {
                                    Text("Fantasy")
                                        .font(.headline)
                                        .padding()
                                        .background(Color.blue.opacity(0.1))
                                        .cornerRadius(8)
                                        .foregroundColor(.blue)
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                NavigationLink(destination: BooksView(categoryName: .technical)) {
                                    Text("Literatura techniczna")
                                        .font(.headline)
                                        .padding()
                                        .background(Color.green.opacity(0.1))
                                        .cornerRadius(8)
                                        .foregroundColor(.green)
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                NavigationLink(destination: BooksView(categoryName: .scienceFiction)) {
                                    Text("Science Fiction")
                                        .font(.headline)
                                        .padding()
                                        .background(Color.red.opacity(0.1))
                                        .cornerRadius(8)
                                        .foregroundColor(.red)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        
                        
                        Text("Polecana recenzja")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .padding(.bottom, 10)
                        YouTubePlayerView(videoID: "VzefaAiD9eA")
                        Spacer().frame(height: 100)
                    }
                    .padding(.horizontal)
                }
                .navigationTitle("Strona główna")
                .navigationBarHidden(true)
            }
            .ignoresSafeArea()
        }
    }
    
    private func pulse() {
            withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                isAnimating.toggle()
            }
        }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let store = BookStore()
        store.myBooks = [
            Book(title: "The Pragmatic Programmer", author: "Andrew Hunt and David Thomas", description: "A guide to becoming a better programmer.", genre: "Literatura techniczna", chapters: 11, image: "swift")
        ]
        
        return MainView()
            .environmentObject(store)
    }
}
