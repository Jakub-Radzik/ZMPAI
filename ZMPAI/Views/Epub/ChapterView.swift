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
        if let url = url {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}
