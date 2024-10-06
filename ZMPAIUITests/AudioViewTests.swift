import XCTest
import SwiftUI
import AVFoundation
@testable import ZMPAI

final class AudioViewTests: XCTestCase {
    
    func testAudioViewPlayButton() {
        let audioView = AudioView(audioName: "lotr_audio")
        let hostingController = UIHostingController(rootView: audioView)

        XCTAssertFalse(audioView.isAudioPlaying(), "Audio should not be playing initially.")
        
        audioView.playMP3FromAssets()
        
        XCTAssertTrue(audioView.isAudioPlaying(), "Audio should be playing after the button is tapped.")
        
        let playImage = audioView.isAudioPlaying() ? "stop.circle.fill" : "play.circle.fill"
        XCTAssertEqual(playImage, "stop.circle.fill", "The button should display the stop image when audio is playing.")
    }

    func testAudioViewStopButton() {
        let audioView = AudioView(audioName: "lotr_audio")
        let hostingController = UIHostingController(rootView: audioView)

        audioView.playMP3FromAssets()
        
        XCTAssertTrue(audioView.isAudioPlaying(), "Audio should be playing after the button is tapped.")
        
        audioView.stopAudio()
        
        XCTAssertFalse(audioView.isAudioPlaying(), "Audio should not be playing after the stop button is tapped.")
        
        let stopImage = audioView.isAudioPlaying() ? "stop.circle.fill" : "play.circle.fill"
        XCTAssertEqual(stopImage, "play.circle.fill", "The button should display the play image when audio is stopped.")
    }
}
