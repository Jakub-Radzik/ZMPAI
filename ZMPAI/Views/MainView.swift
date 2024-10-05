import SwiftUI

struct MainView: View {
    @EnvironmentObject var bookStore: BookStore
    @State private var isAnimating: Bool = false
    
    var body: some View {
        NavigationView{
            ScrollView {
                VStack(alignment: .leading) {
                    
                    // HIT TYGODNIA
                    NavigationLink(destination: BookPresentationView(book: bookStore.weeklyBook!)){
                        ZStack(alignment: .center) {
                            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.white.opacity(0.0)]),
                                           startPoint: .top, endPoint: .bottom)
                                .frame(height: 200)
                            
                            HStack {
                                VStack{
                                    Text("Hit tygodnia!")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    
                                    
                                    Text(bookStore.weeklyBook?.title ?? "")
                                        .font(.title2)
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                }
                                
                                Image(bookStore.weeklyBook?.image ?? "lotr_1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 150)
                                    .clipped()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                            }
                            .padding(.top, 100)
                            .scaleEffect(isAnimating ? 1.1 : 0.9)
                            .onAppear{
                                pulse()
                            }
                        }
                        .frame(height: 200)
                    }
                    
                            VStack(alignment: .leading, spacing: 10) {
                                
                                    Text("Polecamy")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.primary)
                                        .padding(.bottom, 10)
                                    
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(alignment: .top, spacing: 16) {
                                                ForEach(bookStore.bestBooks) { book in
                                                    NavigationLink(destination: BookPresentationView(book: book)){
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
                                                                .foregroundColor(.black)
                                                        }
                                                        .frame(width: 150)
                                                    }
                                                }
                                            
                                        }
                                        .padding(.horizontal)
                                    }
                                
                                
                                Text("Polecane kategorie")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                    .padding(.bottom, 10)

                                ScrollView(.horizontal, showsIndicators: false){
                                    HStack {
                                        NavigationLink(destination: BooksCategoryView(categoryName: .fantasy)) {
                                            Text("Fantasy")
                                                .font(.headline)
                                                .padding()
                                                .background(Color.blue.opacity(0.1))
                                                .cornerRadius(8)
                                                .foregroundColor(.blue)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        
                                        NavigationLink(destination: BooksCategoryView(categoryName: .technical)) {
                                            Text("Literatura techniczna")
                                                .font(.headline)
                                                .padding()
                                                .background(Color.green.opacity(0.1))
                                                .cornerRadius(8)
                                                .foregroundColor(.green)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        
                                        NavigationLink(destination: BooksCategoryView(categoryName: .scienceFiction)) {
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
            Book(title: "The Pragmatic Programmer", author: "Andrew Hunt and David Thomas", description: "A guide to becoming a better programmer.", genre: .technical, image: "swift")
        ]
        
        return MainView()
            .environmentObject(store)
    }
}
