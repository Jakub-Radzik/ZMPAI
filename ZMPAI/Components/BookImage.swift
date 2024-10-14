import SwiftUI

struct BookImage: View {
    let bookImage: String
    let width: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: bookImage)) { imagePhase in
            switch imagePhase {
                case .empty:
                    ProgressView()
                        .frame(width: 20, height: 40)
                        .background(Color.gray.opacity(0.2))

                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: width)
                    
                case .failure:
                    Image(systemName: "exclamationmark.triangle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 40)
                        .foregroundColor(.red)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)

                @unknown default:
                    EmptyView()
                }
        }
        .clipped()
    }
}
