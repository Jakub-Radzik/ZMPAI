import SwiftUI

struct BookPresentationView: View {
    @EnvironmentObject var bookStore: BookStore
    let book: Book
    @State private var showAlert: Bool = false
    
    var isRented: Bool {
        bookStore.isRented(bookId: book.id)
    }

    var body: some View {
        VStack(spacing: 16) {
            Image(book.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 300)
                .clipped()
                .cornerRadius(10)
                .shadow(radius: 5)

            Text(book.title)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top)

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
                Text("Książka wypożyczona")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            } else {
                Button(action: {
                    bookStore.rentBook(book)
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
                .padding(.horizontal)
            }

            Spacer()
        }
        .padding()
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
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
            Book(title: "Clean Code", author: "Robert C. Martin", description: "A handbook of agile software craftsmanship.", genre: .technical, image: "you_dont_know_js"),
            Book(title: "The Pragmatic Programmer", author: "Andrew Hunt and David Thomas", description: "A guide to becoming a better programmer.", genre: .technical, image: "swift"),
            Book(title: "Introduction to Algorithms", author: "Thomas H. Cormen et al.", description: "A comprehensive textbook on algorithms.", genre: .technical, image: "swift")
        ]

        return NavigationView { 
            BookPresentationView(
                book: Book(title: "You Don't Know JS",
                     author: "Kyle Simpson",
                     description: "An in-depth series on JavaScript.",
                     genre: .technical,
                     image: "you_dont_know_js"))
            .environmentObject(bookStore)
        }
    }
}
