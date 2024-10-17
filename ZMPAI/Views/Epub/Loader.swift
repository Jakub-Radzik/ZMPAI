import Foundation

class Loader {
    func loadChapter(from epubURLString: String, chapterNumber: Int, completion: @escaping (URL?) -> Void) {
        guard let epubURL = URL(string: epubURLString) else {
//            print("Invalid EPUB URL: \(epubURLString)")
            completion(nil)
            return
        }

        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let epubFileName = epubURL.lastPathComponent // Use the original filename from the URL
        let localEpubURL = documentsDirectory.appendingPathComponent(epubFileName)

        // Download the EPUB file
        let task = URLSession.shared.downloadTask(with: epubURL) { location, response, error in
            if let error = error {
//                print("Error downloading EPUB: \(error)")
                completion(nil)
                return
            }

            guard let location = location else {
//                print("Download location is nil")
                completion(nil)
                return
            }

            // Check if the file already exists and remove it if so
            if FileManager.default.fileExists(atPath: localEpubURL.path) {
                do {
                    try FileManager.default.removeItem(at: localEpubURL)
//                    print("Removed existing EPUB file at: \(localEpubURL)")
                } catch {
//                    print("Error removing existing EPUB file: \(error)")
                }
            }

            // Move the downloaded file to the documents directory
            do {
                try FileManager.default.moveItem(at: location, to: localEpubURL)
//                print("EPUB downloaded successfully at: \(localEpubURL)")

                // Unzip and parse the EPUB file
                UnzipHelper.unzipEPUB(epubURL: localEpubURL) { unzipDirectory in
                    guard let unzipDirectory = unzipDirectory else {
//                        print("Error unzipping epub: unzipDirectory is nil")
                        completion(nil)
                        return
                    }

                    let epubParser = EpubParser(epubDirectory: unzipDirectory)
                    epubParser.parseEpub(chapterNumber: chapterNumber) { chapterURL in
                        completion(chapterURL) // Return the chapter URL through the completion handler
                    }
                }
            } catch {
//                print("Error moving downloaded EPUB file: \(error)")
                completion(nil)
            }
        }

        task.resume() // Start the download task
    }
}



//import Foundation
//
//class Loader {
//    private func loadChapterInWebView(from epubURLString: String, chapterNumber: Int) {
//        print("in loadChapterInWebView func")
//        
//        guard let epubURL = URL(string: epubURLString) else {
//            print("Invalid EPUB URL: \(epubURLString)")
//            return
//        }
//
//        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        let epubFileName = epubURL.lastPathComponent // Use the original filename from the URL
//        let localEpubURL = documentsDirectory.appendingPathComponent(epubFileName)
//
//        let task = URLSession.shared.downloadTask(with: epubURL) { [weak self] location, response, error in
//            guard let self = self else { return }
//
//            if let error = error {
//                print("Error downloading EPUB: \(error)")
//                return
//            }
//
//            guard let location = location else {
//                print("Download location is nil")
//                return
//            }
//
//            do {
//                try FileManager.default.moveItem(at: location, to: localEpubURL)
//                print("EPUB downloaded successfully at: \(localEpubURL)")
//                
//                UnzipHelper.unzipEPUB(epubURL: localEpubURL) { unzipDirectory in
//                    guard let unzipDirectory = unzipDirectory else {
//                        print("Error unzipping epub: unzipDirectory is nil")
//                        return
//                    }
//                    print("epub unzipDirectory: \(unzipDirectory)")
//
//                    let epubParser = EpubParser(epubDirectory: unzipDirectory)
//                    epubParser.parseEpub(chapterNumber: chapterNumber) { chapterURL in
//                        if let chapterURL = chapterURL {
//                            print("chapterUrl fetched: \(chapterURL)")
//                            self.loadChapterInWebView(chapterURL) // Ensure you have a proper method for this
//                        } else {
//                            print("Error fetching chapterURL: Chapter not found for number \(chapterNumber)")
//                        }
//                    }
//                }
//            } catch {
//                print("Error moving downloaded EPUB file: \(error)")
//            }
//        }
//        
//        task.resume()
//    }
//    
//    private func loadChapterInWebView(_ chapterURL: URL) {
//        print("Loading chapter in web view: \(chapterURL)")
//    }
//}
