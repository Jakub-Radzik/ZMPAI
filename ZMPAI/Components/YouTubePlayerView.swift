import SwiftUI
import WebKit

struct YouTubePlayer: UIViewRepresentable {
    var videoID: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: "https://www.youtube.com/embed/\(videoID)") {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}

struct YouTubePlayerView: View {
    let videoID: String
    
    var body: some View {
        VStack {
            YouTubePlayer(videoID: videoID)
                .frame(height: 300)
        }
    }
}

