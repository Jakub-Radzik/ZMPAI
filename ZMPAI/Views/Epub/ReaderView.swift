import SwiftUI
import WebKit

struct ChapterView: View {
    let chapterURL: URL?

    var body: some View {
        WebView(url: chapterURL)
            .navigationTitle("Chapter")
    }
}

struct WebView: UIViewRepresentable {
    var url: URL?

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        print("Loading URL: \(String(describing: url))") // Log URL
        if let url = url {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}

struct ReaderView: View {
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

                if isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }

                // Use NavigationLink for navigation
                NavigationLink(destination: ChapterView(chapterURL: chapterURL), isActive: .constant(chapterURL != nil)) {
                    EmptyView()
                }
            }
        }
    }


    private func loadEPUB() {
        isLoading = true
        loader.loadChapter(from: "http://iosappapi.ddns.net:3111/media/epubs/pg11-images-3_fB4xYIE.epub", chapterNumber: 0) { url in
            DispatchQueue.main.async {
                self.isLoading = false
                if let url = url {
                    print("Loaded chapter URL: \(url)")
                    chapterURL = url // This should trigger navigation
                } else {
                    print("Failed to load chapter")
                }
            }
        }
    }


}
