import SwiftUI

struct ReadBookView: View {
    @EnvironmentObject var bookStore: BookStore
    @State private var currentPage: Int
    @State private var currentPageText: String
    
    let book: Book

    init(book: Book) {
        self.book = book
        _currentPage = State(initialValue: 0)
        _currentPageText = State(initialValue: "")
    }

    var body: some View {
        
        ZStack{
            ScrollViewReader { proxy in
                VStack {
                    ScrollView {
                        Text(currentPageText)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .padding()
                            .id("top")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                    HStack {
                        Button(action: {
                            previousPage()
                            proxy.scrollTo("top", anchor: .top)
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .accessibilityIdentifier("previousPageButton")
                        .disabled(currentPage == 0)

                        Text("Strona \(currentPage+1) /")
                            .font(.headline)
                            .padding()
                            .accessibilityIdentifier("pageText")

                        Button(action: {
                            nextPage()
                            proxy.scrollTo("top", anchor: .top)
                        }) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .accessibilityIdentifier("nextPageButton")
                        .disabled(currentPage+1 == 0)
                    }
                    .padding(.horizontal)
                    

                }
                .padding()
                .navigationTitle(book.title)
                .navigationBarTitleDisplayMode(.inline)
            }
                      
        }

    }


    private func nextPage() {
    }

    private func previousPage() {
    }
}

struct ReadBookView_Previews: PreviewProvider {
    static var previews: some View {
        let bookStore = BookStore()
        
        let book = Book(title: "The Pragmatic Programmer", author: "Andrew Hunt and David Thomas", description: "A guide to becoming a better programmer.", genre: "Literatura techniczna", image: "swift")
        
        bookStore.books.append(book)

        return NavigationView{
            ReadBookView(book: book)
                .environmentObject(bookStore)
        }
    }
}
