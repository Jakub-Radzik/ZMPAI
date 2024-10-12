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
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(books) { book in
                        NavigationLink(destination: BookPresentationView(book: book)) {
                            if isTwoColumnLayout {
                                VStack {  // 2-column layout: use VStack
                                    Image(book.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(
                                            width: dynamicWidth(for: geometry.size.width),
                                            height: dynamicHeight(for: geometry.size.height)
                                        )
                                        .clipped()
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(10)

                                    Text(book.title)
                                        .font(.headline)
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                        .frame(height: 20)
                                        .padding(.top, 4)
                                        .foregroundColor(.black)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                            } else {
                                VStack {
                                    HStack {  // 1-column layout: use HStack
                                        Image(book.image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(
                                                width: dynamicWidth(for: geometry.size.width) * 0.8,  // Adjusted width for 1-column layout
                                                height: dynamicHeight(for: geometry.size.height) * 0.8  // Adjusted height for 1-column layout
                                            )
                                            .clipped()
                                            .background(Color.gray.opacity(0.2))
                                            .cornerRadius(10)
                                        
                                        VStack(alignment: .leading) {
                                            Text(book.title)
                                                .font(.headline)
                                                .lineLimit(1)
                                                .truncationMode(.tail)
                                                .padding(.top, 4)
                                                .foregroundColor(.black)
                                            
                                            Text(book.author)
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                            
                                            Spacer()
                                        }
                                        .padding(.leading, 8)
                                        
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    
                                    Divider()
                                        .background(Color.gray)
                                }
                                
                            }
                        }
                        .background(Color(.systemGray6))
                        .accessibilityIdentifier(book.title)
                    }
                }
                .padding()
                .navigationTitle(title)
                .background(Color(.systemGray6))
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isTwoColumnLayout.toggle()  // Toggle between 2-column and 1-column layout
                        }) {
                            Image(systemName: isTwoColumnLayout ? "square.split.1x2.fill" : "square.split.2x2.fill")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
    }
    // Dynamic width calculation based on the number of columns
    func dynamicWidth(for totalWidth: CGFloat) -> CGFloat {
        if isTwoColumnLayout {
            return (totalWidth * 0.4) / 2  // Each column gets 40% of the screen width divided by 2 columns
        } else {
            return totalWidth * 0.1  // Single column gets 80% of the screen width
        }
    }
    
    // Dynamic height calculation based on the number of columns
    func dynamicHeight(for totalHeight: CGFloat) -> CGFloat {
        if isTwoColumnLayout {
            return totalHeight * 0.2  // 20% of screen height for 2 columns
        } else {
            return totalHeight * 0.1  // 30% of screen height for 1 column
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let books: [Book]
        books = [
                Book(title: "Clean Code", author: "Robert C. Martin", description: "A handbook of agile software craftsmanship.", genre: .technical, image: "you_dont_know_js"),
                Book(title: "The Pragmatic Programmer", author: "Andrew Hunt and David Thomas", description: "A guide to becoming a better programmer.", genre: .technical, image: "swift"),
                Book(title: "Introduction to Algorithms", author: "Thomas H. Cormen et al.", description: "A comprehensive textbook on algorithms.", genre: .technical, image: "swift")
            ]

        return NavigationView {
            CardView(books: books, title: "My books")
        }
    }
}
