import Foundation
import ZIPFoundation

func unzipEpub(at sourceURL: URL) -> URL? {
    let fileManager = FileManager.default
    let destinationURL = getDocumentsDirectory().appendingPathComponent("unzipped_epub")

    do {
        // Create the destination directory if it doesn't exist
        try fileManager.createDirectory(at: destinationURL, withIntermediateDirectories: true, attributes: nil)

        // Unzip the file
        try fileManager.unzipItem(at: sourceURL, to: destinationURL)
        return destinationURL
    } catch {
        print("Failed to unzip EPUB: \(error)")
        return nil
    }
}

private func getDocumentsDirectory() -> URL {
    FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
}
