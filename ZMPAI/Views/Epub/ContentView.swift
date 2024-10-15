import SwiftUI

struct ContentView: View {
    @State private var chapterURL: URL?
    @State private var isLoading = false

    private let loader = Loader()

    var body: some View {
        NavigationStack {
            VStack {
                Text("Load EPUB and View Chapter")
                    .font(.largeTitle)
                    .padding()

                Button(action: loadEPUB) {
                    Text("Load Chapter 1")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            .alert(isPresented: $isLoading) {
                Alert(title: Text("Loading"), message: Text("Please wait..."), dismissButton: .default(Text("OK")))
            }
            .navigationDestination(for: URL.self) { url in
                ChapterView(chapterURL: url)
            }
        }
    }

    private func loadEPUB() {
        isLoading = true
        loader.loadChapter(from: "http://iosappapi.ddns.net:3111/media/epubs/pg11-images-3_fB4xYIE.epub", chapterNumber: 1) { url in
            DispatchQueue.main.async {
                self.isLoading = false
                if let url = url {
                    chapterURL = url
                } else {
                    print("Failed to load chapter")
                }
            }
        }
    }
}
