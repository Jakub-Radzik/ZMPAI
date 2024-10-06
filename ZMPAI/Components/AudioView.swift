import SwiftUI
import AVFoundation

struct AudioView: View {
    let audioName: String
    
    @State private var audioPlayer: AVAudioPlayer?
    @State internal var isPlaying = false // Change to internal

    func playMP3FromAssets() {
        if let asset = NSDataAsset(name: audioName) {
            do {
                audioPlayer = try AVAudioPlayer(data: asset.data)
                audioPlayer?.play()
                isPlaying = true
            } catch {
                print("Error: Couldn't play the audio file from assets.")
            }
        } else {
            print("Error: Audio file not found in assets.")
        }
    }

    func stopAudio() {
        audioPlayer?.stop()
        isPlaying = false
    }
    
    func isAudioPlaying() -> Bool {
            return isPlaying
    }

    var body: some View {
        HStack {
            Button(action: {
                if isPlaying {
                    stopAudio()
                } else {
                    playMP3FromAssets()
                }
            }) {
                Image(systemName: isPlaying ? "stop.circle.fill" : "play.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(isPlaying ? .red : .blue)
            }
            .accessibilityIdentifier("toggleButton")
            Text("Odtwórz darmowy rozdział")
        }
        .padding()
    }
}


#Preview {
    AudioView(audioName: "lotr_audio")
}
