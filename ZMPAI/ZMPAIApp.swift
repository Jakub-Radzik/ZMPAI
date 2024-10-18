import SwiftUI

@main
struct ZMPAIApp: App {
    @StateObject private var bookStore = BookStore()
    
    var body: some Scene {
        WindowGroup {
            if CommandLine.arguments.contains("-audioView") {
                AudioView(audioName: "lotr_1_audio")
            } else {
                TabNavigator().environmentObject(bookStore)
                    .onAppear{
                        if ProcessInfo.processInfo.arguments.contains("UITesting"){
                            setupMockDataForUITests()
                        }
                    }
            }
            
        }
    }
    
    // Function to set mock data for UI Tests
    func setupMockDataForUITests() {
        bookStore.myBooks = [
            Book(title: "Clean Code", author: "Robert C. Martin", description: "A handbook of agile software craftsmanship.", genre: "Literatura techniczna", epubFile: "", chapters: 11, image: "you_dont_know_js"),
            Book(title: "The Pragmatic Programmer", author: "Andrew Hunt and David Thomas", description: "A guide to becoming a better programmer.", genre: "Literatura techniczna", epubFile: "", chapters: 11, image: "swift"),
            Book(title: "Introduction to Algorithms", author: "Thomas H. Cormen et al.", description: "A comprehensive textbook on algorithms.", genre: "Literatura techniczna",  epubFile: "", chapters: 11, image: "swift")
        ]
    }
}
