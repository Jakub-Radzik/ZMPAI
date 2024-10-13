import SwiftUI

struct EmptyBooksView: View {
    var message: String
    var imageName: String

    var body: some View {
        VStack {
            Text(message)
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.bottom, 8)

            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .multilineTextAlignment(.center)
    }
}
