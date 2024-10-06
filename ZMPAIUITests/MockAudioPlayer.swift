import AVFoundation

class MockAudioPlayer: AVAudioPlayer {
    var didPlay = false
    var didStop = false

    override func play() -> Bool {
        didPlay = true
        return true
    }

    override func stop() {
        didStop = true
    }
}
