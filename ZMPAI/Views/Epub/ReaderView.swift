import SwiftUI

struct ReaderView: View {
    @State private var chapterURL: URL?
    @State private var isLoading = false
    @State private var currentChapterIndex = 0
    private let totalChapters = 5 // Adjust this to the total number of chapters you have
    private let loader = Loader()
    let epubFile: String;
    
    var body: some View {
        NavigationStack {
            VStack {
                if isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    WebView(url: chapterURL)

                    HStack {
                        Button(action: previousChapter) {
                            Text("Previous")
                                .padding()
                                .background(currentChapterIndex == 0 ? Color.gray : Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .disabled(currentChapterIndex == 0)

                        Spacer()

                        Button(action: nextChapter) {
                            Text("Next")
                                .padding()
                                .background(currentChapterIndex >= totalChapters - 1 ? Color.gray : Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .disabled(currentChapterIndex >= totalChapters - 1)
                    }
                    .padding()
                }
            }
            .onAppear {
                loadChapter()
            }
        }
    }

    private func loadChapter() {
        isLoading = true
        loader.loadChapter(from: epubFile, chapterNumber: currentChapterIndex) { url in
            DispatchQueue.main.async {
                self.isLoading = false
                if let url = url {
                    print("Loaded chapter URL: \(url)")
                    chapterURL = url // This should trigger the ChapterView to update
                } else {
                    print("Failed to load chapter")
                }
            }
        }
    }
    
    
    private func previousChapter() {
        if currentChapterIndex > 0 {
            currentChapterIndex -= 1
            loadChapter() // Load the previous chapter
        }
    }

    private func nextChapter() {
        if currentChapterIndex < totalChapters - 1 {
            currentChapterIndex += 1
            loadChapter() // Load the next chapter
        }
    }
}

struct ReaderViewPreviews: PreviewProvider {
    static var previews: some View {
        ReaderView(epubFile: "http://iosappapi.ddns.net:3111/media/epubs/pg11-images-3_fB4xYIE.epub")
    }
}
