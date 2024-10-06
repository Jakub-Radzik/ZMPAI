import SwiftUI
import XCTest
import AVFoundation

@testable import ZMPAI

final class AudioViewTests: XCTestCase {
    
    func testAudioView() throws {
        let app = XCUIApplication()
        app.launchArguments = ["-audioView"]
        app.launch()
        
        let playButton = app.buttons["toggleButton"]
        XCTAssertTrue(playButton.exists, "Play button should exist in the AudioView")

        playButton.tap()
        
        let stopButton = app.buttons["stop.circle.fill"]
        XCTAssertTrue(stopButton.exists, "Stop button should exist after tapping play button")
        
        stopButton.tap()
        
        XCTAssertTrue(playButton.exists, "Play button should exist again after stopping audio")
    }
}
