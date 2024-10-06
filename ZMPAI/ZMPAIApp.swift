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
            }
        }
    }
}
