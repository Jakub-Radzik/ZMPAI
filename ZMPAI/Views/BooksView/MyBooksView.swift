//
//  MyBooksView.swift
//  ZMPAI
//
//  Created by Kamil Herbetko on 11/10/2024.
//

import SwiftUI

struct MyBooksView: View {
    @EnvironmentObject var bookStore: BookStore
    var body: some View {
        NavigationView{
            CardView(books: bookStore.myBooks, title: "Wypożyczone")
        }
    }
}

struct MyBooksView_Previews: PreviewProvider {
    static var previews: some View {
        let bookStore = BookStore()
        
        bookStore.myBooks = [
//            Book(title: "Clean Code", author: "Robert C. Martin", description: "A handbook of agile software craftsmanship.", genre: .technical, image: "you_dont_know_js"),
//            Book(title: "The Pragmatic Programmer", author: "Andrew Hunt and David Thomas", description: "A guide to becoming a better programmer.", genre: .technical, image: "swift"),
//            Book(title: "Introduction to Algorithms", author: "Thomas H. Cormen et al.", description: "A comprehensive textbook on algorithms.", genre: .technical, image: "swift")
        ]

        return MyBooksView().environmentObject(bookStore)
    }
}
