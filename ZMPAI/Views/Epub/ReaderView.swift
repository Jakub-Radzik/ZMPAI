import SwiftUI
import SWXMLHash
import WebKit

struct ReaderView: View {
    @EnvironmentObject var bookStore: BookStore
    let book: Book
    
    @State private var scrollPosition: Double = 0.0
    @State private var chapterNumberTemp: Int = 0
    
    @State private var chapterURL: URL?
    @State private var isLoading = false
    @State private var webView: WKWebView? = nil
    @State private var loadingChapter: Int? = nil
    
    let epubFile: String
    private let loader = Loader()
    
    var body: some View {
        NavigationStack {
            VStack {
                if isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    WebView(url: chapterURL, scrollPosition: $scrollPosition, webView: $webView)
                        .frame(maxWidth: .infinity)
                    
                    HStack {
                        Button(action: previousChapter) {
                            Text("Previous")
                                .font(.subheadline)
                                .padding(8)
                                .frame(maxWidth: .infinity) // Make the button expand to fill available space
                                .background(chapterNumberTemp == 0 ? Color.gray : Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .disabled(chapterNumberTemp == 0)
                        
                        Spacer()
                        
                        Button(action: nextChapter) {
                            Text("Next")
                                .font(.subheadline)
                                .padding(8)
                                .frame(maxWidth: .infinity) // Make the button expand to fill available space
                                .background(chapterNumberTemp >= book.chapters - 1 ? Color.gray : Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .disabled(chapterNumberTemp >= book.chapters - 1)
                    }
                    .padding()
                }
            }
            .onAppear {
                loadState()
                loadChapter()
            }
            .onDisappear {
                saveState()
            }
        }
    }
    
    private func loadChapter() {
        isLoading = true
        loader.loadChapter(from: epubFile, chapterNumber: chapterNumberTemp) { url in
            DispatchQueue.main.async {
                    self.isLoading = false
                    if let url = url {
                        self.chapterURL = url
                    } else {
                        print("Failed to load chapter")
                    }
                
            }
        }
    }

    private func loadState() {
        var progress = bookStore.getProgress(for: book.id)
        
        chapterNumberTemp = progress?.currentChapter ?? 0;
        scrollPosition = progress?.scrollPosition ?? 0.0;
    }
    
    private func saveState() {
        bookStore.updateCurrentChapter(for: book.id, chapter: chapterNumberTemp)
                
        if let webView = webView {
            let coordinator = WebView.Coordinator(WebView(url: chapterURL, scrollPosition: $scrollPosition, webView: $webView))
            scrollPosition = coordinator.saveScrollPosition()
            
            bookStore.updateScrollPosition(for: book.id, position: scrollPosition)
        }
    }
    
    private func previousChapter() {
        if chapterNumberTemp > 0 {
            chapterNumberTemp -= 1
            scrollPosition = 0.0
            loadChapter()
        }
    }
    
    private func nextChapter() {
        if chapterNumberTemp < book.chapters - 1 {
            chapterNumberTemp += 1
            scrollPosition = 0.0

            loadChapter()
        }
    }
}

struct ReaderViewPreviews: PreviewProvider {
    static var previews: some View {
        ReaderView(book: Book(title: "Clean Code", author: "Robert C. Martin", description: "A handbook of agile software craftsmanship.", genre: "Literatura techniczna", chapters: 11, image: "http://iosappapi.ddns.net:3111/media/images/pg11.cover.medium.jpg"), epubFile: "http://iosappapi.ddns.net:3111/media/epubs/pg11-images-3_fB4xYIE.epub")
    }
}
