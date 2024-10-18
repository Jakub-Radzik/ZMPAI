import Foundation
import SWXMLHash

class EpubParser: NSObject, XMLParserDelegate {
    private var manifestItems: [String: String] = [:]
    private var spineItems: [String] = []
    private var currentElement: String = ""
    private var currentAttributes: [String: String] = [:]
    private var opfFilePath: String = ""
    private var unzipDirectory: URL!
    
    init(epubDirectory: URL) {
        self.unzipDirectory = epubDirectory
    }
    
    func parseEpub(chapterNumber: Int, completion: @escaping (URL?) -> Void) {
        let containerXMLPath = unzipDirectory.appendingPathComponent("META-INF/container.xml").path
        if let containerXMLData = FileManager.default.contents(atPath: containerXMLPath) {
            let xml = XMLHash.parse(containerXMLData)
            if let rootfilePath = xml["container"]["rootfiles"]["rootfile"].element?.attribute(by: "full-path")?.text {
                let opfURL = unzipDirectory.appendingPathComponent(rootfilePath)
                parseOPFFile(opfURL, chapterNumber: chapterNumber, completion: completion)
            }
        }
    }
    
    private func parseOPFFile(_ opfURL: URL, chapterNumber: Int, completion: @escaping (URL?) -> Void) {
        if let opfParser = XMLParser(contentsOf: opfURL) {
            opfParser.delegate = self
            opfParser.parse()
            if chapterNumber < spineItems.count, let chapterPath = manifestItems[spineItems[chapterNumber]] {
                let chapterFullPath = "OEBPS/\(chapterPath)"
                let chapterURL = unzipDirectory.appendingPathComponent(chapterFullPath)
                completion(chapterURL)
            } else {
                completion(nil)
            }
        } else {
            completion(nil)
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String] = [:]) {
        if elementName == "itemref", let idref = attributeDict["idref"] {
            spineItems.append(idref)
        } else if elementName == "item", let itemId = attributeDict["id"], let href = attributeDict["href"] {
            manifestItems[itemId] = href
        }
    }
}
