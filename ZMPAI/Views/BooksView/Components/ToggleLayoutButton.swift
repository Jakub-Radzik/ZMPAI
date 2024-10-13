import SwiftUI

struct ToggleLayoutButton: View {
    @Binding var isTwoColumnLayout: Bool

    var body: some View {
        Button(action: {
            isTwoColumnLayout.toggle()
        }) {
            Image(systemName: isTwoColumnLayout ? "square.split.1x2.fill" : "square.split.2x2.fill")
                .foregroundColor(.blue)
        }
    }
}
