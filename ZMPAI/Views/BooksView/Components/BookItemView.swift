import SwiftUI

struct BookItemView: View {
    @Environment(\.colorScheme) var colorScheme
    let book: Book
    let geometry: GeometryProxy
    let isTwoColumnLayout: Bool

    var body: some View {
        if isTwoColumnLayout {
            VStack {
                BookImage(bookImage: book.image, width: dynamicWidth(for: geometry.size.width))
                
                Text(book.title)
                    .font(.headline)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .frame(height: 20)
                    .padding(.top, 4)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(colorScheme == .dark ? Color(.darkGray) : Color.white)
            .cornerRadius(10)
        } else {
            HStack {
                AsyncImage(url: URL(string: book.image)) { imagePhase in
                    switch imagePhase {
                        case .empty:
                            // Placeholder while loading
                            ProgressView()
                                .frame(width: 20, height: 40)
                                .background(Color.gray.opacity(0.2))

                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40)
                            
                        case .failure:
                            Image(systemName: "exclamationmark.triangle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 40)
                                .foregroundColor(.red)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)

                        @unknown default:
                            EmptyView()
                        }
                }
                    .clipped()
                
                VStack(alignment: .leading) {
                    Text(book.title)
                        .font(.headline)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .padding(.top, 4)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    
                    Text(book.author)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                }
                .padding(.leading, 8)
                
                Spacer()
            }
            .background(Color(.systemGray6))
        }
    }

    func dynamicWidth(for totalWidth: CGFloat) -> CGFloat {
        isTwoColumnLayout ? (totalWidth * 0.4) / 2 : totalWidth * 0.1
    }

    func dynamicHeight(for totalHeight: CGFloat) -> CGFloat {
        isTwoColumnLayout ? totalHeight * 0.2 : totalHeight * 0.1
    }
}

struct BookItemPreviews: PreviewProvider {
    static var previews: some View {
        @State var isTwoColumnLayout: Bool = true
        
        let books: [Book] = [
            Book(title: "Clean Code", author: "Robert C. Martin", description: "A handbook of agile software craftsmanship.", genre: "Literatura techniczna", image: "http://iosappapi.ddns.net:3111/media/images/pg11.cover.medium.jpg"),
            Book(title: "The Pragmatic Programmer", author: "Andrew Hunt and David Thomas", description: "A guide to becoming a better programmer.", genre: "Literatura techniczna", image: "http://iosappapi.ddns.net:3111/media/images/pg11.cover.medium.jpg"),
            Book(title: "Introduction to Algorithms", author: "Thomas H. Cormen et al.", description: "A comprehensive textbook on algorithms.", genre: "Literatura techniczna", image: "http://iosappapi.ddns.net:3111/media/images/pg11.cover.medium.jpg")
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
