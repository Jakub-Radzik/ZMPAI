import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var url: URL?
    @Binding var scrollPosition: Double
    @Binding var webView: WKWebView?

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = context.coordinator
        
        // Enable zooming in the scrollView
        webView.scrollView.minimumZoomScale = 1.0
        webView.scrollView.maximumZoomScale = 4.0 // Set maximum zoom scale as desired
        webView.scrollView.delegate = context.coordinator // Set the delegate

        DispatchQueue.main.async {
            self.webView = webView
        }

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = url {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate, UIScrollViewDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("Finished loading \(String(describing: parent.url))")
            
            // Set the scroll position after the content is loaded with a delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                print("Setting scroll position to \(self.parent.scrollPosition)")
                print("Content height: \(webView.scrollView.contentSize.height)")
                let yOffset = CGFloat(self.parent.scrollPosition) * (webView.scrollView.contentSize.height - webView.scrollView.bounds.height)
                if yOffset.isFinite {
                    webView.scrollView.setContentOffset(CGPoint(x: 0, y: yOffset), animated: true)
                }
            }
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            print("Failed to load with error: \(error.localizedDescription)")
        }
        
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return scrollView.subviews.first // Allow zooming on the first subview
        }
        
        func saveScrollPosition() -> Double {
            guard let webView = parent.webView else { return 0.0}
            let scrollHeight = webView.scrollView.contentSize.height - webView.scrollView.bounds.height
            if scrollHeight > 0 {
                let newScrollPosition = Double(webView.scrollView.contentOffset.y / scrollHeight)
                if newScrollPosition.isFinite && newScrollPosition != parent.scrollPosition {
                    parent.scrollPosition = newScrollPosition
                    print("Saved scroll position: \(newScrollPosition)")
                    return newScrollPosition
                }
            }
            return 0.0
        }
    }
}
