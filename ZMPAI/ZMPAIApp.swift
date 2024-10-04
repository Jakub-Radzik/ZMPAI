import SwiftUI

@main
struct ZMPAIApp: App {
    @StateObject private var bookStore = BookStore()
    
    var body: some Scene {
        WindowGroup {
            TabNavigator().environmentObject(bookStore)
        }
    }
}
