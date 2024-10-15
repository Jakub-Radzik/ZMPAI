import SwiftUI

struct BookPresentationView: View {
    @EnvironmentObject var bookStore: BookStore
    let book: Book
    @State private var showAlert: Bool = false
    @State private var progress: Int = 0
    
    var isRented: Bool {
        bookStore.isRented(bookId: book.id)
    }

    var body: some View {
        VStack(spacing: 16) {
            BookImage(bookImage: book.image, width: 200)

            Text(book.title)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top)
                .accessibilityIdentifier("bookTitle")

            HStack(spacing: 2) {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: index <= book.rating ? "star.fill" : "star")
                        .foregroundColor(index <= book.rating ? .yellow : .gray)
                }
            }

            Text(book.description)
                .font(.body)
                .padding(.horizontal)
                .multilineTextAlignment(.center)

            if let audioName = book.audioName {
                AudioView(audioName: audioName)
            }

            if isRented {
                NavigationLink(destination: ReaderView(epubFile: book.epubFile)){
                    Text("Czytaj")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            } else {
                Button(action: {
                    bookStore.rentBook(book)
                    progress = bookStore.getBookProgress(for: book.id) ?? 0
                    showAlert = true
                }) {
                    Text("Wypożycz książkę")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .accessibilityIdentifier("rentBook")
                .padding(.horizontal)
            }

            Spacer()
        }
        .padding()
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // Fetch and set the book progress when the view appears
            progress = bookStore.getBookProgress(for: book.id) ?? 0
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Success"),
                message: Text("Udało ci się wypożyczyć książkę: \(book.title)"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}


struct BookPresentationView_Previews: PreviewProvider {
    static var previews: some View {
        let bookStore = BookStore()
        
        bookStore.myBooks = [
            Book(title: "Clean Code", author: "Robert C. Martin", description: "A handbook of agile software craftsmanship.", genre: "Literatura techniczna", image: "http://iosappapi.ddns.net:3111/media/images/pg11.cover.medium.jpg"),
            Book(title: "The Pragmatic Programmer", author: "Andrew Hunt and David Thomas", description: "A guide to becoming a better programmer.", genre: "Literatura techniczna", image: "http://iosappapi.ddns.net:3111/media/images/pg11.cover.medium.jpg"),
            Book(title: "Introduction to Algorithms", author: "Thomas H. Cormen et al.", description: "A comprehensive textbook on algorithms.", genre: "Literatura techniczna", image: "http://iosappapi.ddns.net:3111/media/images/pg11.cover.medium.jpg")
        ]

        return NavigationView { 
            BookPresentationView(
                book: Book(title: "You Don't Know JS",
                     author: "Kyle Simpson",
                     description: "An in-depth series on JavaScript.",
                     genre: "Literatura techniczna",
                     image: "http://iosappapi.ddns.net:3111/media/images/pg11.cover.medium.jpg"))
            .environmentObject(bookStore)
        }
    }
}
