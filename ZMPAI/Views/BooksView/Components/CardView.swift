//
//  CardView.swift
//  ZMPAI
//
//  Created by Kamil Herbetko on 11/10/2024.
//

import SwiftUI

struct CardView: View {
    @State private var isTwoColumnLayout: Bool = true
    let books: [Book]
    let title: String
    
    var columns: [GridItem] {
        isTwoColumnLayout ? [GridItem(.flexible()), GridItem(.flexible())] : [GridItem(.flexible())]
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    if books.isEmpty {
                        EmptyBooksView(message: "Trochę tu pusto. Wypożycz coś!", imageName: "books.vertical")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color(.systemBackground))
                            .navigationTitle(title)
                            .padding(.top, 100)
                    } else {
                        BooksGridView(
                            books: books,
                            geometry: geometry,
                            isTwoColumnLayout: isTwoColumnLayout
                        )
                        .padding()
                        .navigationTitle(title)
                        .background(Color(.systemGray6))
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                ToggleLayoutButton(isTwoColumnLayout: $isTwoColumnLayout)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemBackground))
            }
        }
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let books: [Book] = [
            Book(title: "Clean Code", author: "Robert C. Martin", description: "A handbook of agile software craftsmanship.", genre: .technical, image: "you_dont_know_js"),
            Book(title: "The Pragmatic Programmer", author: "Andrew Hunt and David Thomas", description: "A guide to becoming a better programmer.", genre: .technical, image: "swift"),
            Book(title: "Introduction to Algorithms", author: "Thomas H. Cormen et al.", description: "A comprehensive textbook on algorithms.", genre: .technical, image: "swift")
        ]

        return Group {
            NavigationView {
                CardView(books: books, title: "My Books")
            }
            .previewDisplayName("With Books")

            NavigationView {
                CardView(books: [], title: "My Books")
            }
            .previewDisplayName("Empty")
        }
    }
}

