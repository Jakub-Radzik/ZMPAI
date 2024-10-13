//
//  BooksGrid.swift
//  ZMPAI
//
//  Created by Jakub Radzik on 13/10/2024.
//

import SwiftUI

struct BooksGrid: View {
    let books: [Book]
    let 
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(books) { book in
                NavigationLink(destination: BookPresentationView(book: book)) {
                    if isTwoColumnLayout {
                        VStack {
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
                            HStack {
                                Image(book.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(
                                        width: dynamicWidth(for: geometry.size.width) * 0.8,
                                        height: dynamicHeight(for: geometry.size.height) * 0.8
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
                    isTwoColumnLayout.toggle()
                }) {
                    Image(systemName: isTwoColumnLayout ? "square.split.1x2.fill" : "square.split.2x2.fill")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

#Preview {
    BooksGrid()
}
