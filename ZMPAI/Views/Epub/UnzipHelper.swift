import Foundation
import ZIPFoundation

class UnzipHelper {
    static func unzipEPUB(epubURL: URL, completion: @escaping (URL?) -> Void) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let epubName = (epubURL.lastPathComponent as NSString).deletingPathExtension
        let unzipDirectory = documentsDirectory.appendingPathComponent(epubName)

        // Log the initial file paths
        print("EPUB URL: \(epubURL)")
        print("Unzip Directory: \(unzipDirectory.path)")

        do {
            // Remove the existing unzip directory if it exists
            if FileManager.default.fileExists(atPath: unzipDirectory.path) {
                try FileManager.default.removeItem(at: unzipDirectory)
                print("Removed existing unzip directory at: \(unzipDirectory.path)")
            } else {
                print("No existing unzip directory found at: \(unzipDirectory.path)")
            }

            // Create the destination directory
            try FileManager.default.createDirectory(at: unzipDirectory, withIntermediateDirectories: true, attributes: nil)
            print("Created unzip directory at: \(unzipDirectory.path)")

            // Unzip the EPUB file
            try FileManager.default.unzipItem(at: epubURL, to: unzipDirectory)
            print("EPUB Unzipped successfully to: \(unzipDirectory.path)")
            completion(unzipDirectory)
        } catch {
            print("Error unzipping file: \(error.localizedDescription)")
            completion(nil)
        }
    }
}
